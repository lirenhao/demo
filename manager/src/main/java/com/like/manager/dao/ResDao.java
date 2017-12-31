package com.like.manager.dao;

import com.like.manager.model.Res;

import java.util.List;

public interface ResDao extends BaseDao<Res, Long> {

    public List<Res> findByResTypeNameAndResNullOrderByOrderNo(String typeName);
}
