package com.like.manager.model;

import javax.persistence.*;

@Entity
public class DictList {

    @Id
    @Column
    private String dictType;

    @Column
    private String dictTypeName;

    @Column
    private String dictFlag;

    @Column
    private String dictTableSql;

    @Column
    private String dictTableOrder;

    public String getDictType() {
        return dictType;
    }

    public void setDictType(String dictType) {
        this.dictType = dictType;
    }

    public String getDictTypeName() {
        return dictTypeName;
    }

    public void setDictTypeName(String dictTypeName) {
        this.dictTypeName = dictTypeName;
    }

    public String getDictFlag() {
        return dictFlag;
    }

    public void setDictFlag(String dictFlag) {
        this.dictFlag = dictFlag;
    }

    public String getDictTableSql() {
        return dictTableSql;
    }

    public void setDictTableSql(String dictTableSql) {
        this.dictTableSql = dictTableSql;
    }

    public String getDictTableOrder() {
        return dictTableOrder;
    }

    public void setDictTableOrder(String dictTableOrder) {
        this.dictTableOrder = dictTableOrder;
    }
}