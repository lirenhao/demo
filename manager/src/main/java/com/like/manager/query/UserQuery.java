package com.like.manager.query;

import com.like.manager.model.User;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.LinkedList;
import java.util.List;

public class UserQuery implements Specification<User> {
    /**
     * 分组ID
     */
    private String userGrpId;
    /**
     * 登录名
     */
    private String loginName;
    /**
     * 用户ID
     */
    private Long userId;
    /**
     * 密码
     */
    private String pwd;
    /**
     * 机构
     */
    private String orgId;
    /**
     * 状态
     */
    private String status;
    /**
     * 登陆用户机构ID
     */
    private String LocalOrgId;

    public String getUserGrpId() {
        return userGrpId;
    }

    public void setUserGrpId(String userGrpId) {
        this.userGrpId = userGrpId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLocalOrgId() {
        return LocalOrgId;
    }

    public void setLocalOrgId(String localOrgId) {
        LocalOrgId = localOrgId;
    }

    @Override
    public String toString() {
        return "UserQuery{" +
                "userGrpId='" + userGrpId + '\'' +
                ", loginName='" + loginName + '\'' +
                ", userId=" + userId +
                ", pwd='" + pwd + '\'' +
                ", orgId='" + orgId + '\'' +
                ", status='" + status + '\'' +
                ", LocalOrgId='" + LocalOrgId + '\'' +
                '}';
    }

    @Override
    public Predicate toPredicate(Root<User> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder cb) {
        List<Predicate> list = new LinkedList<>();

        if (userGrpId != null && !"".equals(userGrpId.trim())) {
            list.add(cb.equal(root.join("userGrp").get("userGrpId").as(String.class), userGrpId));
        }
        if (loginName != null && !"".equals(loginName.trim())) {
            list.add(cb.equal(root.get("loginName").as(String.class), loginName));
        }
        if (userId != null) {
            list.add(cb.equal(root.get("userId").as(String.class), userId));
        }
        if (pwd != null && !"".equals(pwd.trim())) {
            list.add(cb.equal(root.get("pwd").as(String.class), pwd));
        }
        if (orgId != null && !"".equals(orgId.trim())) {//必须是本机构或下属机构
            list.add(cb.like(root.join("org").get("orgId").as(String.class), orgId+"%"));
        }
        if (orgId != null && !"".equals(orgId.trim())) {//精确机构查询
            list.add(cb.equal(root.join("org").get("orgId").as(String.class), orgId));
        }
        if (status != null && !"".equals(status.trim())) {
            list.add(cb.equal(root.get("status").as(String.class), status));
        }
        list.add(cb.notEqual(root.join("userGrp").get("userGrpId").as(String.class), 1l));
        if (list.size() > 0) {
            criteriaQuery.where(list.toArray(new Predicate[list.size()]));
        }
        return criteriaQuery.getRestriction();
    }
}
