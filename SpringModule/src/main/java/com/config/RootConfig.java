package com.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

import com.config.datasource.ContextDataSource;
import com.config.datasource.ContextSqlMapper;


@Configuration
@Import({ContextDataSource.class, ContextSqlMapper.class})
@ComponentScan(basePackages = {"com.**"})
public class RootConfig {

}
