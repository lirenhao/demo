package com.like.manager.controller;

import com.alibaba.fastjson.JSON;
import com.like.manager.model.Org;
import com.like.manager.model.User;
import com.like.manager.model.UserGrp;
import com.like.manager.query.UserQuery;
import com.like.manager.service.OrgService;
import com.like.manager.service.UserGrpService;
import com.like.manager.service.UserService;
import com.like.manager.util.Md5KeyBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserGrpService userGrpService;
    @Autowired
    private OrgService orgService;

    /**
     * 限制条件:查询结果限制本机构及以下用户;管理功能(如修改密码,开启)只对上级机构用户及超级管理员(userGrpId-1)开放
     * user.userExt.canMnged:1-当前登陆用户机构的下级机构;0-本身或同级机构
     */
    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("query") UserQuery query, @PageableDefault Pageable pageable) {
        //本机构及以下机构
        List<Org> lowerOrgs = new ArrayList<>();
        if (getCurUser() != null && getCurUser().getOrg() != null && getCurUser().getOrg().getOrgId() != null) {
            lowerOrgs = orgService.findByOrgIdStartingWithList(getCurUser().getOrg().getOrgId());
        }

        model.addAttribute("orgList", lowerOrgs);

        //登录用户机构,只能查询本机机构和下级机构
        if (query.getOrgId() == null || "".equals(query.getOrgId().trim())) {
            query.setLocalOrgId(getCurUser().getOrg().getOrgId());
        }

        //查询结果
        Page page = userService.queryPage(query, pageable);
        model.addAttribute("page", page);

        //条件回显
        model.addAttribute("query", query);

        return "security_pages/User/list";
    }

    /**
     * 进入新增用户页面
     */
    @RequestMapping("/insert")
    public String insert(Model model) {

        //本机构及以下机构
        List<Org> lowerOrgs = orgService.findByOrgIdStartingWithList(getCurUser().getOrg().getOrgId());
        model.addAttribute("orgList", lowerOrgs);
        return "security_pages/User/create";
    }

    /**
     * 保存新增用户数据，返回到list页面
     */
    @RequestMapping("/save")
    public String save(User user, String orgId, Long userGrpId) {
        int flag = Integer.parseInt(userService.countByLoginName(user.getLoginName()));
        if (flag > 0) {
            //TODO 已存在处理
        } else {
            if (orgId != null && !orgId.trim().equals("")) {
                user.setOrg(orgService.findOne(orgId));
            }
            if (userGrpId != null) {
                user.setUserGrp(userGrpService.findOne(userGrpId));
            }
            userService.save(user, getCurUser());
        }
        return "redirect:list";
    }

    /**
     * 查看用户
     */
    @RequestMapping("/show")
    public String show(Long userId, Model model) {
        User user = userService.getById(userId);
        User createUser = new User();
        if (user.getCreateUserId() != null && !user.getCreateUserId().equals("")) {
            createUser = userService.getById(Long.valueOf(user.getCreateUserId()));
        }

        model.addAttribute("createUser", createUser);
        model.addAttribute("model", user);
        return "security_pages/User/show";
    }

    /**
     * 重置密码.默认密码:111111,加密
     */
    @RequestMapping("/resetUserPwd")
    public String resetUserPwd(Long userId) {
        //重置
        userService.resetUserPwd(userId);
        return "redirect:list";
    }

    /**
     * 更新密码.加密
     */
    @RequestMapping("/updateUserPwd")
    public String updateUserPwd(Model model, Long userId) {
        User user = userService.getById(userId);
        model.addAttribute("user", user);
        return "security_pages/User/updateUserPwd";
    }

    /**
     * 修改密码.加密
     */
    @RequestMapping("/saveUserPwd")
    @ResponseBody
    public String saveUserPwd(Long userId, String oldPwd, String newPwd) {
        //验证原密码
        User oldUser = userService.getById(userId);
        Md5KeyBean md5 = new Md5KeyBean();
        if (oldUser.getPwd().equals(md5.getkeyBeanofStr(oldPwd))) {
            //原密码正确处理
            userService.updatePwd(userId, newPwd);
            return "密码修改成功！";
        }
        return "原密码不正确！";
    }

    /**
     * 关闭用户.更新t_p_shiro_user_ext.status = 0
     * 用户状态(0:停用,1启用)
     */
    @RequestMapping("/closeUser")
    public String closeUser(Long userId) {
        // 关闭
        userService.openOrCloseUser(userId, false);
        return "redirect:list";
    }

    /**
     * 开启用户.更新t_p_shiro_user_ext.status = 1
     * 用户状态(0:停用,1启用)
     */
    @RequestMapping("/openUser")
    public String openUser(Long userId) {
        // 开启
        userService.openOrCloseUser(userId, true);
        return "redirect:list";
    }

    /**
     * 进入重新分配用户分组页面
     */
    @RequestMapping("/assignUserGrp")
    public String assignUserGrp(Model model, Long userId) {
        //用户信息
        User user = userService.getById(userId);
        model.addAttribute("user", user);

        //用户分组
        List<UserGrp> userGrpList = userGrpService.findByOrgId(user.getOrg().getOrgId());
        model.addAttribute("userGrpList", userGrpList);

        return "security_pages/User/assignUserGrp";
    }

    /**
     * 保存修改分组后或修改机构后的用户
     */
    @RequestMapping("/saveUserGrp")
    public String saveUserGrp(Long userId, String userGrpId, String orgId) {
        //分配
        userService.assignUserGrpOrOrg(userId, userGrpId, orgId);
        return "redirect:list";
    }

    /**
     * 进入修改机构页面
     */
    @RequestMapping("/editUserForOrg")
    public String editUserForOrg(Long userId, Model model) {
        User user = userService.getById(userId);
        model.addAttribute("user", user);

        //本机构及以下机构
        List<Org> lowerOrgs = orgService.findByOrgIdStartingWithList(getCurUser().getOrg().getOrgId());
        model.addAttribute("orgList", lowerOrgs);
        return "security_pages/User/editUserForOrg";
    }

    /**
     * 机构联动用户分组
     */
    @RequestMapping("AJAX_findGrpByOrg")
    @ResponseBody
    public String AJAX_findGrpByOrg(String orgId) {
        // 查找
        List<UserGrp> userGrpList = userGrpService.findByOrgId(orgId);
        String jsonArray = JSON.toJSONString(userGrpList, true);
        return jsonArray;
    }

    /**
     * 验证用户名是否可用
     */
    @RequestMapping("/AJAX_isLoginNameExist")
    @ResponseBody
    public String AJAX_isLoginNameExist(String loginName) {
        // 响应
        return userService.countByLoginName(loginName);
    }

}
