package com.like.manager.model;

import javax.persistence.*;
import java.util.List;

@Entity
public class User {
    public static final String TABLE_ALIAS = "用户";
    public static final String ALIAS_USER_ID = "用户ID";
    public static final String ALIAS_USER_GRP_ID = "用户分组";
    public static final String ALIAS_LOGIN_NAME = "登录名";
    public static final String ALIAS_USER_NAME = "用户名";
    public static final String ALIAS_PWD = "密码";
    public static final String ALIAS_ORG_ID = "机构";
    public static final String ALIAS_STAFF_ID = "staffId";
    public static final String ALIAS_LAST_LOGIN_IP_ADDR = "最后登录IP";
    public static final String ALIAS_LAST_LOGIN_DATE_TIME = "最后登录时间";
    public static final String ALIAS_LAST_LOGOUT_DATE_TIME = "最后登出时间";
    public static final String ALIAS_LOGIN_CNT = "登录总次数";
    public static final String ALIAS_LAST_CHG_PWD_DATE_TIME = "最后修改密码时间";
    public static final String ALIAS_CREATE_DATE_TIME = "创建时间";
    public static final String ALIAS_CREATE_USER_ID = "创建用户";
    public static final String ALIAS_STATUS = "用户状态";
    public static final String ALIAS_LOGIN_FAILED_CNT = "用户登录失败次数";
    public static final String ALIAS_LAST_LOGIN_FAILED_DATE_TIME = "最后登录失败时间";

    /**
     * 用户ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    /**
     * 登录名
     */
    @Column(nullable = false, unique = true, length = 32)
    private String loginName;
    /**
     * 密码
     */
    @Column
    private String passWord;
    /**
     * 用户名
     */
    @Column
    private String userName;
    /**
     * 创建时间
     */
    @Column
    private String createDate;
    /**
     * 用户状态(0:停用,1:启用)
     */
    @Column
    private String status;
    /**
     * 描述
     */
    @Column
    private String remark;
    /**
     * 角色
     */
    @ManyToMany
    @JoinTable(name = "USER_ROLE", joinColumns = @JoinColumn(name = "USER_ID"),
            inverseJoinColumns = @JoinColumn(name = "ROLE_ID"))
    private List<Role> roles;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
}
