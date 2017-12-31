package com.like.manager.dao;

import com.like.manager.model.Permit;

import java.util.List;

public interface PermitDao extends BaseDao<Permit,Long> {

    List<Permit> findByResId(Long id);
}
