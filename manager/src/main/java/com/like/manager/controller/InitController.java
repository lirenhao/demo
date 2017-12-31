package com.like.manager.controller;

import com.like.manager.model.Permit;
import com.like.manager.model.Res;
import com.like.manager.model.ResType;
import com.like.manager.service.PermitService;
import com.like.manager.service.ResService;
import com.like.manager.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.mvc.condition.PatternsRequestCondition;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/init")
public class InitController {

    @Autowired
    private ResService resService;
    @Autowired
    private PermitService permitService;
    @Autowired
    private RoleService roleService;

    @RequestMapping("/url")
    @ResponseBody
    public List<String> init(HttpServletRequest request) {
        //存储所有url集合
        List<String> uList = new ArrayList<>();
        // 获取上下文对象
        WebApplicationContext wac = (WebApplicationContext) request.getAttribute(DispatcherServlet.WEB_APPLICATION_CONTEXT_ATTRIBUTE);
        //通过上下文对象获取RequestMappingHandlerMapping实例对象
        RequestMappingHandlerMapping bean = wac.getBean(RequestMappingHandlerMapping.class);
        Map<RequestMappingInfo, HandlerMethod> handlerMethods = bean.getHandlerMethods();
        for (RequestMappingInfo rmi : handlerMethods.keySet()) {
            PatternsRequestCondition prc = rmi.getPatternsCondition();
            Set<String> patterns = prc.getPatterns();
            for (String uStr : patterns) {
                ResType resType = new ResType();
                resType.setId(2L);
                Res res = new Res();
                res.setResType(resType);
                res.setName(uStr);
                res.setAction(uStr);
                res.setRes(new Res());
                try {
                    resService.save(res);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        List<Permit> permits = permitService.findAll();
        Long[] ids = new Long[permits.size()];
        for (int i = 0; i < permits.size(); i++) {
            ids[i] = permits.get(i).getId();
        }
        roleService.permitSave(1L, ids);
        return uList;
    }
}
