package com.like.manager.util;

import com.like.manager.model.DictItem;
import com.like.manager.model.DictList;
import com.like.manager.service.DictItemService;
import com.like.manager.service.DictListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class DictUtil {

    private static DictListService dictListService;
    private static DictItemService dictItemService;
    private static Map<String, List<DictItem>> dictMap = new HashMap<String, List<DictItem>>();
    private static List<String> dynamicDict = new ArrayList<String>();

    @Autowired
    public void setDictListService(DictListService dictListService) {
        DictUtil.dictListService = dictListService;
    }

    @Autowired
    public void setDictItemService(DictItemService dictItemService) {
        DictUtil.dictItemService = dictItemService;
    }

    public static Map<String, List<DictItem>> getDictMap() {
        return dictMap;
    }

    public static List<DictItem> getDictByType(String dictType) {
        //模拟初始化
        List<DictItem> list = dictMap.get(dictType);
        if (list == null || list.size() == 0) {
            initDictMap(dictType);
        }
        return dictMap.get(dictType);
    }

    public static void initDictMap(String dictType) {

        List<DictList> list = null;

        try {
            if (dictType != null) {
                list = dictListService.findByDicttype(dictType);
            } else {
                list = dictListService.findAll();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (list == null && list.size() == 0) {
            return;
        }
        for (DictList dictList : list) {
            List<DictItem> dictItems = null;
            try {
                dictItems = dictItemService.findByDicttype(dictList.getDictType());
            } catch (Exception e) {
                e.printStackTrace();
            }
            dictMap.put(dictList.getDictType(), dictItems);
        }

    }

    public static void initDictMap() {
        initDictMap(null);
    }

    public static void remove(String key) {
        dictMap.remove(key);
    }

    protected static class DictMapper implements RowMapper {
        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
            DictItem dictItem = new DictItem();
            dictItem.setDictCode(rs.getString(1));
            dictItem.setDictName(rs.getString(2));
            return dictItem;
        }
    }

    public static List<String> getDynamicDict() {
        return dynamicDict;
    }

}
