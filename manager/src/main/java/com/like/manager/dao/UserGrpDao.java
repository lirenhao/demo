package com.like.manager.dao;

import com.like.manager.model.UserGrp;

import java.util.List;

public interface UserGrpDao extends BaseDao<UserGrp, Long> {

    // 查找本机构是可继承的且不为超级管理员的分组
    List<UserGrp> findByOrgIdAndIhtFlagAndUserGrpIdIsNot(String orgId, String ihtFlag, Long userGrpId);
}
