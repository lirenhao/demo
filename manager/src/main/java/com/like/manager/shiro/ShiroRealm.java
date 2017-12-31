package com.like.manager.shiro;

import com.like.manager.model.Permit;
import com.like.manager.model.Role;
import com.like.manager.model.User;
import com.like.manager.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    /**
     * 权限认证，为当前登录的Subject授予角色和权限
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        // 获取当前登录输入的用户名
        String loginName = (String) super.getAvailablePrincipal(principalCollection);
        // 获取用户权限
        User user = userService.findUserByLoginName(loginName);
        if (user != null) {
            //权限信息对象info,用来存放查出的用户的所有的角色（role）及权限（permission）
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            for (Role role : user.getRoles()) {
                for (Permit permit : role.getPermits()) {
                    // 判断资源是否可用
                    if (permit.getRes().getAction() != null
                            && !"".equals(permit.getRes().getAction())
                            && "url".equals(permit.getResType().getName())
                            && "可操作".equals(permit.getAction().getName()))
                        info.addStringPermission(permit.getRes().getName());
                }
            }
            return info;
        }
        return null;
    }

    /**
     * 登录认证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        // 查出是否有此用户
        User user = userService.findUserByLoginName(token.getUsername());
        if (user != null) {
            // 若存在，将此用户存放到登录认证info中，无需自己做密码对比，Shiro会为我们进行密码对比校验
            return new SimpleAuthenticationInfo(user.getLoginName(), user.getPassWord(), getName());
        }
        return null;
    }


}
