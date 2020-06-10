package com.config;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import com.config.security.SecurityConfig;


public class SpringDispatcherServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

     private static int MAX_FILE_ZIZE = 10 * 1024 * 1024;

//	@Override
//    protected Filter[] getServletFilters() {
//        //추가할 필터 리스트를 추가한다.
//        return new Filter[]{new TestFilter()};
//    }

    @Override
    protected Class<?>[] getRootConfigClasses() {
        System.out.println("getRootConfigClasses >>>>>>>>>>>>>");
        return new Class[] { RootConfig.class, SecurityConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        System.out.println(">>>>>>>>>>>>>");
        return new Class[] { AppConfig.class };
    }

    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" };
    }

    @Override
    protected void customizeRegistration(Dynamic registration) {
         MultipartConfigElement multipartConfig = new MultipartConfigElement("/", MAX_FILE_ZIZE, MAX_FILE_ZIZE, 0);
         registration.setMultipartConfig(multipartConfig);
    }

}
