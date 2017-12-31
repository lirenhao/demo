package com.like.manager.query;

import com.like.manager.model.UserGrp;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.LinkedList;
import java.util.List;

public class UserGrpQuery implements Specification<UserGrp> {
    /**
     * 分组ID
     */
    private Long userGrpId;
    /**
     * 登录名
     */
    private String name;

    /**
     * 机构
     */
    private String orgId;

    /**
     * 查询条件机构ID
     */
    private String localOrgId;

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

    public String getLocalOrgId() {
        return localOrgId;
    }

    public void setLocalOrgId(String localOrgId) {
        this.localOrgId = localOrgId;
    }

    @Override
    public Predicate toPredicate(Root<UserGrp> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder cb) {
        List<Predicate> list = new LinkedList<>();

        if (userGrpId != null) {
            list.add(cb.equal(root.get("userGrpId").as(String.class), userGrpId));
        }
        if (name != null && !"".equals(name.trim())) {
            list.add(cb.equal(root.get("name").as(String.class), name));
        }
        if (orgId != null && !"".equals(orgId.trim())) {
            //模糊查找
            list.add(cb.equal(root.get("orgId").as(String.class), orgId));
        }
        if (localOrgId != null && !"".equals(localOrgId.trim())) {
            list.add(cb.like(root.get("orgId").as(String.class), localOrgId + "%"));
        }
        if (list.size() > 0) {
            criteriaQuery.where(list.toArray(new Predicate[list.size()]));
        }
        return criteriaQuery.getRestriction();
    }
}
