package com.like.manager.controller;

import com.like.manager.model.Role;
import com.like.manager.model.User;
import com.like.manager.query.UserQuery;
import com.like.manager.service.RoleService;
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

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    /**
     * 查询用户
     */
    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute UserQuery query, @PageableDefault Pageable pageable) {
        Page page = userService.queryPage(query, pageable);
        model.addAttribute("page", page);
        return "security_pages/User/list";
    }

    /**
     * 进入新增用户页面
     */
    @RequestMapping("/insert")
    public String insert() {
        return "security_pages/User/create";
    }

    /**
     * 保存新增用户数据，返回到list页面
     */
    @RequestMapping("/save")
    public String save(User user) {
        int flag = Integer.parseInt(userService.countByLoginName(user.getLoginName()));
        if (flag > 0) {
            //TODO 已存在处理
        } else {
            userService.save(user);
        }
        return "redirect:list";
    }

    /**
     * 查看用户
     */
    @RequestMapping("/show")
    public String show(Long id, Model model) {
        User user = userService.getById(id);
        model.addAttribute("user", user);
        return "security_pages/User/show";
    }

    /**
     * 重置密码.默认密码:111111,加密
     */
    @RequestMapping("/resetUserPwd")
    public String resetUserPwd(Long id) {
        userService.resetUserPwd(id);
        return "redirect:list";
    }

    /**
     * 更新密码.加密
     */
    @RequestMapping("/updateUserPwd")
    public String updateUserPwd(Model model, Long id) {
        User user = userService.getById(id);
        model.addAttribute("user", user);
        return "security_pages/User/updateUserPwd";
    }

    /**
     * 修改密码.加密
     */
    @RequestMapping("/saveUserPwd")
    @ResponseBody
    public String saveUserPwd(Long id, String oldPwd, String newPwd) {
        //验证原密码
        User oldUser = userService.getById(id);
        Md5KeyBean md5 = new Md5KeyBean();
        if (oldUser.getPassWord().equals(md5.getkeyBeanofStr(oldPwd))) {
            //原密码正确处理
            userService.updatePwd(id, newPwd);
            return "密码修改成功！";
        }
        return "原密码不正确！";
    }

    /**
     * 关闭用户
     * 用户状态(0:停用,1启用)
     */
    @RequestMapping("/closeUser")
    public String closeUser(Long id) {
        userService.openOrCloseUser(id, false);
        return "redirect:list";
    }

    /**
     * 开启用户
     * 用户状态(0:停用,1启用)
     */
    @RequestMapping("/openUser")
    public String openUser(Long id) {
        userService.openOrCloseUser(id, true);
        return "redirect:list";
    }

    /**
     * 进入分配角色页面
     */
    @RequestMapping("/role")
    public String role(Long id, Model model) {
        //用户分组
        User user = userService.findOne(id);
        //所有的角色
        List<Role> roleList = roleService.findAll();

        model.addAttribute("user", user);
        model.addAttribute("roleList",roleList );

        return "security_pages/User/role";
    }

    /**
     * 保存分配角色数据
     */
    @RequestMapping("/saveRoles")
    public String saveRoles(Long id, String[] roles) {
        userService.saveRoles(id, roles);
        return "redirect:list";
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
