package com.like.manager.model;

import javax.persistence.*;

@Entity
public class Permit {
    /**
     * 权限ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    /**
     * 菜单ID
     */
    @ManyToOne
    @JoinColumn(name="RES_ID")
    private Res res;
    /**
     * 动作ID
     */
    @ManyToOne
    @JoinColumn(name="ACTION_ID")
    private Action action;
    /**
     * 类型ID
     */
    @ManyToOne
    @JoinColumn(name="TYPE_ID")
    private ResType resType;
    /**
     * 加载顺序
     */
    @Column
    private Long orderNo;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Res getRes() {
        return res;
    }

    public void setRes(Res res) {
        this.res = res;
    }

    public Action getAction() {
        return action;
    }

    public void setAction(Action action) {
        this.action = action;
    }

    public ResType getResType() {
        return resType;
    }

    public void setResType(ResType resType) {
        this.resType = resType;
    }

    public Long getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Long orderNo) {
        this.orderNo = orderNo;
    }
}