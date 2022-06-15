package com.tw.finalProject.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tw.finalProject.model.Booking;
import com.tw.finalProject.model.BookingRepository;
import com.tw.finalProject.model.Customer;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.model.Room;
import com.tw.finalProject.service.BookingService;
import com.tw.finalProject.service.CommentService;
import com.tw.finalProject.service.CustomerService;
import com.tw.finalProject.service.HotelService;
import com.tw.finalProject.service.RoomService;
import com.tw.finalProject.util.Util;

@Controller
public class BookingController {

	@Autowired
	private BookingRepository dao;
	@Autowired
    private BookingService bookingService;
	@Autowired
	private RoomService roomService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private CustomerService customerService;
	
	
	
	
	@GetMapping("/bookingList") //0608有改
	public String listAllBooking(Integer userId,Model model) {
		List<Booking> tempBooking = dao.findAllByUserId(userId);
		
		Customer cus = customerService.getCustomerById(userId);
		
		byte[] photoFile = cus.getPhoto();
		if(photoFile != null) {
			String base64 = Base64.getEncoder().encodeToString(photoFile);
			model.addAttribute("bookingList",tempBooking);
			model.addAttribute("photo",base64);
		}else {
			model.addAttribute("bookingList",tempBooking);
		}
		
		return "myOrderInfo";
	}
	@GetMapping("/sortDesc")
	public String listAllBookingByDesc(Integer userId, Model model) {
		List<Booking> tempBookingDesc = dao.findAllByUserIdOrderByDesc(userId);
		
		model.addAttribute("bookingList", tempBookingDesc);
		
		return "myOrderInfo";
	}
	
	@GetMapping("/sortAsc")
	public String listAllBookingByAsc(Integer userId, Model model) {
		List<Booking> tempBookingAsc = dao.findAllByUserIdOrderByAsc(userId);
		
		model.addAttribute("bookingList", tempBookingAsc);
		
		return "myOrderInfo";
	}
	
	@GetMapping("/dateSelect")
	public String listAllBookingByDateByDesc(String start_date, String end_date, Model model) {
		
		List<Booking> tempBookingSelectByDate = dao.findAllByDateOrderByDesc(start_date, end_date);
		
		model.addAttribute("bookingList",tempBookingSelectByDate);
		
		return "myOrderInfo";
	}
	
