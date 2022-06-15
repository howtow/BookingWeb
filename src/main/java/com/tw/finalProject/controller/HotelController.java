package com.tw.finalProject.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tw.finalProject.model.Customer;
import com.tw.finalProject.model.CustomerRespository;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.model.Room;
import com.tw.finalProject.service.CustomerService;
import com.tw.finalProject.service.HotelService;
import com.tw.finalProject.service.RoomService;
import com.tw.finalProject.util.Util;

@Controller
public class HotelController {
	
	@Autowired
	private HotelService hotelService;

	@Autowired
	private RoomService roomService;
	
	@Autowired
	private CustomerRespository cusDao;
	
	//縣市鄉鎮(地圖區域)搜尋
	@GetMapping("/selectHotelByRegionOrTown")
	public String selectHotelByRegionOrTown(
			@RequestParam("keyword") String keyword,
			@RequestParam(name="p", defaultValue="1") Integer pageNumber,
			@RequestParam(name="order", defaultValue="desc") String order,
			@RequestParam(name="orderby", defaultValue="averageRating") String orderby,
			Model model) {
		Page<Hotel> hotelPage = hotelService.selectHotelByRegionOrTown(pageNumber, order, orderby, keyword);
		model.addAttribute("hotelPage",hotelPage);
		model.addAttribute("keyword",keyword);
		model.addAttribute("order",order);
		model.addAttribute("orderby",orderby);
		return "hotelPage";
	}
	
	//全部旅宿
	@GetMapping("/selectAllHotel")
	public String selectAllHotel(
			Model model,
			@RequestParam(name="page", defaultValue="1") Integer pageNumber,
			@RequestParam(name="order", defaultValue="desc") String order,
			@RequestParam(name="orderby", defaultValue="averageRating") String orderby) {
		Page<Hotel> page = hotelService.findAllByPage(pageNumber, order, orderby);
		model.addAttribute("hotelPage",page);
		model.addAttribute("keyword","");
		model.addAttribute("order",order);
		model.addAttribute("orderby",orderby);
		return "hotelPage";
	}
	
	//首頁input搜尋/全條件搜尋
	@GetMapping("/searchEmptyHotel")
	public String searchHotel(
			Model m,
			@RequestParam(name="business", defaultValue="off") String business,
			@RequestParam(name="loginDate", defaultValue="") String loginDate,
			@RequestParam(name="logoutDate", defaultValue="") String logoutDate,
			@RequestParam(name="num", defaultValue="1") String num,
			@RequestParam(name="page", defaultValue="1") Integer pageNumber,
			@RequestParam(name="order", defaultValue="desc") String order,
			@RequestParam(name="orderby", defaultValue="averageRating") String orderby,
			@RequestParam(name="tag", defaultValue="") String tag,
			@RequestParam(name="keyword", defaultValue="") String keyword,
			@RequestParam(name="userId", defaultValue="") String userId
			) throws ParseException {
		
		Page<Hotel> page = hotelService.searchHotelOfEmptyRoom(
				keyword,//關鍵字
				loginDate,//入住日
				logoutDate,//退房日
				num,//人數
				pageNumber,//頁數
				order,//順序
				orderby,//排序方式
				tag,//標籤
				business//是否為商務出差
				);
		if(!userId.equals("")){
			Customer user = cusDao.findById(Integer.parseInt(userId)).get();			
			m.addAttribute("user",user);
		}
		
		m.addAttribute("hotelPage",page);
		m.addAttribute("keyword",keyword);
		m.addAttribute("order",order);
		m.addAttribute("orderby",orderby);
		m.addAttribute("loginDate",loginDate.replace("/", "-"));
		m.addAttribute("logoutDate",logoutDate.replace("/", "-"));
		m.addAttribute("num",num);
		m.addAttribute("business",business);
		return "hotelPage";
	}
	
	//ajax用全條件搜尋 回傳json
	@PostMapping("/searchEmptyHotelJ")
	@ResponseBody
	public Page<Hotel> searchHotelJ(
			Model m,
			@RequestParam(name="business", defaultValue="off") String business,
			@RequestParam(name="loginDate", defaultValue="") String loginDate,
			@RequestParam(name="logoutDate", defaultValue="") String logoutDate,
			@RequestParam(name="num", defaultValue="1") String num,
			@RequestParam(name="page", defaultValue="1") Integer pageNumber,
			@RequestParam(name="order", defaultValue="desc") String order,
			@RequestParam(name="orderby", defaultValue="averageRating") String orderby,
			@RequestParam(name="tag", defaultValue="") String tag,
			@RequestParam(name="keyword", defaultValue="") String keyword
			) throws ParseException {
		
		Page<Hotel> page = hotelService.searchHotelOfEmptyRoom(
				keyword,//關鍵字
				loginDate,//入住日
				logoutDate,//退房日
				num,//人數
				pageNumber,//頁數
				order,//順序
				orderby,//排序方式
				tag,//標籤
				business//是否為商務出差
				);
		return page;
	}
	
