package com.like.manager.model;

import javax.persistence.*;

@Entity
@Table(uniqueConstraints = {@UniqueConstraint(columnNames = "LOGIN_NAME")})
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
    @Column(name = "USER_ID", nullable = false)
    private Long userId;
    /**
     * 登录名
     */
    @Column(name = "LOGIN_NAME", nullable = false, unique = true, length = 32)
    private String loginName;
    /**
     * 密码
     */
    @Column(name = "PWD", length = 32)
    private String pwd;
    /**
     * 用户名
     */
    @Column(name = "USER_NAME", length = 32)
    private String userName;
    /**
     * 描述
     */
    @Column(name = "REMARK", length = 128)
    private String remark;
    /**
     * 电话
     */
    @Column(name = "PHONE_NO", length = 16)
    private String phoneNo;

    /**
     * 员工号
     */
    @Column(name = "STAFF_ID")
    private Long staffId;
    /**
     * 最后登录IP
     */
    @Column(name = "LAST_LOGIN_IP_ADDR", length = 15)
    private String lastLoginIpAddr;
    /**
     * 最后登录时间
     */
    @Column(name = "LAST_LOGIN_DATE_TIME", length = 14)
    private String lastLoginDateTime;
    /**
     * 最后登出时间
     */
    @Column(name = "LAST_LOGOUT_DATE_TIME", length = 14)
    private String lastLogoutDateTime;
    /**
     * 登录总次数
     */
    @Column(name = "LOGIN_CNT")
    private Long loginCnt;
    /**
     * 最后修改密码时间
     */
    @Column(name = "LAST_CHG_PWD_DATE_TIME", length = 14)
    private String lastChgPwdDateTime;
    /**
     * 创建时间
     */
    @Column(name = "CREATE_DATE_TIME", length = 14)
    private String createDateTime;
    /**
     * 创建用户
     */
    @Column(name = "CREATE_USER_ID")
    private String createUserId;
    /**
     * 用户状态(0:停用,1:启用)
     */
    @Column(name = "STATUS", length = 1)
    private String status;
    /**
     * 用户登录失败次数
     */
    @Column(name = "LOGIN_FAILED_CNT")
    private Long loginFailedCnt;
    /**
     * 最后登录失败时间
     */
    @Column(name = "LAST_LOGIN_FAILED_DATE_TIME", length = 14)
    private String lastLoginFailedDateTime;
    /**
     * 用户分组
     */
    @ManyToOne
    @JoinColumn(name = "USER_GRP_ID", referencedColumnName = "USER_GRP_ID")
    private UserGrp userGrp;
    /**
     * 机构
     */
    @ManyToOne
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ORG_ID")
    private Org org;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public Long getStaffId() {
        return staffId;
    }

    public void setStaffId(Long staffId) {
        this.staffId = staffId;
    }

    public String getLastLoginIpAddr() {
        return lastLoginIpAddr;
    }

    public void setLastLoginIpAddr(String lastLoginIpAddr) {
        this.lastLoginIpAddr = lastLoginIpAddr;
    }

    public String getLastLoginDateTime() {
        return lastLoginDateTime;
    }

    public void setLastLoginDateTime(String lastLoginDateTime) {
        this.lastLoginDateTime = lastLoginDateTime;
    }

    public String getLastLogoutDateTime() {
        return lastLogoutDateTime;
    }

    public void setLastLogoutDateTime(String lastLogoutDateTime) {
        this.lastLogoutDateTime = lastLogoutDateTime;
    }

    public Long getLoginCnt() {
        return loginCnt;
    }

    public void setLoginCnt(Long loginCnt) {
        this.loginCnt = loginCnt;
    }

    public String getLastChgPwdDateTime() {
        return lastChgPwdDateTime;
    }

    public void setLastChgPwdDateTime(String lastChgPwdDateTime) {
        this.lastChgPwdDateTime = lastChgPwdDateTime;
    }

    public String getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(String createDateTime) {
        this.createDateTime = createDateTime;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getLoginFailedCnt() {
        return loginFailedCnt;
    }

    public void setLoginFailedCnt(Long loginFailedCnt) {
        this.loginFailedCnt = loginFailedCnt;
    }

    public String getLastLoginFailedDateTime() {
        return lastLoginFailedDateTime;
    }

    public void setLastLoginFailedDateTime(String lastLoginFailedDateTime) {
        this.lastLoginFailedDateTime = lastLoginFailedDateTime;
    }

    public UserGrp getUserGrp() {
        return userGrp;
    }

    public void setUserGrp(UserGrp userGrp) {
        this.userGrp = userGrp;
    }

    public Org getOrg() {
        return org;
    }

    public void setOrg(Org org) {
        this.org = org;
    }

}
