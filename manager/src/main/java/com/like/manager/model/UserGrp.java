package com.like.manager.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "T_P_SHIRO_USER_GRP")
public class UserGrp {
    public static final String TABLE_ALIAS = "用户分组";
    public static final String ALIAS_NAME = "用户分组名称";
    public static final String ALIAS_USER_GRP_ID = "用户分组ID";
    public static final String ALIAS_ORG_ID = "机构";
    public static final String ALIAS_RUNTIME_LIMIT_FLAG = "工作日期限制标志";
    public static final String ALIAS_IHT_FLAG = "继承标志";

    /**
     * 用户分组ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "USER_GRP_ID", nullable = false)
    private Long userGrpId;
    /**
     * 名称
     */
    @Column(name = "NAME", nullable = false, length = 64)
    private String name;
    /**
     * 机构
     */
    @Column(name = "ORG_ID", nullable = false, length = 16)
    private String orgId;
    /**
     * 工作日期限制标志
     */
    @Column(name = "RUNTIME_LIMIT_FLAG", length = 1)
    private String runtimeLimitFlag;
    /**
     * 继承标志(0:可以继承,1:不可继承)
     */
    @Column(name = "IHT_FLAG", nullable = false, length = 1)
    private String ihtFlag;
    /**
     * 用户
     */
    @OneToMany(mappedBy = "userGrp")
    private List<User> users;
    /**
     * 角色
     */
    @ManyToMany
    @JoinTable(name = "USER_GRP_ROLE", joinColumns = @JoinColumn(name = "USER_GRP_ID"),
            inverseJoinColumns = @JoinColumn(name = "ROLE_ID"))
    private List<Role> roles;

    public Long getUserGrpId() {
        return userGrpId;
    }

    public void setUserGrpId(Long userGrpId) {
        this.userGrpId = userGrpId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getRuntimeLimitFlag() {
        return runtimeLimitFlag;
    }

    public void setRuntimeLimitFlag(String runtimeLimitFlag) {
        this.runtimeLimitFlag = runtimeLimitFlag;
    }

    public String getIhtFlag() {
        return ihtFlag;
    }

    public void setIhtFlag(String ihtFlag) {
        this.ihtFlag = ihtFlag;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

}