	//首頁input autocomplete列表
	@GetMapping("/locationList")
	@ResponseBody
	public List<String> locationList(){
		List<String> locationList = hotelService.locationList();
		return locationList;
	}
	
	//首頁飯店展示
	@GetMapping("/exhibit")
	@ResponseBody
	public List<Hotel> exhibit(){
		List<Hotel> exhibit = hotelService.hotelExhibit();
		return exhibit;
	}
	
	@GetMapping("/hotelDetail")
	public String getById(Model m,
			@RequestParam("id") int hotelId,
			@RequestParam(name="business", defaultValue="off") String business,
			@RequestParam(name="loginDate", defaultValue="") String loginDate,
			@RequestParam(name="logoutDate", defaultValue="") String logoutDate,
			@RequestParam(name="num", defaultValue="1") String num,
			@RequestParam(name="keyword", defaultValue="") String keyword,	
			@RequestParam(name="userId", defaultValue="") String userId
			) {
		//飯店和房間資料分開找
		Hotel rs = hotelService.findById(hotelId);
		String[] picArr = rs.getPics().split(",");
		//找空房間
		List<Room> roomList = roomService.findEmptyRoom(hotelId,loginDate,logoutDate,num);
		m.addAttribute("hotel",rs);
		m.addAttribute("roomList",roomList);
		m.addAttribute("commentSize",rs.getComment().size());
		m.addAttribute("pics",picArr);
		m.addAttribute("business",business);
		m.addAttribute("loginDate",loginDate);
		m.addAttribute("logoutDate",logoutDate);
		m.addAttribute("num",num);
		m.addAttribute("keyword",keyword);
		if(!userId.equals("")) {
			Customer user = cusDao.findById(Integer.parseInt(userId)).get();
			m.addAttribute("user",user);
		}
		if(loginDate.equals("") || logoutDate.equals("")) {
			m.addAttribute("between",0);
		}else {
			int between = new Util().getBetween(loginDate, logoutDate).size();
			m.addAttribute("between",between-1);
		}
		return "hotelInfo";
	}
	
	//==============================明翰後台部份 
	
    //拿到所有旅館資料
    @GetMapping("/hotelManage")
    public ModelAndView hotelList(ModelAndView mav, @RequestParam(name = "p",defaultValue = "1") Integer pageNumber,
                                  @RequestParam(name = "hotelKeyword",required = false) String keyword){
        Page<Hotel> page = hotelService.hotelList(pageNumber, keyword);
        List<Hotel> hotelList = page.getContent();
        mav.getModel().put("page", page);
        mav.getModel().put("hotelList", hotelList);
        mav.getModel().put("hotelKeyword", keyword);
        mav.setViewName("hotelManage");
        return mav;

    }

    //跳到新增旅館頁面
    @GetMapping("addhotel")
    public String addHotel(Model model){
        model.addAttribute("addHotelBean" ,new Hotel());

        return "addHotel";
    }

    //新增旅館
    @PostMapping("/addHotel")
    public String postHotel(@ModelAttribute(name = "addHotelBean") Hotel hotel){
    	//新增的先設0，不可為null
    	hotel.setAverageRating(0);
    	hotel.setPx("0");
    	hotel.setPy("0");
    	
        hotelService.addHotel(hotel);

        return "redirect:hotelManage";
    }


    //跳到更新旅館頁面
    @GetMapping("/editHotel")
    public String editHotel(@RequestParam("hotelId")Integer id,Model model){
        Hotel hotel = hotelService.getHotelById(id);
        model.addAttribute("hotelBean" ,hotel);

        return "updateHotel";
    }

    //更新旅館資料
    @PostMapping("postEditHotel")
    public String editHotel(@ModelAttribute("hotelBean") Hotel hotel){

        hotelService.updateHotel(hotel);
        return "redirect:hotelManage";

    }

    //刪除旅館
    @GetMapping("deleteHotel")
    public String deleteHotel(@RequestParam("hotelId") Integer id){
        hotelService.deleteHotelById(id);

        return "redirect:hotelManage";
    }
//-----------------------------------------------
    //廠商更新旅館資料
    @GetMapping("/firmEditHotel")
    public String firmEditHotel(HttpSession session, Model model){
        Hotel firm = (Hotel) session.getAttribute("loginFirm");
        Hotel hotel = hotelService.getHotelById(firm.getHotelId());
        model.addAttribute("hotelBean" ,hotel);

        return "firmUpdateHotel";
    }

    @PostMapping("firmPostEditHotel")
    public String firmEditHotel(@ModelAttribute("hotelBean") Hotel hotel){
    	hotel.setAverageRating(0);
    	hotel.setPx("0");
    	hotel.setPy("0");
        hotelService.updateHotel(hotel);
        return "firmNewsPage";

    }






    // 根據頁數找到hotel ajax
    @GetMapping("/hotelManage1")
    @ResponseBody
    public List<Hotel> hotelManage(@RequestParam(name = "p",defaultValue = "1")Integer pageNumber){
        Page<Hotel> page = hotelService.findHotelByPage(pageNumber);
        List<Hotel> content = page.getContent();

        return content;
    }

	

	
}
