package com.tw.finalProject.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.annotation.Transient;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Comment")
public class Comment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "CommentID")
	private Integer commentId;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CommentTime" , columnDefinition = "date")
	private Date commentTime;
	
	@Column(name = "Comment")
	private String comment;
	
	@Column(name = "Rating")
	private double rating;
	
	@Column(name = "UserID")
	private Integer userId;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "UserID",insertable = false, updatable = false)
	private Customer customer;
	
	@Column(name = "BookingID")
	private Integer bookingId;
	@OneToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "BookingID",insertable = false, updatable = false)
	private Booking booking;
	
	@Column(name = "HotelID")
	private Integer hotelId;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "HotelID",insertable = false, updatable = false)
	@JsonIgnore
	private Hotel hotel;
	
	@Column(name = "RoomID")
	@Transient
	private Integer roomId;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "RoomID",insertable = false, updatable = false)
	private Room room;
	
	public Comment() {
	}
	
	@PrePersist // 物件狀態轉換到 Persistent 以前，要做的事情
	public void onCreate() {
		if(commentTime == null) {
			commentTime = new Date();
		}
	}

	public Integer getCommentId() {
		return commentId;
	}

	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Integer getBookingId() {
		return bookingId;
	}

	public void setBookingId(Integer bookingId) {
		this.bookingId = bookingId;
	}

	public Booking getBooking() {
		return booking;
	}

	public void setBooking(Booking booking) {
		this.booking = booking;
	}

	public Integer getHotelId() {
		return hotelId;
	}

	public void setHotelId(Integer hotelId) {
		this.hotelId = hotelId;
	}

	public Hotel getHotel() {
		return hotel;
	}

	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public Date getCommentTime() {
		return commentTime;
	}

	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Comment [commentId=");
		builder.append(commentId);
		builder.append(", comment=");
		builder.append(comment);
		builder.append(", rating=");
		builder.append(rating);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", bookingId=");
		builder.append(bookingId);
		builder.append(", hotelId=");
		builder.append(hotelId);
		builder.append(", roomId=");
		builder.append(roomId);
		builder.append("]");
		return builder.toString();
	}

}
