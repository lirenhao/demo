package com.like.manager.service;

import com.like.manager.dao.DictListDao;
import com.like.manager.model.DictList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DictListService {

    @Autowired
    private DictListDao dictListDao;

    public List<DictList> findAll() {
        return dictListDao.findAll();
    }

    public List<DictList> findByDicttype(String dictType) {
        return dictListDao.findByDictType(dictType);
    }
}
