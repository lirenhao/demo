package com.like.manager.service;

import com.like.manager.dao.OrgDao;
import com.like.manager.dao.UserDao;
import com.like.manager.dao.UserGrpDao;
import com.like.manager.model.Org;
import com.like.manager.model.User;
import com.like.manager.model.UserGrp;
import com.like.manager.query.UserQuery;
import com.like.manager.util.Md5KeyBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private UserGrpDao userGrpDao;
    @Autowired
    private OrgDao orgDao;

    /**
     * 增加用户
     */
    public void save(User user, User loginUser) {
        if (user.getUserId() == null || "".equals(user.getUserId())) {
            //添加创建时间
            user.setCreateDateTime(getCurrTime());
            //添加创建人id
            user.setCreateUserId(loginUser.getUserId().toString());
            //密码加密
            Md5KeyBean md5 = new Md5KeyBean();
            user.setPwd(md5.getkeyBeanofStr(user.getPwd()));
        }
        if (user.getOrg() == null || user.getOrg().getOrg() == null || "".equals(user.getOrg().getOrgId())) {
            user.setOrg(loginUser.getOrg());
        }
        userDao.saveAndFlush(user);
    }

    /**
     * 删除用户
     *
     * @author csj
     */
    public void delete(Long userId) {
        userDao.delete(userId);
    }

    /**
     * 根据登录名查询
     *
     * @author csj
     */
    public User findUserByLoginName(String loginName) {
        return userDao.findByLoginName(loginName);
    }

    /**
     * 根据分组id查询
     *
     * @author csj
     */
    public List<User> findByUserGrp_UserGrpId(Long userGrpId) {
        return userDao.findByUserGrp_UserGrpId(userGrpId);
    }

    /**
     * 分页动态查询
     *
     * @author csj
     */
    public Page<User> queryPage(UserQuery query, Pageable pageable) {
        return userDao.findAll(query, pageable);
    }

    /**
     * 重置密码.默认密码:111111,加密.记录更新时间
     */
    public void resetUserPwd(Long userId) {
        //加密默认密码:111111
        User user = userDao.findOne(userId);
        Md5KeyBean md5 = new Md5KeyBean();
        //重置
        user.setPwd(md5.getkeyBeanofStr("111111"));
        //记录更新时间
        user.setLastChgPwdDateTime(getCurrTime());
        //保存
        userDao.saveAndFlush(user);
    }

    /**
     * 更新密码.加密.记录更新时间
     */
    public void updatePwd(Long userId, String newPwd) {
        User tempUser = userDao.findOne(userId);
        Md5KeyBean md5 = new Md5KeyBean();
        //修改
        tempUser.setPwd(md5.getkeyBeanofStr(newPwd));
        //记录更新时间
        tempUser.setLastChgPwdDateTime(getCurrTime());
        //保存
        userDao.saveAndFlush(tempUser);
    }

    /**
     * 根据userId获取用户
     */
    public User getById(Long userId) {
        return userDao.findOne(userId);
    }

    /**
     * 关闭或开启用户.更新t_p_shiro_user_ext.status
     * 用户状态(0:停用,1启用)
     * flag：为true要开启用户，为false要关闭用户
     */
    public void openOrCloseUser(Long userId, boolean flag) {
        User user = userDao.findOne(userId);
        if (flag) {
            user.setStatus("1");
        } else {
            user.setStatus("0");
        }
        userDao.saveAndFlush(user);
    }

    /**
     * 保存重新分配用户分组和机构
     */
    public void assignUserGrpOrOrg(Long userId, String userGrpId, String orgId) {
        //分配
        User tempUser = userDao.findOne(userId);
        if (userGrpId != null && !"".equals(userGrpId.trim())) {
            UserGrp userGrp = userGrpDao.findOne(Long.parseLong(userGrpId));
            tempUser.setUserGrp(userGrp);
        }
        if (orgId != null && !"".equals(orgId.trim())) {
            Org org = orgDao.findOne(orgId);
            tempUser.setOrg(org);
        }
        userDao.saveAndFlush(tempUser);
    }
    /**
     * 根据查询登陆名的个数验证登陆名是否存在
     *
     * @author csj
     */
    public String countByLoginName(String loginName){
       int num=userDao.countByLoginName(loginName);
       return String.valueOf(num);
    }

    /**
     * 当前系统时间.
     *
     * @return 8位日期+6位时间
     */
    private String getCurrTime() {
        return new SimpleDateFormat("yyyyMMddhhmmss").format(new Date());
    }

}
