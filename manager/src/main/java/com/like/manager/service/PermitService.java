package com.like.manager.service;

import com.like.manager.dao.PermitDao;
import com.like.manager.model.Permit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermitService {

    @Autowired
    private PermitDao permitDao;

    public List<Permit> findAll() {
        return permitDao.findAll();
    }
}
