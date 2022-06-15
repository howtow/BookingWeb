package com.tw.finalProject.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tw.finalProject.model.Booking;
import com.tw.finalProject.service.BookingService;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;

@Controller
public class EcpayController {
	private static AllInOne all = new AllInOne("");
	
	@Autowired
	private BookingService bookingService;
	
	//設定表單的方法
	private String genAioCheckOutAll(HttpServletRequest request) {
		AioCheckOutALL obj = new AioCheckOutALL();
		//設定表單相關屬性
		//交易編號不可重複，用毫秒
		obj.setMerchantTradeNo(String.format("III%d",new Date().getTime()));
		//交易時間
		obj.setMerchantTradeDate(String.format("%tY/%<tm/%<td %<tH:%<tM:%<tS", new Date()));
		//交易金額、品名、描述
		//(先把金額的多餘char去掉)
		String TotalAmount = request.getParameter("TotalAmount").replace(",", "");
		obj.setTotalAmount(TotalAmount);
		obj.setTradeDesc(request.getParameter("TradeDesc"));
		obj.setItemName(request.getParameter("ItemName"));
		obj.setNeedExtraPaidInfo("N");
		//1.設定回傳路徑(必要/直接從綠界server傳回controller)
		obj.setReturnURL("https://140.116.180.141/booking/ECPayServer3");
		//2.以Clinet端方式回傳(為主)
		obj.setOrderResultURL("http://localhost:8081/booking/ECPayServer3"); 
		//轉成form格式字串回傳
		String form = all.aioCheckOut(obj, null);
		return form;
	}
	
	@RequestMapping(value = "/ECPayServer", produces="text/html;charset=utf-8")
	@ResponseBody
	public String processPayment(HttpServletRequest request) {
		//設定form
		String form = genAioCheckOutAll(request);
		System.out.printf("【ECPayServer.java】產生了讓消費者付款的表單：\n%s\n",form);	
		
		//-----------------建立訂單需要的值-------------------------------------
		String loginDate = request.getParameter("loginDate");
		String logoutDate = request.getParameter("logoutDate");
		String name = request.getParameter("name");
		String mail = request.getParameter("mail");
		String annotation = request.getParameter("annotation");
		String arriveTimes = request.getParameter("arriveTimes");
		String stringnum = request.getParameter("num");
		String stringroomId = request.getParameter("roomId");
		String stringhotelId = request.getParameter("hotelId");
		String stringuserId = request.getParameter("userId");
		//非String型別整理
		//數量
		String[] stringlistnum = stringnum.replace("[", "").replace("]", ",").replace(" ", "").split(",");
		int[] num = new int[stringlistnum.length];
		for(int i=0 ; i<stringlistnum.length ; i++) {
			num[i]=Integer.parseInt(stringlistnum[i]);
		}
		//ID
		String[] stringroomIdlist = stringroomId.replace("[", "").replace("]", ",").replace(" ", "").split(",");
		int[] roomId = new int[stringroomIdlist.length];
		for(int i=0 ; i<stringroomIdlist.length ; i++) {
			roomId[i]=Integer.parseInt(stringroomIdlist[i]);
		}
		//HotelId
		int hotelId = Integer.parseInt(stringhotelId);
		//HotelId
		int userId = Integer.parseInt(stringuserId);
		//建立新訂單並放進session
		List<Booking> bookingList= bookingService.buildNewBooking(
				loginDate,
				logoutDate,
				name,
				mail,
				annotation,
				arriveTimes,
				num,
				roomId,
				hotelId,
				userId);
		//偷吃步
		for(Booking booking : bookingList) {
			bookingService.updateBooking(booking);
		}
		request.getSession().setAttribute("aaa", "bbb");
		System.out.println("before:"+request.getSession().getAttribute("aaa"));
		request.getSession().setAttribute("bookingList", bookingList);
		System.out.println("before:"+request.getSession().getAttribute("bookingList"));
//		System.out.println(bookingList);
//
//		request.getSession().setAttribute("loginDate", loginDate);
//		request.getSession().setAttribute("logoutDate", logoutDate);
//		request.getSession().setAttribute("name", name);
//		request.getSession().setAttribute("mail", mail);
//		request.getSession().setAttribute("annotation", annotation);
//		request.getSession().setAttribute("arriveTimes", arriveTimes);
//		request.getSession().setAttribute("num", num);//int[]
//		request.getSession().setAttribute("roomId", roomId);//int[]
//		request.getSession().setAttribute("hotelId", hotelId);//int
//		request.getSession().setAttribute("userId", userId);//int
//		System.out.println(request.getSession().getAttribute("loginDate"));
//		System.out.println(request.getSession().getAttribute("logoutDate"));
//		System.out.println(request.getSession().getAttribute("name"));
//		System.out.println(request.getSession().getAttribute("mail"));
//		System.out.println(request.getSession().getAttribute("annotation"));
//		System.out.println(request.getSession().getAttribute("arriveTimes"));
//		System.out.println(request.getSession().getAttribute("num"));
//		System.out.println(request.getSession().getAttribute("roomId"));
//		System.out.println(request.getSession().getAttribute("hotelId"));
//		System.out.println(request.getSession().getAttribute("userId"));
		return form; 
	}
}
