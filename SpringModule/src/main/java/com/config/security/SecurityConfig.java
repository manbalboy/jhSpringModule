package com.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.expression.SecurityExpressionHandler;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.access.expression.DefaultWebSecurityExpressionHandler;

import com.demo1.biz.user.service.impl.UserServiceImpl;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    UserServiceImpl userServiceImpl;


    public SecurityExpressionHandler expressionHandler() {

        System.out.println(">>>>>>>>>>>>>>>");
        RoleHierarchyImpl roleHierarchy = new RoleHierarchyImpl();

        roleHierarchy.setHierarchy("ROLE_ADMIN > ROLE_USER");
        DefaultWebSecurityExpressionHandler handler = new DefaultWebSecurityExpressionHandler();
        //handler.setRoleHierarchy(roleHierarchy);

        return handler;
    }



    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
        .mvcMatchers("/home1").permitAll()
        .mvcMatchers("/**").hasRole("MANAGER").expressionHandler(expressionHandler());
        //http.authorizeRequests().antMatchers("/**").hasRole("MANAGER").expressionHandler(expressionHandler());


     // TODO : 특정페이지만 제거 해야함. csrf 체크 취소
        http.csrf().disable();

        // TODO : 로그인페이지 커스텀 진행중
        http.formLogin().loginPage("/login").permitAll();
        //http.antMatcher("/home1").anonymous();
        //http.exceptionHandling().accessDeniedPage("/accessDenied");
        http.logout().logoutUrl("/logout").invalidateHttpSession(true);
        http.httpBasic();

        // TODO : 특정페이지만 제거 해야함. 해더 옵션 취소
        http.headers().frameOptions().disable();



        http.exceptionHandling()
        .accessDeniedHandler((request, response, accessDeniedException) -> {

            UserDetails principal = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = principal.getUsername();
            System.out.println(username + " is denied to access " + request.getRequestURI());
            response.sendRedirect("/access-denied");
        });

    }

    @Override
    public void configure(WebSecurity web) throws Exception {
         web.ignoring().antMatchers("/resource/static/**");
    }

//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//        // TODO : DB로 불러오는 방법 연구
//        // {noop} 은 인코더 형식
//        auth.inMemoryAuthentication().withUser("manager").password("{noop}1111").roles("MANAGER").and().withUser("csg")
//                .password("{noop}csg").roles("MANAGER").and().withUser("pse").password("{noop}pse").roles("MANAGER")
//                .and().withUser("jh").password("{noop}jh").roles("MANAGER");
//    }

    @Override
    protected UserDetailsService userDetailsService() {
        // TODO Auto-generated method stub
        return super.userDetailsService();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userServiceImpl);
    }

}
