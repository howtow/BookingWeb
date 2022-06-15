package com.tw.finalProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.tw.finalProject.model.Booking;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.service.BookingService;
import com.tw.finalProject.service.CommentService;
import com.tw.finalProject.service.CustomerService;
import com.tw.finalProject.service.HotelService;
import com.tw.finalProject.service.RoomService;

@RestController
public class ApiController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private HotelService hotelService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private BookingService bookingService;

    //會員數
    @GetMapping("api/customerSum")
    public ResponseEntity<Map<String,Integer>> getCustomerSum() {

        Map<String,Integer> result = new HashMap<String,Integer>();
        result.put("customer", customerService.customerSum());
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    //旅館數
    @GetMapping("api/hotelSum")
    public ResponseEntity<Map<String, Integer>> getHotelSun(){
        Map<String, Integer> result = new HashMap<String,Integer>();
        result.put("hotel", hotelService.hotelSum());
        return ResponseEntity.status(HttpStatus.OK).body(result);

    }

    //訂單總額
    @GetMapping("api/bookingSum")
    public ResponseEntity<Map<String, Integer>> getBookingSum(){
        Map<String, Integer> result=new HashMap<String,Integer>();
        result.put("booking", bookingService.bookingSum());
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    //房間數
    @GetMapping("api/roomSum")
    public ResponseEntity<Map<String, Integer>> getRoomSum(){
        Map<String, Integer> result=new HashMap<String,Integer>();
        result.put("room", roomService.roomSum());
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    //評論數
    @GetMapping("api/commentSum")
    public ResponseEntity<Map<String, Integer>> getCommentSum(){
        Map<String, Integer> result=new HashMap<String,Integer>();
        result.put("comment", commentService.commentSum());
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    //最近訂單
    @GetMapping("/api/booking")
    @ResponseBody
    public List<Booking> bookingManage(@RequestParam(name = "p",defaultValue = "1")Integer pageNumber){
        Page<Booking> page = bookingService.findByPage1(pageNumber);
        List<Booking> content = page.getContent();

        return content;
    }

    //確認訂單狀態
    @GetMapping("changeStatus")
    public ModelAndView postFirm(@RequestParam("bookingId") Integer id){
        Booking byId = bookingService.getBookingById(id);
        byId.setState("已確認");

        bookingService.updateBooking(byId);
        return new ModelAndView("redirect:firmBookingManage");
    }

    //廠商評論數
    @GetMapping("api/firmCommentSum")
    public ResponseEntity<Map<String, Integer>> getFirmCommentSum(HttpSession session){
        Hotel firm = (Hotel) session.getAttribute("loginFirm");
        Map<String, Integer> result=new HashMap<String,Integer>();
        result.put("comment", commentService.getFirmCommentSum(firm.getHotelId()));
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    //廠商房間數
    @GetMapping("api/firmRoomSum")
    public ResponseEntity<Map<String, Integer>> firmGetRoomSum(HttpSession session){
        Hotel firm = (Hotel) session.getAttribute("loginFirm");
        Map<String, Integer> result=new HashMap<String,Integer>();
        result.put("room", roomService.firmRoomSum(firm.getHotelId()));
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    //訂單總額
    @GetMapping("api/firmBookingSum")
    public ResponseEntity<Map<String, Integer>> getBookingSum(HttpSession session){
        Hotel firm = (Hotel) session.getAttribute("loginFirm");
        Map<String, Integer> result=new HashMap<String,Integer>();
        result.put("booking", bookingService.firmBookingSum(firm.getHotelId()));
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    //廠商最近訂單
    @GetMapping("/api/firmBooking")
    @ResponseBody
    public List<Booking> firmBookingManage(HttpSession session,@RequestParam(name = "p",defaultValue = "1")Integer pageNumber){
        Hotel firm = (Hotel) session.getAttribute("loginFirm");
        Page<Booking> page = bookingService.findByPage1(pageNumber, firm.getHotelId());
        List<Booking> content = page.getContent();

        return content;
    }
}
