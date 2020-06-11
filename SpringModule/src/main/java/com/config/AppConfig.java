package com.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import com.config.interceptor.AnotherInterceptor;
import com.config.interceptor.GreetingInterceptor;
import com.config.resolvers.DownloadView;
import com.config.resolvers.Jaxb2MarshallingXmlViewResolver;
import com.config.resolvers.JsonViewResolver;
import com.config.resolvers.PdfViewResolver;
import com.demo1.model.Pizza;



/**
 * @author      : 정훈
 * @Version     : 0.1
 * @Date        : 2020. 5. 31. 오후 11:44:02
 * @NAME        : AppConfig
 * @Description :
 */
@Configuration
@EnableWebMvc
@ComponentScan(value= "com")
@PropertySources({@PropertySource("classpath:static/config.properties"),@PropertySource("classpath:static/db.properties")})
public class AppConfig implements WebMvcConfigurer  {

    /**
     * interceptor 등록
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //등록 된 순서대로 order
        registry.addInterceptor(new AnotherInterceptor());
        registry.addInterceptor(new GreetingInterceptor());

        //이렇게 order 적용가능 낮은숫자가 우선순위
        //registry.addInterceptor(new AnotherInterceptor()).order(-1);
        //registry.addInterceptor(new GreetingInterceptor()).order(0);

        //특정한 패턴에만 인터셉터를 적용할수 있음
        //registry.addInterceptor(new AnotherInterceptor()).order(-1);
        //registry.addInterceptor(new GreetingInterceptor()).addPathPatterns("/systems").order(0);

        //기본셋팅을 지울거라면 아래의 소스를 주석
        WebMvcConfigurer.super.addInterceptors(registry);
    }


    /**
     * 정적자원 리소스 핸들러
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resource/**").addResourceLocations("classpath:/static/","/");

        // file:/Users/manbalboy/files/ : 파일 패스
        // /static/  -> webapp 정적자원
        //registry.addResourceHandler("/resource2/**").addResourceLocations("file:/Users/manbalboy/files/", "classpath:/static/");

        //기본셋팅을 지울거라면 아래의 소스를 주석
        //WebMvcConfigurer.super.addResourceHandlers(registry);
    }





    /*
     * Configure ContentNegotiatingViewResolver
     */
    @Bean
    public ViewResolver contentNegotiatingViewResolver(ContentNegotiationManager manager) {
        ContentNegotiatingViewResolver resolver = new ContentNegotiatingViewResolver();
        resolver.setContentNegotiationManager(manager);

        // Define all possible view resolvers
        List<ViewResolver> resolvers = new ArrayList<ViewResolver>();
        TilesViewResolver viewResolver = new TilesViewResolver();
        resolvers.add(viewResolver);

        resolvers.add(jspViewResolver());
        resolvers.add(jsonViewResolver());
        resolvers.add(pdfViewResolver());
//        resolvers.add(excelViewResolver());
        resolvers.add(jaxb2MarshallingXmlViewResolver());

        resolver.setViewResolvers(resolvers);
        return resolver;
    }

    /*
     * JSP ViewResolver
     */
    @Bean
    public ViewResolver jspViewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/view/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

    /**
     * TODO : xml 구현안했음 jaxb 연구해야함
     */
    @Bean
    public ViewResolver jaxb2MarshallingXmlViewResolver() {
        Jaxb2Marshaller marshaller = new Jaxb2Marshaller();
        marshaller.setClassesToBeBound(Pizza.class);
        return new Jaxb2MarshallingXmlViewResolver(marshaller);
    }


    /**
     * JACKSON library 를 통한 JSON output 리졸버
     */
    @Bean
    public ViewResolver jsonViewResolver() {
        return new JsonViewResolver();
    }


    /**
     * TODO : PDF 공통화작업 필요 AppController 에 샘플
     */
    @Bean
    public ViewResolver pdfViewResolver() {
        return new PdfViewResolver();
    }

    /**
     * TODO : 엑셀 구현 안했음. 테스트시 실패 했음 POI 연구해야함
     */
//    @Bean
//    public ViewResolver excelViewResolver() {
//        return new ExcelViewResolver();
//    }

    @Bean
    public View downloadView() {
        return new DownloadView();
    }


    //JAVA Tiles CONFIG
//    @Bean
//    public TilesViewResolver getTilesViewResolver() {
//        TilesViewResolver tilesViewResolver = new TilesViewResolver();
//        tilesViewResolver.setViewClass(TilesView.class);
//        return tilesViewResolver;
//    }
//    @Bean
//    public TilesConfigurer getTilesConfigurer() {
//        TilesConfigurer tilesConfigurer = new TilesConfigurer();
//        tilesConfigurer.setCheckRefresh(true);
//        tilesConfigurer.setDefinitionsFactoryClass(TilesDefinitionsConfig.class);
//
//        // Add apache tiles definitions
//        TilesDefinitionsConfig.addDefinitions();
//
//        return tilesConfigurer;
//    }


    @Bean
    public TilesConfigurer tilesConfigurer(){
         String[] tilesDefinitions = {"/WEB-INF/tiles-definitions/tiles.xml"};
        TilesConfigurer tilesConfigurer = new TilesConfigurer();
        tilesConfigurer.setDefinitions(tilesDefinitions);
        tilesConfigurer.setCheckRefresh(true);
        return tilesConfigurer;
    }

    // 파일업로드 리졸버
    @Bean
    public MultipartResolver multipartResolver() {
       StandardServletMultipartResolver multipartResolver = new StandardServletMultipartResolver();
       return multipartResolver;
    }


}
