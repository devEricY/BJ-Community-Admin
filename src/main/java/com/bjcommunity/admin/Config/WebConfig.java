package com.bjcommunity.admin.Config;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload.urlPath}")
    private String fileUrl;

    @Value("${file.upload.directory}")
    private String fileDirectory;

    @Value("${server.status.name}")
    private String server_status;

    @Bean
    public FilterRegistrationBean<XssEscapeServletFilter> filterRegistrationBean() {
        FilterRegistrationBean<XssEscapeServletFilter> filterRegistration = new FilterRegistrationBean<>();
        filterRegistration.setFilter(new XssEscapeServletFilter());
        filterRegistration.setOrder(1);
        filterRegistration.addUrlPatterns("/*");

        return filterRegistration;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        if(server_status.equals("prod")){
            registry.addResourceHandler(fileUrl + "/**").addResourceLocations("file://" + fileDirectory);
        }
    }
}