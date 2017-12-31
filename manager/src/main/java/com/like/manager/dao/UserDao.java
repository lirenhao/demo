package com.like.manager.dao;

import com.like.manager.model.User;

public interface UserDao extends BaseDao<User, Long> {

    //根据登录名查询
    User findByLoginName(String loginName);

    //login为指定值的个数
    int countByLoginName(String LoginName);
}