	@GetMapping("/find/{id}")
	public ResponseEntity<Booking> find(@PathVariable("id") Integer id, Model model){
		
		try {
			
			Booking cusBooking = bookingService.getBookingById(id);
			return new ResponseEntity<Booking>(cusBooking,HttpStatus.OK);
		}catch(Exception e){
			return new ResponseEntity<Booking>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/findOrderDetail")
	public ResponseEntity<Room> findBookingDetail(Integer bookingId, Model model) {
		System.out.println(bookingId);
		
		try {
			Booking tempBooking = bookingService.getBookingById(bookingId);
			Integer roomId = tempBooking.getRoomId();
			Room tempRoom = roomService.getRoomById(roomId);
			
			return new ResponseEntity<Room>(tempRoom ,HttpStatus.OK);
		}catch(Exception e){
			return new ResponseEntity<Room>(HttpStatus.BAD_REQUEST);
		}		
		
	}
	@GetMapping("/findOrderDetailByHotelId")
	public ResponseEntity<Hotel> findBookingDetailByHotelId(Integer hotelId, Model model) {
		System.out.println(hotelId);
		
		try {
			Hotel tempHotel = hotelService.getHotelById(hotelId);
			
			
			return new ResponseEntity<Hotel>(tempHotel ,HttpStatus.OK);
		}catch(Exception e){
			return new ResponseEntity<Hotel>(HttpStatus.BAD_REQUEST);
		}		
		
	}
	
	@PostMapping("/addComment")
	public String addComment(@RequestParam(name = "comment",defaultValue = "") String comment,
							@RequestParam(name = "userId") Integer userId,
							@RequestParam(name = "bookingId") Integer bookingId,
							@RequestParam(name = "hotelId") Integer hotelId,
							@RequestParam(name = "roomId") Integer roomId,
							@RequestParam(name = "myRange",defaultValue = "0.0") double rating){
		
		
		Date commentTime = new Date();
		System.out.println(commentTime);
		
		
		commentService.addComment(comment, userId, bookingId, hotelId, roomId, rating, commentTime);
		
		String back = "redirect:bookingList?userId="+userId;
		
		return back;
	}
	
	@GetMapping("/bookingCheck")
	public String bookingCheck(Integer userId, Integer status,Model model) {
		
		Integer id = userId;
		
		if(status == 1) {
			
			String state = "已確認";
			List<Booking> result = bookingService.findByOrderCheck(state, id);
			model.addAttribute("bookingList", result);
		}else if (status == 2) {
			
			String state = "未確認";
			List<Booking> result = bookingService.findByOrderCheck(state, id);
			model.addAttribute("bookingList", result);
		}else {
			
			List<Booking> result = bookingService.findAllByUserId(id);
			model.addAttribute("bookingList", result);
				
		}
			
		return "myOrderInfo";
		
	}
	
	@GetMapping("/delBooking") //0609
	public String deleteBookingByBookingId(Integer userId,Integer bookingId) {
		
	 dao.deleteBkBybookIdAndUserId(userId, bookingId);
	 return "myOrderInfo";
	 
	}
	
	// =============================明翰的部分(後臺管理員)=======================================
	
//  拿到所有訂單資料
  @GetMapping("/bookingManage")
  public String bookingList(Model model, @RequestParam(name = "p",defaultValue = "1") Integer pageNumber){
      Page<Booking> bookings = bookingService.findByPage(pageNumber);
      List<Booking> list = bookings.getContent();
      model.addAttribute("bookingList",list);
      model.addAttribute("page",bookings);
      return "bookingManage";
  }

//  跳到更新訂單頁面
  @GetMapping("editBooking")
  public String editBooking(@RequestParam("bookingId") Integer id,Model model){
      Booking booking = bookingService.getBookingById(id);
      model.addAttribute("bookingBean" ,booking);

      return "updateBooking";

  }

//  更新訂單資料 改成 查看訂單資料
  @PostMapping("editPostBooking")
  public ModelAndView editBooking(ModelAndView msv, @ModelAttribute(name = "bookingBean") Booking booking){
//      Booking booking1 = new Booking();
//
//      msv.getModel().put("bookingBean",booking1);
//
//      bookingService.updateBooking(booking1);
      msv.setViewName("redirect:bookingManage");
      return msv;
  }

//  刪除訂單
  @GetMapping("/deleteBooking")
  public String deleteBooking(@RequestParam(name = "bookingId") Integer id){
      bookingService.deleteBookingById(id);
      return "redirect:bookingManage";
  }

//  -------------------------------------

  //廠商訂單
  @GetMapping("/firmBookingManage")
  public ModelAndView bookingList(ModelAndView mav, @RequestParam(value = "p",defaultValue = "1") Integer pageNumber,
                                  @RequestParam(value = "firmBookingKeyword",required = false) String keyword, HttpSession session){

      Hotel firm =(Hotel) session.getAttribute("loginFirm");
      Page<Booking> page = bookingService.findBooking(firm.getHotelId(), keyword, pageNumber);
      List<Booking> list = page.getContent();
      mav.getModel().put("bookingList",list);
      mav.getModel().put("page",page);
      mav.getModel().put("firmBookingKeyword",keyword);
      mav.setViewName("firmBookingManage");

      return mav;
  }

  @GetMapping("/firmDeleteBooking")
  public String firmDeleteBooking(@RequestParam(name = "bookingId") Integer id){
      bookingService.deleteBookingById(id);
      return "redirect:firmBookingManage";
  }

  //跳到廠商查看訂單
  @GetMapping("editBooking1")
  public String editBooking1(@RequestParam("bookingId") Integer id,Model model){
      Booking booking = bookingService.getBookingById(id);
      model.addAttribute("bookingBean" ,booking);

      return "firmupdateBooking";

  }

  @PostMapping("editPostBooking1")
  public ModelAndView editBooking1(ModelAndView msv){

      msv.setViewName("redirect:firmBookingManage");
      return msv;
  }
  
  //------------舜麟部分-------------------
  //建立訂單資訊，送回JSP，還沒確認
  @PostMapping("showBooking")
  public String showBooking(Model m, 
		  @RequestParam("roomId") int[] roomid,
		  @RequestParam("selectNum") int[] num,
		  @RequestParam("loginDate") String loginDate,
		  @RequestParam("logoutDate") String logoutDate
		  ) throws ParseException {
	  //整理下定數量
	  List<Integer> numList = new ArrayList<Integer>();
	  for(int i :num){
		  if(i!=0) {
			  numList.add(i);
		  }
	  }
	  List<Room> roomList = roomService.showBookingRoom(num, roomid);
	  List<Integer> roomIdList = new ArrayList<Integer>();
	  for(Room r : roomList) {
		  roomIdList.add(r.getRoomId());
	  }
	  Util util = new Util();
	  int size = util.getBetween(loginDate, logoutDate).size();
	  String loginWeek = util.getWeek(loginDate);
	  String logoutWeek = util.getWeek(logoutDate);
	  int totalPrice = util.getTotalPrice(numList,roomList);
	  Hotel hotel = hotelService.findById(roomList.get(0).getHotelId());
	  m.addAttribute("numlist",numList);
	  m.addAttribute("roomlist",roomList);
	  m.addAttribute("roomIdList",roomIdList);
	  m.addAttribute("between",size-1);
	  m.addAttribute("loginDate",loginDate);
	  m.addAttribute("logoutDate",logoutDate);
	  m.addAttribute("loginWeek",loginWeek);
	  m.addAttribute("logoutWeek",logoutWeek);
	  m.addAttribute("totalPrice",totalPrice);
	  m.addAttribute("hotel",hotel);
	  return "bookingPage";
  }


}
	
