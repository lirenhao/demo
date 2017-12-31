package com.like.manager.dao;

import com.like.manager.model.ResType;

public interface ResTypeDao extends BaseDao<ResType, Long> {

    ResType findByName(String typeName);
}
