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
			String returnString = "";
			returnString += "<div style=\"width: 100%; display: flex; justify-content: center; align-items: center;\">";
			returnString += "<div style=\"background-color: rgba(0, 0, 0, 0.603); padding: 20px; width: 300px; height: 150px;border-radius: 3px; margin-top: 50px; display: flex; flex-direction: column; justify-content: center; align-items: center;\">";
			returnString += "<h1 style=\"color:white; margin-top: 0px;\">訂單建立成功!</h1>";
			returnString += "<a href=\"http://localhost:8081/booking\" ><button style=\"border: 0px; background-color: #0071c2; color: #ffffff; padding: 10px; font-size: 20px; border-radius: 3px; cursor: pointer;\">點我回首頁</button></a>";
			returnString += "</div>";
			returnString += "</div>";
			returnString += "<div class=\"backgroundImg\">";
			returnString += "<video autoplay muted loop src=\"https://storage.coverr.co/videos/brV01ybPwOysPOHK00FI02TfdM9XbVaYBpG?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBJZCI6Ijg3NjdFMzIzRjlGQzEzN0E4QTAyIiwiaWF0IjoxNjU0NTMxNTgxfQ.VqshnyZYtmsrnlfjwt11XTrVzPCGe-it-_PR2Xns71Q\" style=\"position: fixed; margin-top: 0%; width: 100%; height: 100%; bottom: 0; left:0; object-fit: cover; z-index:-1;\"></video>";
			returnString += "</div>";
			
			return returnString;			 
		}
		else {
			return "<h1>訂房失敗，付款資料有誤！請重新訂房。</h1><a href=\"http://localhost:8081/booking\"><button>點擊返回首頁</button></a>";				
		}
	}
}
