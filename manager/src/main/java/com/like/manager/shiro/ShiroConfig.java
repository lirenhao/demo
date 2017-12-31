package com.like.manager.shiro;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import javax.servlet.Filter;
import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfig {

    @Bean(name = "lifecycleBeanPostProcessor")
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    @Bean(name = "shiroFilter")
    public AbstractShiroFilter shiroFilterFactoryBean() throws Exception {

        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager());

        Map<String, Filter> filters = new LinkedHashMap<>();
        filters.put("permit", new URLPermissionsFilter());
        shiroFilterFactoryBean.setFilters(filters);

        Map<String, String> filterChainDefinitionManager = new LinkedHashMap<>();
        filterChainDefinitionManager.put("/*.ico", "anon");
        filterChainDefinitionManager.put("/js/**", "anon");
        filterChainDefinitionManager.put("/css/**", "anon");
        filterChainDefinitionManager.put("/img/**", "anon");
        filterChainDefinitionManager.put("/fonts/**", "anon");
        filterChainDefinitionManager.put("/images/**", "anon");

        // 移动端的资源不校验
        filterChainDefinitionManager.put("/mer/**", "anon");
        filterChainDefinitionManager.put("/bank/**", "anon");
        filterChainDefinitionManager.put("/notify", "anon");
        filterChainDefinitionManager.put("/notify/**", "anon");

        filterChainDefinitionManager.put("/login", "anon");
        filterChainDefinitionManager.put("/login/validate", "anon");
        filterChainDefinitionManager.put("/login/getAuthCode", "anon");
        filterChainDefinitionManager.put("/login/unauthorized", "anon");

        filterChainDefinitionManager.put("/login/frame", "authc");
        filterChainDefinitionManager.put("/login/logout", "logout");

        filterChainDefinitionManager.put("/**", "authc");
        filterChainDefinitionManager.put("/**", "permit");
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionManager);

        shiroFilterFactoryBean.setLoginUrl("/login");
        shiroFilterFactoryBean.setSuccessUrl("/login/frame");
        shiroFilterFactoryBean.setUnauthorizedUrl("/login/unauthorized");

        return (AbstractShiroFilter) shiroFilterFactoryBean.getObject();
    }

    @Bean(name = "securityManager")
    public ForceLoginWebSecurityManager securityManager() {
        ForceLoginWebSecurityManager securityManager = new ForceLoginWebSecurityManager();
        securityManager.setRealm(shiroRealm());
        securityManager.setOpenForceLogin(false);
        securityManager.setCacheManager(ehCacheManager());
        securityManager.setRememberMeManager(cookieRememberMeManager());
        return securityManager;
    }

    @Bean
    public CookieRememberMeManager cookieRememberMeManager() {
        CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
        cookieRememberMeManager.setCookie(simpleCookie());
        return cookieRememberMeManager;
    }

    @Bean
    public SimpleCookie simpleCookie() {
        SimpleCookie simpleCookie = new SimpleCookie();
        simpleCookie.setName("ourRememberMe");
        simpleCookie.setHttpOnly(true);
        simpleCookie.setPath("/");
        simpleCookie.setMaxAge(86400);
        return simpleCookie;
    }

    @Bean
    public EhCacheManager ehCacheManager() {
        return new EhCacheManager();
    }

    @Bean(name = "shiroRealm")
    @DependsOn("lifecycleBeanPostProcessor")
    public ShiroRealm shiroRealm() {
        ShiroRealm realm = new ShiroRealm();
        realm.setCredentialsMatcher(hashedCredentialsMatcher());
        return realm;
    }

    @Bean(name = "hashedCredentialsMatcher")
    public HashedCredentialsMatcher hashedCredentialsMatcher() {
        HashedCredentialsMatcher credentialsMatcher = new HashedCredentialsMatcher();
        credentialsMatcher.setHashAlgorithmName("MD5");
        credentialsMatcher.setHashIterations(1);
        credentialsMatcher.setStoredCredentialsHexEncoded(true);
        return credentialsMatcher;
    }
}
