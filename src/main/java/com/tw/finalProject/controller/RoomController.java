package com.tw.finalProject.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.model.Room;
import com.tw.finalProject.model.RoomImg;
import com.tw.finalProject.service.HotelService;
import com.tw.finalProject.service.RoomImgService;
import com.tw.finalProject.service.RoomService;

//=============================================明翰部分
@Controller
public class RoomController {

//    @Param("sortField") String sortField,
//    @Param("sortDir") String sortDir,

	@Autowired
	private RoomService roomService;

	@Autowired
	private HotelService hotelService;

	@Autowired
	private RoomImgService roomImgService;

    @GetMapping("/roomManage")
    public ModelAndView roomList(ModelAndView mav, @RequestParam(name = "p", defaultValue = "1") Integer pageNumber,
                                 @RequestParam(name = "roomKeyword", required = false) String keyword) {
        Page<Room> page = roomService.roomList(pageNumber, keyword);

        List<Room> roomList = page.getContent();
        mav.getModel().put("page", page);
        mav.getModel().put("roomList", roomList);
        mav.getModel().put("roomKeyword", keyword);
        mav.setViewName("roomManage");
//        model.addAttribute("page", page);
//        model.addAttribute("roomList", roomList);
//        model.addAttribute("sortDir", sortDir);
//        model.addAttribute("sortField", sortField);
//        model.addAttribute("keyword",keyword);
//        String reverseSortDir = sortDir.equals("asc") ? "desc" : "asc";
//        model.addAttribute("reverseSortDir",reverseSortDir);
        return mav;
    }

    //跳到更新房間頁面
    @GetMapping("/editRoom")
    public String editRoom(Model model, @RequestParam("roomId") Integer id) {
        Room room = roomService.getRoomById(id);
        List<RoomImg> list = roomImgService.getRoomImgByRoomID(id);
        System.out.println(list);
        model.addAttribute("roomBean", room);
        model.addAttribute("roomImgByRoomID", list);
        return "updateRoom";
    }

    //
    @GetMapping("downloadImage/{i}")
    @ResponseBody
    public ResponseEntity<byte[]> getImg(@PathVariable("i") Integer id){
        RoomImg img = roomImgService.getImgById(id);
        byte[] imgImg = img.getImg();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG);
        return new ResponseEntity<byte[]>(imgImg  , headers, HttpStatus.OK);
    }


    //更新房間資料
    @PostMapping("postEditRoom")
    public String editCustomer(@ModelAttribute("roomBean") Room room,
                               @RequestParam("pic")MultipartFile[] pic) throws IOException {
        room.setCapaticy(5);
    	room.setRemain(5);
    	for (MultipartFile p : pic) {
            if (!p.isEmpty()) {
                RoomImg img = new RoomImg();
                img.setImg(p.getBytes());
                img.setRoom(room);
                roomImgService.saveRoomImg(img);
                roomService.saveRoom(room);
            }
        }

        roomService.updateRoom(room);
        return "redirect:roomManage";

    }

    //刪除房間
    @GetMapping("deleteRoom")
    public String deleteCustomer(@RequestParam("roomId") Integer id) {
        roomService.deleteRoom(id);

        return "redirect:roomManage";
    }

    //跳到新增房間頁面
    @GetMapping("addRoom")
    public String addRoom() {
        return "addRoom";
    }

    //新增房間
    @PostMapping("/addRoom")
    public String PostAddRoom(Model model,
                              @RequestParam("roomName") String roomName,
                              @RequestParam("price") String price,
                              @RequestParam("allTags") String tag,
                              @RequestParam("upperLimit") Integer upperLimit,
                              @RequestParam("description") String description,
                              @RequestParam("pic") MultipartFile[] pic,
                              @RequestParam("hotelId") Integer hotelId,
                              @RequestParam("imgDescription") String imgDescription)
            throws IOException {
        String[] tagArr = tag.split(",");
        StringBuilder tagBuilder = new StringBuilder();
        for (String s : tagArr) {
            if (!s.isEmpty()) {
                tagBuilder.append(s);
                tagBuilder.append(",");
            }
        }
        tag = tagBuilder.toString();

        Hotel hotelById = hotelService.getHotelById(hotelId);
        if (hotelById != null) {
            Room room = new Room();
            room.setRoomName(roomName);
            room.setPrice(price);
            room.setUpperLimit(upperLimit);
            room.setDescription(description);
            room.setTag(tag);
            
            //直接塞預設
            room.setCapaticy(5);
        	room.setRemain(5);
        	
            //和飯店關聯
            room.setHotelId(hotelId);
            room.setHotel(hotelById);
            roomService.saveRoom(room);
            System.out.println(room);
            //新增房間照片(用RoomImgService)
            for (MultipartFile p : pic) {
                RoomImg img = new RoomImg();
                img.setImg(p.getBytes());
                img.setImgDescribe(imgDescription);
                //和房間關聯
                img.setRoom(room);
                roomImgService.saveRoomImg(img);

            }
            model.addAttribute("message", "新增成功");
            return "redirect:roomManage";
        } else {
            model.addAttribute("message", "找不到此飯店ID");
            return "redirect:addRoom";

        }


    }



