package com.like.manager.model;

import javax.persistence.*;
import java.util.Set;

@Entity
public class Role {
    /**
     * 角色ID
     */
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

    @ManyToMany
    @JoinTable(name = "ROLE_PERMIT", joinColumns = @JoinColumn(name = "ROLE_ID"),
            inverseJoinColumns = @JoinColumn(name = "PERMIT_ID"))
    private Set<Permit> permits;

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

    public Set<Permit> getPermits() {
        return permits;
    }

    public void setPermits(Set<Permit> permits) {
        this.permits = permits;
    }

}
