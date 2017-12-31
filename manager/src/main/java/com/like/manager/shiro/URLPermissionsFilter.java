package com.like.manager.shiro;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class URLPermissionsFilter extends PermissionsAuthorizationFilter {

    @Override
    public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        String curUrl = req.getRequestURI().replaceAll(req.getContextPath(), "");
        //用户
        Subject subject = getSubject(request, response);
        return subject.isPermitted(curUrl);
    }

}