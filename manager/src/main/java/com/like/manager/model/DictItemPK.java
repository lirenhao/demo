package com.like.manager.model;

import java.io.Serializable;

public class DictItemPK implements Serializable {

    private String dictType;
    private String dictCode;


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

}
