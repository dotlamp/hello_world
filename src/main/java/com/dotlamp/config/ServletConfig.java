package com.dotlamp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.util.Properties;

@EnableWebMvc
@ComponentScan(basePackages = {"com.dotlamp.controller"})
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class ServletConfig implements WebMvcConfigurer {

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setViewClass(JstlView.class);
		bean.setPrefix("/WEB-INF/views/");
		bean.setSuffix(".jsp");
		registry.viewResolver(bean);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	/*파일 업로드 설정*/
	@Bean
	public MultipartResolver multipartResolver() {
		StandardServletMultipartResolver resolver = new StandardServletMultipartResolver();
		return resolver;
	}

	@Bean
	public JavaMailSender mailSender(){

		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);
		mailSender.setUsername("nbookgo@gmail.com");
		mailSender.setPassword("mobvwotyozlzfpsb"); //second

        Properties javaMailProperties = new Properties();

        javaMailProperties.put("mail.smtp.starttls.enable", "true");
        javaMailProperties.put("mail.smtp.auth", "true");
        javaMailProperties.put("mail.transport.protocol", "smtp");
        javaMailProperties.put("mail.debug", "true");

        mailSender.setJavaMailProperties(javaMailProperties);

		return mailSender;
	}


	
}

/*
*
*   <!-- Gmail -->
  <bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
    <property name="host" value="smtp.gmail.com" />
    <property name="port" value="587" />
    <property name="username" value="@gmail.com" />
    <property name="password" value="" />
    <property name="javaMailProperties">
    <props>
      <prop key="mail.smtp.auth">true</prop>
      <prop key="mail.smtp.starttls.enable">true</prop>
    </props>
    </property>
  </bean>
  *
  *
  *   <!-- naver mail -->
  <bean class="org.springframework.mail.javamail.JavaMailSenderImpl"
    p:host="smtp.naver.com"
    p:port="465"
    p:username=""
    p:password="">
    <property name="javaMailProperties">
    <props>
      <prop key="mail.smtp.starttls.enable">true</prop>
      <prop key="mail.smtp.auth">true</prop>
      <prop key="mail.smtps.ssl.checkserveridentity">true</prop>
      <prop key="mail.smtps.ssl.trust">*</prop>
      <prop key="mail.debug">true</prop>
      <prop key="mail.smtp.socketFactory.class">javax.net.ssl.SSLSocketFactory</prop>
    </props>
    </property>
  </bean>
  *
  *  <!-- Daum mail -->
  <bean class="org.springframework.mail.javamail.JavaMailSenderImpl"
    p:host="smtp.daum.net"
    p:port="465"
    p:username="@hanmail.net"
    p:password="">
    <property name="javaMailProperties">
    <props>
      <prop key="mail.smtp.starttls.enable">true</prop>
      <prop key="mail.smtp.auth">true</prop>
      <prop key="mail.smtps.ssl.checkserveridentity">true</prop>
      <prop key="mail.smtps.ssl.trust">*</prop>
      <prop key="mail.debug">true</prop>
      <prop key="mail.smtp.socketFactory.class">javax.net.ssl.SSLSocketFactory</prop>
      </props>
    </property>
  </bean>
  *
  * 535-5.7.8 : Username and Password not accepted. Learn more at
* gmail 2단계 인증하여 비밀번호 등록하는 법
1. https://myaccount.google.com/
2. https://accounts.google.com/b/0/SmsAuthConfig?hl=ko
	> 설정 시작
3. 재로그인
4. https://accounts.google.com/b/0/SmsAuthSettings?Setup=1
	> 전화번호 입력 후 코드 전송
	> 인증코드 입력
5. https://security.google.com/settings/security/apppasswords?pli=1
	> 기기선택과 앱(MAIL) 선택 후 생성
6. 생성된 비밀번호를 위 소스의 pwd란에 입력한다.
  * */