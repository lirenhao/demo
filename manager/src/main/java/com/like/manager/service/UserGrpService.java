package com.like.manager.service;

import com.like.manager.dao.UserGrpDao;
import com.like.manager.model.UserGrp;
import com.like.manager.query.UserGrpQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class UserGrpService {

    @Autowired
    private UserGrpDao userGrpDao;

    /**
     * 根据userGrpId查询
     */
    public UserGrp findOne(Long userGrpId) {
        return userGrpDao.findOne(userGrpId);
    }


    /**
     * 根据机构号查询本机构，上级可继承的，不为超级管理员的 用户分组
     * ihtFlag:继承标志(0:可以继承1:不可继承)
     * 超级管理员的userGrpId为1l
     */
    public List<UserGrp> findByOrgId(String orgId) {
        List<UserGrp> resultUserGrpList = new ArrayList<>();
        //orgId不为空
        if (orgId != null && !"".equals(orgId.trim())) {
            //超级管理员等级的且不为超级管理员的用户分组
            List<UserGrp> admUserGrpList = userGrpDao.findByOrgIdAndIhtFlagAndUserGrpIdIsNot("00", "0", 1l);
            if (admUserGrpList != null && admUserGrpList.size() > 0) {
                resultUserGrpList.addAll(admUserGrpList);
            }

            //当前机构等级
            int num = orgId.length() / 3;

            //查找上级可继承的且不为超级管理员的和本机机构的用户分组
            if (num > 0) {
                for (int i = 1; i <= num; i++) {
                    String newOrgId = orgId.substring(0, 3 * i);
                    List<UserGrp> upUserGrpList = userGrpDao.findByOrgIdAndIhtFlagAndUserGrpIdIsNot(newOrgId, "0", 1l);
                    if (upUserGrpList != null && upUserGrpList.size() > 0) {
                        resultUserGrpList.addAll(upUserGrpList);
                    }
                }
            }

            //查找本级机构不可继承的用户分组
            List<UserGrp> upUserGrpList1 = userGrpDao.findByOrgIdAndIhtFlagAndUserGrpIdIsNot(orgId, "1", 1l);
            resultUserGrpList.addAll(upUserGrpList1);

        }
        return resultUserGrpList;
    }

    /**
     * 分页查询
     */
    public Page<UserGrp> queryPage(UserGrpQuery query, Pageable pageable) {
        return userGrpDao.findAll(query, pageable);
    }

    /**
     * 保存新增分组数据
     */
    public void saveUserGrp(UserGrp userGrp) {
        userGrpDao.saveAndFlush(userGrp);
    }

}
