package com.like.manager.query;

import com.like.manager.model.Role;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.LinkedList;
import java.util.List;

public class RoleQuery implements Specification<Role> {

    private String name;

    private String remark;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public Predicate toPredicate(Root<Role> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder cb) {
        List<Predicate> list = new LinkedList<>();

        if (name != null && !"".equals(name.trim())) {
            list.add(cb.equal(root.get("name").as(String.class), name));
        }
        if (remark != null && !"".equals(remark.trim())) {
            //模糊查找
            list.add(cb.like(root.get("remark").as(String.class), remark + "%"));
        }
        if (list.size() > 0) {
            criteriaQuery.where(list.toArray(new Predicate[list.size()]));
        }
        return criteriaQuery.getRestriction();
    }
}
