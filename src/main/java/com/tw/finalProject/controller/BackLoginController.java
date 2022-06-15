package com.tw.finalProject.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tw.finalProject.model.Admin;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.service.AdminService;
import com.tw.finalProject.service.HotelService;
//=============================================明翰部分
@Controller
public class BackLoginController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private HotelService hotelService;

//    登入
    @GetMapping("/adminLogin")
    public String login(@ModelAttribute Admin admin,Model model) {
        System.out.println("admin" + admin.getAdminEmail());

        return "adminLoginForm";
    }

    // RedirectAttributes: redirect 帶值跳頁(不可以用Model)
//    帳號密碼
    @PostMapping("/adminPost")
    public String postForm(@RequestParam("adminEmail") String adminEmail,
                           @RequestParam("password") String password,
                           HttpSession httpSession, RedirectAttributes redirectAttributes){
        Admin result = adminService.login(adminEmail, password);
        Hotel hotel = hotelService.login(adminEmail, password);
        if(result!=null){
            httpSession.setAttribute("loginAdmin",result);
            return "newsPage";
        }else if (hotel!=null){
            httpSession.setAttribute("loginFirm",hotel);
            return "firmNewsPage";
        }else {
            // RedirectAttributes.addFlashAttribute: redirect 帶值跳頁(不可以用Model)
        redirectAttributes.addFlashAttribute("loginError","帳號密碼錯誤 ");
        return "redirect:adminLogin";
    }
    }

//    後台登出
    @GetMapping("/adminLogout")
    public String backLogout( HttpServletRequest request
                             ){

        request.getSession().invalidate();

        Cookie[] cookies = request.getCookies();
        for (Cookie c : cookies) {
            if (c.getName().equals("JSESSIONID")){
                c.setMaxAge(0);
                break;
            }

        }
        return "redirect:adminLoginForm";
    }

}


