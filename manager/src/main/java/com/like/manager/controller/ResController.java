package com.like.manager.controller;

import com.alibaba.fastjson.JSON;
import com.like.manager.model.Res;
import com.like.manager.model.ResType;
import com.like.manager.service.ResService;
import com.like.manager.service.ResTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("res")
public class ResController {

    @Autowired
    private ResService resService;
    @Autowired
    private ResTypeService resTypeService;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("menuList", resService.findParentByResType("menu"));
        model.addAttribute("urlList", resService.findParentByResType("url"));
        return "security_pages/Res/list";
    }

    @RequestMapping("/create")
    public String create(Model model, String pid, String type) {
        model.addAttribute("pid", pid);
        ResType resType = resTypeService.findByName(type);
        if (resType != null)
            model.addAttribute("typeId", resType.getId());
        return "security_pages/Res/create";
    }

    @RequestMapping("/save")
    public String save(Res res) {
        resService.save(res);
        return "redirect:list";
    }

    @RequestMapping("/edit")
    public String edit(Model model, Long id) {
        model.addAttribute("res", resService.findOne(id));
        return "security_pages/Res/edit";
    }

    @RequestMapping("/update")
    public String update(Res res) {
        resService.update(res);
        return "redirect:list";
    }

    @RequestMapping("/delete")
    public String delete(Long id) {
        resService.delete(id);
        return "redirect:list";
    }

    @RequestMapping("/sort")
    public String sort(String menu, String url) {
        // 资源排序
        List<Res> menus = JSON.parseArray(menu, Res.class);
        List<Res> urls = JSON.parseArray(url, Res.class);
        resService.sortSave(menus);
        resService.sortSave(urls);
        return "redirect:list";
    }

}

