package com.dotlamp.config;

import com.dotlamp.security.CustomAccessDeniedHandler;
import com.dotlamp.security.CustomLoginSuccessHandler;
import com.dotlamp.security.CustomUserDetailsService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import javax.sql.DataSource;


@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Setter(onMethod_ = @Autowired)
    private DataSource dataSource;

    /* 로그인 성공시 핸들러 */
	@Bean
    public AuthenticationSuccessHandler loginSuccessHandler() {
        return new CustomLoginSuccessHandler();
    }

    /* MemberMapper.xml 을 사용하기 위함*/
    @Bean
    public UserDetailsService customUserService() {
        return new CustomUserDetailsService();
    }

    @Bean
    public CustomAccessDeniedHandler customAccessDeniedHandler(){
        return new CustomAccessDeniedHandler();
    }

    /* 로그인 사용자 */
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		log.info("Security_config: configure");
		auth.userDetailsService(customUserService()).passwordEncoder(passwordEncoder());
	}

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        /* 접근제한 설정 */
        http.authorizeRequests()
                .antMatchers("/sample/all").permitAll()
                .antMatchers("/sample/member").access("hasRole('ROLE_MANAGER')")
                .antMatchers("/sample/admin").access("hasRole('ROLE_ADMIN')")
                .antMatchers("/member/list").access("principal.username == 'admin' or hasRole('ROLE_ADMIN')");
                /*.antMatchers("/member/list").access("hasRole('ROLE_ADMIN')" );*/

        /* 로그인 페이지 설정 */
		http.formLogin().loginPage("/login").loginProcessingUrl("/login").successHandler(loginSuccessHandler());
        //.successHandler(loginSuccessHandler())
        /* 로그아웃 처리 */
        http.logout().logoutSuccessUrl("/").logoutUrl("/logout").invalidateHttpSession(true).deleteCookies("remember-me", "JSESSION_ID");

        http.exceptionHandling().accessDeniedHandler(customAccessDeniedHandler());

        http.rememberMe().key("dotlamp").tokenRepository(persistentTokenRepository()).tokenValiditySeconds(604800); //토큰 유지 7일

        /* 한글깨짐 방지 */
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        http.addFilterBefore(filter, CsrfFilter.class);
    }

     /*패스워드 암호화 처리*/
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /* 자동 로그인 처리 */
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
        repo.setDataSource(dataSource);
        return repo;
    }



}
