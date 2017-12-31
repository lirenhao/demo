package com.like.manager.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.like.manager.dao.PermitDao;
import com.like.manager.dao.ResDao;
import com.like.manager.dao.RoleDao;
import com.like.manager.model.Permit;
import com.like.manager.model.Res;
import com.like.manager.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class RoleService {

    @Autowired
    private RoleDao roleDao;
    @Autowired
    private ResDao resDao;
    @Autowired
    private PermitDao permitDao;

    public void save(Role role) {
        roleDao.save(role);
    }

    public void update(Role role) {
        roleDao.save(role);
    }

    public void delete(Long id) {
        roleDao.delete(id);
    }

    public Role findOne(Long id) {
        return roleDao.findOne(id);
    }

    public List<Role> findAll() {
        return roleDao.findAll();
    }

    public Page<Role> findAll(Specification<Role> query, Pageable pageable) {
        return roleDao.findAll(query, pageable);
    }

    public void permitSave(Long id, Long[] ids) {
        Role role = roleDao.findOne(id);
        Set<Permit> permits = new HashSet<>();
        for (Long permitId : ids) {
            if (permitId != null && !"".equals(permitId.toString().trim())) {
                Permit permit = permitDao.findOne(permitId);
                if (permit != null)
                    permits.add(permit);
            }
        }
        role.setPermits(permits);
        roleDao.save(role);
    }

    /**
     * 组装前端需要的树结构
     */
    public JSONArray getPermitTree(Long id, String type) {
        Role role = roleDao.findOne(id);
        List<Res> resList = resDao.findByResTypeNameAndResNullOrderByOrderNo(type);
        JSONArray root = new JSONArray();
        for (Res res : resList) {
            root.add(getNode(res, role));
        }
        return root;
    }

    /**
     * 获取一个节点
     */
    private JSONObject getNode(Res res, Role role) {
        JSONObject node = new JSONObject();
        node.put("id", res.getId());
        List<Permit> permitList = permitDao.findByResId(res.getId());
        // 组选择的装数据源
        String source = "";
        for (Permit p : permitList) {
            source += p.getId() + ": \"" + p.getAction().getName() + "\",";
        }
        // 角色已有的权限
        String value = "";
        for (Permit p : role.getPermits()) {
            if (permitList.contains(p)) {
                value += p.getId() + ",";
            }
        }
        String text = String.format("%s<a href='#' name='permitId'" +
                        " data-title='动作' data-emptytext='选择动作'" +
                        " data-type='checklist' data-value='%s' data-source='{%s}'/>",
                res.getName(), value, source);
        node.put("text", text);
        // 添加子节点
        if (res.getChildren().size() > 0) {
            JSONArray children = new JSONArray();
            for (Res sub : res.getChildren()) {
                children.add(getNode(sub, role));
            }
            node.put("children", children);
        }
        return node;
    }
}
