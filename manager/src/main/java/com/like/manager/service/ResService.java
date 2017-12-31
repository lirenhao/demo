package com.like.manager.service;

import com.like.manager.dao.PermitDao;
import com.like.manager.dao.ResDao;
import com.like.manager.dao.ResTypeDao;
import com.like.manager.model.Action;
import com.like.manager.model.Permit;
import com.like.manager.model.Res;
import com.like.manager.model.ResType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ResService {

    @Autowired
    private ResDao resDao;
    @Autowired
    private ResTypeDao resTypeDao;
    @Autowired
    private PermitDao permitDao;

    public void save(Res res) {
        // 保存资源
        if (res.getRes().getId() == null)
            res.setRes(null);
        res = resDao.save(res);

        // 增加permit
        ResType resType = resTypeDao.findOne(res.getResType().getId());
        for (Action action : resType.getActions()) {
            Permit permit = new Permit();
            permit.setRes(res);
            permit.setResType(resType);
            permit.setAction(action);
            permit.setOrderNo(action.getOrderNo());
            permitDao.save(permit);
        }
    }

    public void update(Res res) {
        Res resOld = resDao.findOne(res.getId());
        resOld.setName(res.getName());
        resOld.setAction(res.getAction());
        resOld.setRemark(res.getRemark());
        resOld.setIcon(res.getIcon());
        resDao.save(resOld);
    }

    //TODO 如果页面可以直接删除父节点，则此处需要修改。修改方式1：集联删除。修改方式2：遍历删除。
    public void delete(Long id) {
        // 删除permit
        List<Permit> permits = permitDao.findByResId(id);
        for (Permit permit : permits) {
            permitDao.delete(permit);
        }
        resDao.delete(id);
    }

    public List<Res> findParentByResType(String resType) {
        return resDao.findByResTypeNameAndResNullOrderByOrderNo(resType);
    }

    public Res findOne(Long id) {
        return resDao.findOne(id);
    }

    /**
     * 资源排序后保存
     */
    public void sortSave(List<Res> resList) {
        for (Res node : resList) {
            Res res = resDao.findOne(node.getId());
            res.setRes(null);
            res.setOrderNo(node.getOrderNo());
            resDao.save(res);
            sortSaveNode(node);
        }
    }

    private void sortSaveNode(Res parentRes) {
        if (parentRes.getChildren() != null && parentRes.getChildren().size() > 0) {
            for (Res node : parentRes.getChildren()) {
                Res res = resDao.findOne(node.getId());
                res.setRes(parentRes);
                res.setOrderNo(node.getOrderNo());
                resDao.save(res);
                sortSaveNode(node);
            }
        }
    }
}
