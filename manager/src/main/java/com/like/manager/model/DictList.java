package com.like.manager.model;

import javax.persistence.*;

@Entity
public class DictList {

    @Id
    @Column
    private String dictType;
    @Column
    private String dictName;

    public String getDictType() {
        return dictType;
    }

    public void setDictType(String dictType) {
        this.dictType = dictType;
    }

    public String getDictName() {
        return dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName;
    }
}