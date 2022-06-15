package com.tw.finalProject.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tw.finalProject.model.Comment;
import com.tw.finalProject.model.CommentRepository;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.service.CommentService;

@Controller
public class CommentController {
	
	
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private CommentRepository dao;
	
	@Autowired
	private CommentService service;
	
	@GetMapping("/CommentList")
	public String listAllComment(Integer userId,Model model) {
		
		List<Comment> tempComment = dao.findAllByUserId(userId);
		
		model.addAttribute("CommentList",tempComment);
		
		return"myComment";
	}
	
	@GetMapping("/deleComment")
	public String deleteCommentByBookingId(@RequestParam(name="bookingId")Integer bookingId,@RequestParam(name="userId")Integer userId) {
		System.out.println("======================================");
		System.out.println(bookingId);
		System.out.println(userId);
		
			dao.deleteCommentByBookingId(bookingId);
			String back = "redirect:CommentList?userId="+userId;
			return back;
	}
	
	@GetMapping("sortCommentByDesc")
	public String listAllBookingByDesc(Integer userId, Model model) {
		List<Comment> tempCommentDesc = dao.findAllByCommentIdOrderByDesc(userId);
		
		model.addAttribute("CommentList", tempCommentDesc);
		
		return "myComment";
	}

//===================================明翰	
    //拿到所有評論資料
    @GetMapping("/commentManage")
    public ModelAndView commentList(ModelAndView mav, @RequestParam(name = "p",defaultValue = "1") Integer pageNumber,
                                    @RequestParam(name = "commentKeyword",required = false) String keyword){
        Page<Comment> commentByPage = commentService.commentList(pageNumber, keyword);
        List<Comment> list = commentByPage.getContent();
        mav.getModel().put("commentList",list);
        mav.getModel().put("page",commentByPage);
        mav.getModel().put("commentKeyword",keyword);
        mav.setViewName("commentManage");
        return mav;

    }

    //刪除評論
    @GetMapping("/deleteComment")
    public String deleteComment(@RequestParam("commentId") Integer id){
        commentService.deleteComment(id);

        return "redirect:commentManage";
    }


//    ----------------------------------------------------------------------
    //廠商找到評論
    @GetMapping("/firmCommentManage")
    public ModelAndView commentList1(ModelAndView mav, @RequestParam(name = "p",defaultValue = "1") Integer pageNumber,
                                     @RequestParam(name = "firmCommentKeyword",required = false) String keyword,
                                     HttpSession session){
        Hotel firm = (Hotel) session.getAttribute("loginFirm");
        Page<Comment> page = commentService.findComment(firm.getHotelId(), keyword, pageNumber);
        List<Comment> list = page.getContent();
        mav.getModel().put("commentList",list);
        mav.getModel().put("page",page);
        mav.getModel().put("commentKeyword",keyword);
        mav.setViewName("firmCommentManage");

        return mav;



    }
    //廠商刪除評論
    @GetMapping("/firmDeleteComment")
    public String firmDeleteComment(@RequestParam("commentId") Integer id){
        commentService.deleteComment(id);

        return "redirect:firmCommentManage";
    }


	
	//-----------------舜麟部分飯店評論
	@GetMapping("/getCommentPage")
	@ResponseBody
	public Page<Comment> showComment(
			@RequestParam(name="hotelId") int id,
			@RequestParam(name="page") int p,
			@RequestParam(name="order",defaultValue = "desc") String order,
			@RequestParam(name="orderBy",defaultValue = "rating") String orderBy){
		Page<Comment> commentPage = commentService.findAllByHotelId(id, p, order, orderBy);
		return commentPage;
	}
	
	
}
