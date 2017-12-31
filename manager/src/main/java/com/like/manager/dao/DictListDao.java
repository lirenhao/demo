package com.like.manager.dao;

import com.like.manager.model.DictList;

import java.util.List;

public interface DictListDao extends BaseDao<DictList, String> {

    List<DictList> findByDictType(String dictType);
}
