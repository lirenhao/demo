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
    private String dictCodeName;
    @Column
    private String dictPinyin;
    @Column
    private String dictOrder;
    @Column
    private String dictFlag;
    @Column
    private String dictCodeParent;

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

    public String getDictCodeName() {
        return dictCodeName;
    }

    public void setDictCodeName(String dictCodeName) {
        this.dictCodeName = dictCodeName;
    }

    public String getDictPinyin() {
        return dictPinyin;
    }

    public void setDictPinyin(String dictPinyin) {
        this.dictPinyin = dictPinyin;
    }

    public String getDictOrder() {
        return dictOrder;
    }

    public void setDictOrder(String dictOrder) {
        this.dictOrder = dictOrder;
    }

    public String getDictFlag() {
        return dictFlag;
    }

    public void setDictFlag(String dictFlag) {
        this.dictFlag = dictFlag;
    }

    public String getDictCodeParent() {
        return dictCodeParent;
    }

    public void setDictCodeParent(String dictCodeParent) {
        this.dictCodeParent = dictCodeParent;
    }
}