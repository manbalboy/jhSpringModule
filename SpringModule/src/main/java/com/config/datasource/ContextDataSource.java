package com.config.datasource;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
//아노 테이션 기반 트랜잭션 관리를 사용 합니다.
//<tx:annotation-driven>
@EnableTransactionManagement
public class ContextDataSource {
    @Value("${db.user}")
    private String db;
    @Value("${db.pw}")
    private String pw;
    //Mysql
//	@Bean(destroyMethod="close")
//	public DataSource dataSource() {
//		BasicDataSource dataSource = new BasicDataSource();
//		dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
//		dataSource.setUrl("jdbc:mysql://manbalboy.iptime.org:3306/spring?serverTimezone=UTC");
//		dataSource.setUsername("spring");
//		dataSource.setPassword("qwer1234");
//		dataSource.setDefaultAutoCommit(false);
//		return dataSource;
//	}

//	@Bean
//	public Log4jdbcProxyDataSource log4jdbcProxyDataSource(DataSource dataSource) {
//System.out.println(">>>");
//		Log4JdbcCustomFormatter logFormatter = new Log4JdbcCustomFormatter();
//		logFormatter.setLoggingType(LoggingType.MULTI_LINE);
//		logFormatter.setSqlPrefix("SQL ::: ");
//		logFormatter.setMargin(8);
//
//		Log4jdbcProxyDataSource log4jdbcProxyDataSource = new Log4jdbcProxyDataSource(dataSource);
//		log4jdbcProxyDataSource.setLogFormatter(logFormatter);
//
//		return log4jdbcProxyDataSource;
//	}

    //ORACLE
    @Bean(destroyMethod="close")
    public DataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
        dataSource.setUrl("jdbc:log4jdbc:oracle:thin:@java-coder.co.kr:18903/orcl");
        dataSource.setUsername(db);
        dataSource.setPassword(pw);
        dataSource.setDefaultAutoCommit(false);
        return dataSource;
    }

    /**
     * 트랜잭션 매니저 등록
     * @return
     */
    @Bean
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource());
    }

}
