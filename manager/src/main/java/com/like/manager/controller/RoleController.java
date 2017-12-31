package com.like.manager.controller;

import com.like.manager.model.Role;
import com.like.manager.query.RoleQuery;
import com.like.manager.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute RoleQuery query, @PageableDefault Pageable pageable) {
        Page<Role> page = roleService.findAll(query, pageable);
        model.addAttribute("page", page);
        return "security_pages/Role/list";
    }

    @RequestMapping("/create")
    public String create() {
        return "security_pages/Role/create";

    }

    @RequestMapping("/save")
    public String save(Role role) {
        roleService.save(role);
        return "redirect:list";
    }

    @RequestMapping("/edit")
    public String edit(Model model, Long id) {
        model.addAttribute("role", roleService.findOne(id));
        return "security_pages/Role/edit";
    }

    @RequestMapping("/update")
    public String go_update(Role role) {
        roleService.update(role);
        return "redirect:list";
    }

    @RequestMapping("/delete")
    public String delete(Long id, @ModelAttribute RoleQuery query) {
        roleService.delete(id);
        return "redirect:list";
    }

    @RequestMapping("/permit")
    public String permit(Model model, Long id) {
        model.addAttribute("id", id);
        model.addAttribute("menuTree", roleService.getPermitTree(id, "menu"));
        model.addAttribute("urlTree", roleService.getPermitTree(id, "url"));
        return "security_pages/Role/permit";
    }

    @RequestMapping("/permitSave")
    public String permitSave(Model model, Long[] ids, Long id) {
        roleService.permitSave(id, ids);
        return "redirect:list";
    }
}