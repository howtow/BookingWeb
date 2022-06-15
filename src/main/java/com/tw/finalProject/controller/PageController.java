package com.tw.finalProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageController {



	@GetMapping("/")
	public String goIndex() {
		return "index";
	}

	@GetMapping("/customerlogin")
	public String gocustomerLoginPage() {
		return "signup_form";
	}

//	=====================明翰部分================================

	@GetMapping("about")
	public String goAbout() {
		return "about";
	}

	@GetMapping("/side")
	public String side() {
		return "sidebar";
	}

	@GetMapping("/adminLoginForm")
	public String backLogin() {
		return "adminLoginForm";
	}

	@GetMapping("/adminPage")
	public String adminPage() {
		return "adminPage";
	}

	@GetMapping("/updateHotel")
	public ModelAndView hotel(ModelAndView modelAndView) {

		modelAndView.setViewName("updateHotel");
		return modelAndView;
	}
	

	@GetMapping("/newsPage")
	public String newsPage(){
		return "newsPage";
	}

	@GetMapping("/firmNewsPage")
	public String firmNewsPage(){
		return "firmNewsPage";
	}

//		@GetMapping("/hotelManage")
//		public String hotelManage(){
//			return "hotelManage";
//		}
}
