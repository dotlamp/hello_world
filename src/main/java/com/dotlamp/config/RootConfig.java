package com.dotlamp.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;


@Configuration
@ComponentScan(basePackages = {"com.dotlamp.service", "com.dotlamp.task"})

@EnableScheduling
@EnableTransactionManagement
@EnableAspectJAutoProxy

@MapperScan(basePackages = {"com.dotlamp.mapper"})
public class RootConfig {

    /* Connection pool */
    @Bean
    public DataSource dataSource(){
        SimpleDriverDataSource ds = new SimpleDriverDataSource();
        /* log4jdbc-log4j2 - 파라미터값 확인 */
        ds.setDriverClass(net.sf.log4jdbc.sql.jdbcapi.DriverSpy.class); //oracle.jdbc.driver.OracleDriver.class
        ds.setUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:XE"); //jdbc:oracle:thin:@localhost:1521:XE
        ds.setUsername("book_ex");
        ds.setPassword("book_ex");
        return  ds;
    }



    /* MyBatis : Auto Connection close() */
    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSource());
        return sqlSessionFactory.getObject();
    }

    @Bean
    public DataSourceTransactionManager txManager() {
        return new DataSourceTransactionManager(dataSource());
    }

} //RootConfig