package com.tw.finalProject.controller;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tw.finalProject.model.Booking;
import com.tw.finalProject.service.BookingService;

import ecpay.payment.integration.AllInOne;

@Controller
public class EcpayReturnController {
	
	public static  AllInOne all = new AllInOne("");
	
	@Autowired
	private BookingService bookingService;
	
	//obj.setClinetBackURL用
	@GetMapping(value = "/ECPayServer3", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String processPaymentResult() {
		return "<h1>付款成功</h1>";
	} 
	
	@PostMapping(value = "/ECPayServer3", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String processPaymentResult2(HttpServletRequest request) {
		//傳回來的參數
		Hashtable<String, String> dict = new Hashtable<String, String>();
		Enumeration<String> enumeration = request.getParameterNames();
		while(enumeration.hasMoreElements()) {
			String paramName = enumeration.nextElement();
			String paramValue = request.getParameter(paramName);
			dict.put(paramName, paramValue);			
		}
		
		boolean checkStatus = all.compareCheckMacValue(dict); //true：表示資料未被竄改
		//消費者付款成功且檢查碼正確的時候：	(RtnCode:交易狀態(1:成功，其餘為失敗))	
		if ("1".equals(dict.get("RtnCode")) && checkStatus==true ){
//			//session中取出訂單
			System.out.println("after:"+request.getSession().getAttribute("aaa"));
//			List<Booking> bookingList = (List<Booking>) request.getSession().getAttribute("bookingList");
			System.out.println("after:"+request.getSession().getAttribute("bookingList"));
//			System.out.println("bbbbbbb"+bookingList.get(0));
//			System.out.println(bookingList.get(0).getDateOfStay());
//			//依序存入SQL
//			for(Booking booking : bookingList) {
//				bookingService.updateBooking(booking);
//			}
			
			//取出訂單資料
//			String loginDate = (String) request.getSession().getAttribute("loginDate");
//			String logoutDate = (String) request.getSession().getAttribute("logoutDate");
//			String name = (String) request.getSession().getAttribute("name");
//			String mail = (String) request.getSession().getAttribute("mail");
//			String annotation = (String) request.getSession().getAttribute("annotation");
//			String arriveTimes = (String) request.getSession().getAttribute("arriveTimes");
//			int[] num = (int[]) request.getSession().getAttribute("num");//int[]
//			int[] roomId = (int[]) request.getSession().getAttribute("roomId");//int[]
//			int hotelId = (int) request.getSession().getAttribute("hotelId");//int
//			int userId = (int) request.getSession().getAttribute("userId");//int
//			List<Booking> bookingList= bookingService.buildNewBooking(
//					loginDate,
//					logoutDate,
//					name,
//					mail,
//					annotation,
//					arriveTimes,
//					num,
//					roomId,
//					hotelId,
//					userId);
			//依序存入SQL
//			for(Booking booking : bookingList) {
//				bookingService.updateBooking(booking);
//			}
			
			//存完之後就刪掉session/cookie的訂單資料
//			request.getSession().removeAttribute("bookingList");
//			Cookie[] cookies = request.getCookies();
//			for(Cookie c : cookies) {
//				if(c.getName().equals("bookingList")) {
//					c.setMaxAge(0);
//					break; 
//				}
//			}
			String returnString = "<h1>付款成功，訂單建立成功!</h1>";
			returnString += "<a href=\"http://localhost:8081/booking\"><button>點擊返回首頁</button></a>";
			
			return returnString;			 
		}
		else {
			return "<h1>訂房失敗，付款資料有誤！請重新訂房。</h1><a href=\"http://localhost:8081/booking\"><button>點擊返回首頁</button></a>";				
		}
	}
}
