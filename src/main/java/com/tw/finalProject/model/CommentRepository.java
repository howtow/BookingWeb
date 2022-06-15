package com.tw.finalProject.model;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

	@Query("SELECT cm FROM Comment cm WHERE cm.userId = ?1")
	List<Comment> findAllByUserId(Integer Id);

	@Query("SELECT cm FROM Comment cm WHERE cm.userId=?1 ORDER BY cm.commentId DESC")
	List<Comment> findAllByCommentIdOrderByDesc(Integer Id);

	@Query("SELECT cm FROM Comment cm WHERE cm.hotelId = ?1")
	Page<Comment> findAllByHotelId(Integer Id, Pageable pageable);

	Comment findCommentByCommentId(Integer Id);

	@Query("delete from Comment cm where cm.commentId=?1")
	@Transactional
	@Modifying
	void deleteCommentByCommentId(Integer id);
	
	@Query("delete from Comment cm where cm.bookingId=?1")
	void deleteCommentByBookingId(Integer Id);

	@Query(value = "INSERT INTO Comment (comment,userId,bookingId,hotelId,roomId,rating,commentTime) VALUES (?1 ,?2 ,?3 ,?4 ,?5 ,?6 ,?7)", nativeQuery = true)
	@Transactional
	@Modifying
	void addComment(String comment, Integer userId, Integer bookingId, Integer hotelId, Integer roomId, double rating,
			Date commentTime);

	@Query("select c from Comment c where concat(c.comment, c.hotel.hotelName, c.room.roomName) like %?1%")
	Page<Comment> commentList(String keyword, Pageable pageable);

	// 評論數
	@Query(value = "select count(*) from dbo.Comment", nativeQuery = true)
	Integer commentSum();

	// 廠商搜尋自己評論
	@Query("select c from Comment c where concat(c.comment, c.hotel.hotelName, c.room.roomName) like %?1% and c.hotel.hotelId=?2")
	Page<Comment> findCommentByHotel_HotelId(String keyword, Integer id, Pageable pageable);

	// 廠商所有評論
	@Query("select c from Comment c where c.hotel.hotelId=?1")
	Page<Comment> findCommentByHotel_HotelId2(Integer id, Pageable pageable);

	@Query(value = "select count(*) from dbo.Comment where HotelId=?1", nativeQuery = true)
	Integer firmCommentSum(Integer id);
}
