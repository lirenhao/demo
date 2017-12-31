package com.like.manager.dao;

import com.like.manager.model.DictItem;
import com.like.manager.model.DictItemPK;

import java.util.List;

public interface DictItemDao extends BaseDao<DictItem, DictItemPK> {

    List<DictItem> findByDictType(String dictType);
}
