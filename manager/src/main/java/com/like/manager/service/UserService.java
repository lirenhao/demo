package com.like.manager.service;

import com.like.manager.dao.UserDao;
import com.like.manager.model.User;
import com.like.manager.query.UserQuery;
import com.like.manager.util.Md5KeyBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;

    /**
     * 增加用户
     */
    public void save(User user) {
        if (user.getId() == null || "".equals(user.getId().toString().trim())) {
            //添加创建时间
            user.setCreateDate(getCurrTime());
            //密码加密
            Md5KeyBean md5 = new Md5KeyBean();
            user.setPassWord(md5.getkeyBeanofStr(user.getPassWord()));
        }
        userDao.saveAndFlush(user);
    }

    /**
     * 删除用户
     */
    public void delete(Long userId) {
        userDao.delete(userId);
    }

    /**
     * 根据登录名查询
     */
    public User findUserByLoginName(String loginName) {
        return userDao.findByLoginName(loginName);
    }

    /**
     * 分页动态查询
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
        user.setPassWord(md5.getkeyBeanofStr("111111"));
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
        tempUser.setPassWord(md5.getkeyBeanofStr(newPwd));
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
     * 根据查询登陆名的个数验证登陆名是否存在
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
