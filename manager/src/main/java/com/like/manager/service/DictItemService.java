package com.like.manager.service;

import com.like.manager.dao.DictItemDao;
import com.like.manager.model.DictItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DictItemService {

    @Autowired
    private DictItemDao dictItemDao;

    public List<DictItem> findByDicttype(String dicttype) {
        return dictItemDao.findByDictType(dicttype);
    }
}
