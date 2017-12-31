package com.like.manager.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.like.manager.model.Permit;
import com.like.manager.model.Res;
import com.like.manager.model.Role;
import com.like.manager.model.User;
import com.like.manager.service.ResService;
import com.like.manager.service.UserService;
import com.like.manager.util.RandomChar;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ThreadContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("login")
public class LoginController extends BaseController {

    @Autowired
    private ResService resService;
    @Autowired
    private UserService userService;

    @RequestMapping
    public String login() {
        return "security_pages/login";
    }

    @RequestMapping("/unauthorized")
    public String unauthorized() {
        return "security_pages/unauthorized";
    }

    @RequestMapping("/noExecution")
    public String noExecution() {
        return "security_pages/execution";
    }

    @RequestMapping("/logout")
    public String logout() {
        Subject subject = (Subject) ThreadContext.getResources().get(ThreadContext.SUBJECT_KEY);
        subject.logout();
        //记录登出信息
        return "security_pages/login";
    }


    @RequestMapping("/getAuthCode")
    public void getAuthCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        RandomChar rc = new RandomChar();
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        //在内存中创建图象宽60 高18 4个字符 0条干扰线
        BufferedImage image = rc.getRandomImage(58, 18, 4, 1);
        //设置其cookie值
        String cookieValue = Md5Hash.fromBase64String(rc.getRandomString()).toString();
        Cookie cookie = new Cookie("jcmsrandomchar", cookieValue);
        cookie.setMaxAge(30 * 60);// 设置为30min
        cookie.setPath("/");
        response.addCookie(cookie);

        ImageIO.write(image, "JPEG", response.getOutputStream());
        response.getOutputStream().flush();
    }

    @RequestMapping("/validate")
    public String validate(User user, Model model, HttpServletRequest request) {
        System.out.println("---------进入登录验证-----------");
        System.out.println(user.getLoginName() + ":" + user.getPwd());

        Subject oldSubject = (Subject) ThreadContext.getResources().get(ThreadContext.SUBJECT_KEY);
        oldSubject.logout();

        String randomcode = request.getParameter("randomcode");
        String randomcodeYz = "";

        if (user.getLoginName() == null && user.getPwd() == null) {
            model.addAttribute("returnMessage", "请先登录");
            return "security_pages/login";
        }
        if (randomcode == null) {
            model.addAttribute("returnMessage", "请输入验证码");
            return "security_pages/login";
        } else {
            randomcode = Md5Hash.fromBase64String(randomcode).toString();
        }
        // 这样便可以获取一个cookie数组
        Cookie[] cookies = request.getCookies();
        if (null == cookies) {
            model.addAttribute("returnMessage", "验证码失效");
            return "security_pages/login";
        } else {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("jcmsrandomchar"))
                    randomcodeYz = cookie.getValue();
            }
        }

        if (!randomcode.equals(randomcodeYz)) {
            model.addAttribute("returnMessage", "验证码输入错误");
            return "security_pages/login";
        }

        //创建用户名和密码的令牌
        UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginName(), user.getPwd());
        //记录该令牌，如果不记录则类似购物车功能不能使用。（官方建议开启，但是并未验证功能）
        token.setRememberMe(true);

        //subject理解成权限对象。类似user
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(token);
        } catch (UnknownAccountException | IncorrectCredentialsException e) {
            // 用户名没有找到
            e.printStackTrace();
            model.addAttribute("returnMessage", "用户名与密码不匹配");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("returnMessage", "登录出现未知错误");
        }
        user = userService.findUserByLoginName(user.getLoginName());
        // 判断用户开启/关闭
        if (user != null) {
            if (user.getStatus().equals("0")) {
                model.addAttribute("returnMessage", "用户已关闭");
                return "security_pages/login";
            }
        }
        if (subject.isAuthenticated()) {
            // 用户信息存入Session
            subject.getSession().setAttribute("curUser", user);
            return "redirect:frame";
        }
        return "security_pages/login";
    }

    @RequestMapping("/frame")
    public String frame(Model model) {
        List<Long> resIds = new ArrayList<>();
        User user = getCurUser();
        if (user == null) {
            return "security_pages/login";
        }
        List<Role> roles = user.getUserGrp().getRoles();
        for (Role role : roles) {
            for (Permit permit : role.getPermits()) {
                resIds.add(permit.getRes().getId());
            }
        }
        List<Res> menuList = resService.findParentByResType("menu");
        JSONArray menus = new JSONArray();
        for (Res res : menuList) {
            if (resIds.contains(res.getId())) {
                JSONObject menu = new JSONObject();
                menu.put("name", res.getName());
                menu.put("action", res.getAction());
                menu.put("icon", res.getIcon());
                JSONArray children = new JSONArray();
                if (res.getChildren() != null && res.getChildren().size() > 0) {
                    for (Res subRes : res.getChildren()) {
                        if (resIds.contains(subRes.getId())) {
                            JSONObject subMenu = new JSONObject();
                            subMenu.put("name", subRes.getName());
                            subMenu.put("action", subRes.getAction());
                            menu.put("icon", res.getIcon());
                            children.add(subMenu);
                        }
                    }
                }
                menu.put("children", children);
                menus.add(menu);
            }
        }
        model.addAttribute("menus", menus);
        model.addAttribute("user", getCurUser());
        return "base_pages/commons/iframe";
    }

}
