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
     * 登录名
     */
    private String loginName;
    /**
     * 状态
     */
    private String status;


    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    @Override
    public Predicate toPredicate(Root<User> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder cb) {
        List<Predicate> list = new LinkedList<>();
        if (loginName != null && !"".equals(loginName.trim())) {
            list.add(cb.equal(root.get("loginName").as(String.class), loginName));
        }
        if (status != null && !"".equals(status.trim())) {
            list.add(cb.equal(root.get("status").as(String.class), status));
        }
        if (list.size() > 0) {
            criteriaQuery.where(list.toArray(new Predicate[list.size()]));
        }
        return criteriaQuery.getRestriction();
    }
}