//----------------------------------------------------------
//    廠商用
    @GetMapping("/firmRoomManage")
    public ModelAndView roomList1(ModelAndView mav, @RequestParam(name = "p",defaultValue = "1") Integer pageNumber,
                                  @RequestParam(name = "firmRoomKeyword", required = false) String keyword,
                                  HttpSession session){

        Hotel firm = (Hotel) session.getAttribute("loginFirm");
        Page<Room> page = roomService.findRoom1(firm.getHotelId(), keyword,pageNumber);
        List<Room> list = page.getContent();
        mav.getModel().put("roomList", list);
        mav.getModel().put("page",page);
        mav.getModel().put("firmRoomKeyword",keyword);
        mav.setViewName("firmRoomManage");

        return mav;

    }

    //廠商刪除房間
    @GetMapping("/firmDeleteRoom")
    public String firmDeleteRoom(@RequestParam("roomId") Integer id){
        roomService.deleteRoom(id);
        return "redirect:firmRoomManage";
    }

    //跳到新增房間頁面
    @GetMapping("firmAddRoom")
    public String addRoom1() {
        return "firmAddRoom";
    }

    //新增房間
    @PostMapping("/firmAddRoom")
    public String PostAddRoom1(Model model,
                              @RequestParam("roomName") String roomName,
                              @RequestParam("price") String price,
                              @RequestParam("allTags") String tag,
                              @RequestParam("upperLimit") Integer upperLimit,
                              @RequestParam("description") String description,
                              @RequestParam("pic") MultipartFile[] pic,
                              @RequestParam("imgDescription") String imgDescription,
                               HttpSession session)
            throws IOException {
//        String[] tagArr = tag.split(",");
//        StringBuilder tagBuilder = new StringBuilder();
//        for (String s : tagArr) {
//            if (!s.isEmpty()) {
//                tagBuilder.append(s);
//                tagBuilder.append(",");
//            }
//        }
//        tag = tagBuilder.toString();

        Hotel firm =(Hotel) session.getAttribute("loginFirm");
        Hotel hotelById = hotelService.getHotelById(firm.getHotelId());
            Room room = new Room();
            room.setRoomName(roomName);
            room.setPrice(price);
            room.setUpperLimit(upperLimit);
            room.setDescription(description);
            room.setTag(tag);
            
            //預設
            room.setCapaticy(5);
            room.setRemain(5);
            
            //和飯店關聯
            room.setHotelId(firm.getHotelId());
            room.setHotel(hotelById);
            roomService.saveRoom(room);
            System.out.println(room);
            //新增房間照片(用RoomImgService)
            for (MultipartFile p : pic) {
                RoomImg img = new RoomImg();
                img.setImg(p.getBytes());
                img.setImgDescribe(imgDescription);
                //和房間關聯
                img.setRoom(room);
                roomImgService.saveRoomImg(img);

            }
            model.addAttribute("message", "新增成功");
            return "redirect:firmRoomManage";

        }
    //廠商跳到更新房間頁面
    @GetMapping("/firmEditRoom")
    public String firmEditRoom(Model model, @RequestParam("roomId") Integer id) {
        Room room = roomService.getRoomById(id);
        List<RoomImg> list = roomImgService.getRoomImgByRoomID(id);
        model.addAttribute("roomImgByRoomID",list);
        model.addAttribute("roomBean", room);
        return "firmUpdateRoom";
    }

    //廠商更新房間資料
    @PostMapping("firmPostEditRoom")
    public String firmEditRoom(@ModelAttribute("roomBean") Room room,
                               @RequestParam("pic")MultipartFile[] pic,
                               @RequestParam("imgDescription")String imgDescription) throws IOException {
    	room.setRemain(5);
    	room.setCapaticy(5);
    	for (MultipartFile p : pic) {
            if (!p.isEmpty()) {
                RoomImg img = new RoomImg();
                img.setImg(p.getBytes());
                img.setRoom(room);
                img.setImgDescribe(imgDescription);
                roomImgService.saveRoomImg(img);
                roomService.saveRoom(room);

            }
        }

        roomService.updateRoom(room);
        return "redirect:firmRoomManage";

    }


    //刪除編輯房間裡的圖片
    @GetMapping("deleteImg")
    public ModelAndView deleteImg(@RequestParam("roomImgId") Integer imgId){
        roomImgService.deleteImgByImgId(imgId);
        return new ModelAndView("deleteOk");

    }

	//----------------舜麟---------------------------

	// 找房間所有圖片
	@GetMapping("getRoomimg")
	@ResponseBody
	public List<RoomImg> getRoomimg(@RequestParam("roomId") Integer id) {
		return roomService.findImgByRoomId(id);
	}

	// 取單張圖片
	@GetMapping("downloadRoomImage")
	@ResponseBody
	public ResponseEntity<byte[]> downloadImage(@RequestParam("imgid") int id) {
		RoomImg photo1 = roomService.getImg(id);

		byte[] photoFile = photo1.getImg();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
		// 要回傳的物件, header , httpstatus 回應
		return new ResponseEntity<byte[]>(photoFile, headers, HttpStatus.OK);
	}
}
