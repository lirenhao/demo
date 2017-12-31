package com.like.manager.model;

import javax.persistence.*;
import java.util.Set;

@Entity
public class ResType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    /**
     * 名称
     */
    @Column
    private String name;

    /**
     * 描述
     */
    @Column
    private String remark;

    @OneToMany(mappedBy = "resType")
    private Set<Action> actions;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public Set<Action> getActions() {
        return actions;
    }

    public void setActions(Set<Action> actions) {
        this.actions = actions;
    }
}
