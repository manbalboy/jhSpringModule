package com.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.config.datasource.ContextDataSource;
import com.config.datasource.ContextSqlMapper;


@Configuration
@Import({ContextDataSource.class, ContextSqlMapper.class})
@ComponentScan(basePackages = {"com.**"})
public class RootConfig {
 @Bean
 public PasswordEncoder passwordEncoder () {

     Map encoders = new HashMap<>();
     encoders.put("noop" , NoOpPasswordEncoder.getInstance());
     encoders.put("bcypt" , new BCryptPasswordEncoder());
     PasswordEncoder passwordEncoder = new DelegatingPasswordEncoder("noop", encoders);
     return passwordEncoder;
 };
}
