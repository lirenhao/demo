package com.like.manager.controller;

import com.like.manager.model.Org;
import com.like.manager.model.Role;
import com.like.manager.model.UserGrp;
import com.like.manager.query.UserGrpQuery;
import com.like.manager.service.OrgService;
import com.like.manager.service.RoleService;
import com.like.manager.service.UserGrpService;
import com.like.manager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/userGrp")
public class UserGrpController extends BaseController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserGrpService userGrpService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private OrgService orgService;

    /**
     * 进入list页面
     */
    @RequestMapping("/list")
    public String list(@ModelAttribute("query") UserGrpQuery query, Model model, @PageableDefault Pageable pageable) {
        //本机构及以下机构
        List<Org> lowerOrgs = orgService.findByOrgIdStartingWithList(getCurUser().getOrg().getOrgId());
        model.addAttribute("orgList", lowerOrgs);

        //下级机构过滤
        if (query.getOrgId() == null || query.getOrgId().trim().equals("")) {
            query.setLocalOrgId(getCurUser().getOrg().getOrgId());
        }

        //查询结果
        Page page = userGrpService.queryPage(query, pageable);
        model.addAttribute("page", page);
        List<UserGrp> userGrpList = page.getContent();
        model.addAttribute("userGrpList", userGrpList);
        //查询条件回显
        model.addAttribute("query", query);
        return "security_pages/UserGrp/list";
    }

    /**
     * 进入新增页面
     */
    @RequestMapping("insert")
    public String insert(Model model, UserGrp userGrp) {
        //本机构及以下机构
        List<Org> lowerOrgs = orgService.findByOrgIdStartingWithList(getCurUser().getOrg().getOrgId());
        model.addAttribute("orgList", lowerOrgs);

        return "security_pages/UserGrp/create";
    }

    /**
     * 保存新增分组数据
     */
    @RequestMapping("/save")
    public String save(UserGrp userGrp) {

        //保存用户分组及用户分组额外信息
        userGrpService.saveUserGrp(userGrp);
        return "redirect:list";
    }
    /**
     * 进入分配角色页面
     */
    @RequestMapping("/role")
    public String role(Long userGrpId, Model model) {
        //用户分组
        UserGrp userGrp = userGrpService.findOne(userGrpId);
        //所有的角色
        List<Role> roleList = roleService.findAllUserGrp();

        model.addAttribute("userGrp", userGrp);
        model.addAttribute("roleList",roleList );

        return "security_pages/UserGrp/role";
    }
    /**
     * 保存分配角色数据
     */
    @RequestMapping("/saveRoles")
    public String saveRoles(String[] roles,Long userGrpId) {
        List<Role> roleList=new ArrayList<>();
        if(roles!=null&&roles.length>0){
            for(String str:roles){
                Role role=roleService.findOne(Long.parseLong(str));
                roleList.add(role);
            }
        }
        UserGrp userGrp = userGrpService.findOne(userGrpId);
        userGrp.setRoles(roleList);
        userGrpService.saveUserGrp(userGrp);

        return "redirect:list";
    }

}
