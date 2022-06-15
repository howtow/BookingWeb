package com.tw.finalProject.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tw.finalProject.model.Comment;
import com.tw.finalProject.model.CommentRepository;

@Service
@Transactional
public class CommentService {

	@Autowired
	private CommentRepository commentDao;

	private Direction desc = Sort.Direction.DESC;

	private Direction asc = Sort.Direction.ASC;

	// 找評論,評分排序
	public Page<Comment> findAllByHotelId(int id, int page, String order, String orderBy) {
		Direction o = null;
		if (order.equals("desc")) {
			o = desc;
		}
		if (order.equals("asc")) {
			o = asc;
		}
		Pageable pgb = PageRequest.of(page - 1, 5, o, orderBy);
		Page<Comment> commentlist = commentDao.findAllByHotelId(id, pgb);
		return commentlist;
	}
	//新增評論
		public void addComment(String comment,Integer userId,Integer bookingId,Integer hotelId,Integer roomId,double rating, Date commentTime) {
			commentDao.addComment(comment, userId, bookingId, hotelId, roomId, rating, commentTime);
		}

	// ============================================明翰

		   //找到所有評論
	    public Page<Comment> commentList(Integer pageNumber,String keyword){
	        Pageable pageable = PageRequest.of(pageNumber - 1, 10, Sort.Direction.ASC, "commentId");
	        if (keyword!=null){
	            return commentDao.commentList(keyword, pageable);
	        }
	            return commentDao.findAll(pageable);
	    }

	    //刪除評論
	    public void deleteComment(Integer id){

	        commentDao.deleteCommentByCommentId(id);
	    }

	    //評論數
	    public Integer commentSum(){
	        return commentDao.commentSum();
	    }

//	    -------------------------------------------

	    //廠商找到自己的評論
	    public Page<Comment> findComment(Integer id,String keyword,Integer pageNumber){
	        Pageable pageable = PageRequest.of(pageNumber - 1, 10, Sort.Direction.ASC, "commentId");

	        if (keyword!=null){
	            return commentDao.findCommentByHotel_HotelId(keyword,id,pageable);

	        }
	        return commentDao.findCommentByHotel_HotelId2(id,pageable);

	    }

	    //廠商評論數
	    public Integer getFirmCommentSum(Integer id){
	        return commentDao.firmCommentSum(id);
	    }


}
