package com.like.manager.controller;

import com.like.manager.model.Org;
import com.like.manager.service.OrgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("org")
public class OrgController {

    @Autowired
    private OrgService orgService;

    @RequestMapping("/list")
    public String list(Model model) {
        // 获取当前用户所在机构
        model.addAttribute("org", orgService.findOne("00"));
        return "security_pages/Org/list";
    }

    @RequestMapping("/show")
    public String show(Model model, String id) {
        model.addAttribute("org", orgService.findOne(id));
        return "security_pages/Org/show";
    }

    @RequestMapping("/create")
    public String create(Model model, String pid) {
        Org pOrg = orgService.findOne(pid);
        model.addAttribute("pOrg", pOrg);
        return "security_pages/Org/create";
    }

    @RequestMapping("/save")
    public String save(Org org, String pid) {
        Org pOrg = orgService.findOne(pid);
        org.setOrg(pOrg);
        orgService.save(org);
        return "redirect:list";
    }

    @RequestMapping("/edit")
    public String edit(Model model, String id) {
        model.addAttribute("org", orgService.findOne(id));
        return "security_pages/Org/edit";
    }

    @RequestMapping("/update")
    public String update(Org org) {
        orgService.update(org);
        return "redirect:list";
    }

    @RequestMapping("/delete")
    public String delete(String id) {
        orgService.delete(id);
        return "redirect:list";
    }

    /**
     * 判断机构号是否存在
     */
    @RequestMapping("/AJAX_isOrgIdExist")
    @ResponseBody
    public String AJAX_isOrgIdExist(String orgId) {
        String num = "1";
        if (orgService.findOne(orgId) == null) {
            num = "-1";
        }
        return num;
    }
}
