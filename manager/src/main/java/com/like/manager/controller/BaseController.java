package com.like.manager.controller;

import com.like.manager.model.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

public class BaseController {

    private static final String CURUSER = "curUser";

    public User getCurUser() {
        Subject subject = SecurityUtils.getSubject();
        return (User) subject.getSession().getAttribute(CURUSER);
    }
}
