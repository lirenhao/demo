package com.like.manager.model;

import javax.persistence.*;

@Entity
@IdClass(DictItemPK.class)
public class DictItem {

    @Id
    @Column
    private String dictType;
    @Id
    @Column
    private String dictCode;
    @Column
    private String dictName;
    @Column
    private String dictOrder;

    public String getDictType() {
        return dictType;
    }

    public void setDictType(String dictType) {
        this.dictType = dictType;
    }

    public String getDictCode() {
        return dictCode;
    }

    public void setDictCode(String dictCode) {
        this.dictCode = dictCode;
    }

    public String getDictName() {
        return dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName;
    }

    public String getDictOrder() {
        return dictOrder;
    }

    public void setDictOrder(String dictOrder) {
        this.dictOrder = dictOrder;
    }
}