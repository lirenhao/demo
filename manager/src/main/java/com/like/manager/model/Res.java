package com.like.manager.model;

import javax.persistence.*;
import java.util.Set;

@Entity
public class Res {

    /**
     * 资源ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    /**
     * 资源图标
     */
    @Column
    private String icon;

    /**
     * 资源名称
     */
    @Column
    private String name;

    /**
     * 资源动作
     */
    @Column
    private String action;

    /**
     * 资源序号
     */
    @Column
    private Long orderNo;

    /**
     * 资源描述
     */
    @Column
    private String remark;

    /**
     * 资源类型
     */
    @ManyToOne(targetEntity = ResType.class)
    private ResType resType;

    /**
     * 资源的父级资源
     */
    @ManyToOne
    @JoinColumn(name = "P_ID", referencedColumnName = "ID")
    private Res res;

    /**
     * 资源的子级资源
     */
    @OneToMany(mappedBy = "res")
    @OrderBy("orderNo ASC")
    private Set<Res> children;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Long getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Long orderNo) {
        this.orderNo = orderNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public ResType getResType() {
        return resType;
    }

    public void setResType(ResType resType) {
        this.resType = resType;
    }

    public Res getRes() {
        return res;
    }

    public void setRes(Res res) {
        this.res = res;
    }

    public Set<Res> getChildren() {
        return children;
    }

    public void setChildren(Set<Res> children) {
        this.children = children;
    }
}
