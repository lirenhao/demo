package com.like.manager.service;

import com.like.manager.dao.ResTypeDao;
import com.like.manager.model.ResType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResTypeService {

    @Autowired
    private ResTypeDao resTypeDao;

    public ResType findByName(String typeName) {
        return resTypeDao.findByName(typeName);
    }
}
