package com.tw.finalProject.model;

import java.util.Date;

import javax.persistence.CascadeType;
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

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity
@Table(name = "Booking")
public class Booking {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "BookingID")
	private Integer bookingId;
	
	@Column(name = "State")
	private String state;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "BookingTimes" , columnDefinition = "datetime")
	private Date bookingTimes;
	
	@Column(name = "DateOfStay")
	private String dateOfStay;
	
	@Column(name = "BookingName")
	private String bookingName;
	
	@Column(name = "Email")
	private String email;
	
	@Column(name = "CreditCard")
	private String creditCard;
	
	@Column(name = "Annotation")
	private String annotation;
	
	@Column(name = "ArriveTimes")
	private String arriveTimes;
	
	@Column(name = "UserID")
	private Integer userId;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "UserID",insertable = false, updatable = false)
	private Customer customer;
	
	@Column(name = "HotelID")
	private Integer hotelId;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "HotelID",insertable = false, updatable = false)
	@JsonIgnore
	private Hotel hotel;
	
	@Column(name = "RoomID")
	private Integer roomId;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "RoomID",insertable = false, updatable = false)
	@JsonIgnore
	private Room room;
	
	@OneToOne(fetch = FetchType.EAGER, mappedBy = "booking", cascade = CascadeType.ALL)
	@JsonIgnore
	private Comment comment;
	
	public Booking() {
	}
	@PrePersist // 物件狀態轉換到 Persistent 以前，要做的事情
	public void onCreate() {
		if(bookingTimes == null) {
			bookingTimes = new Date();
		}
		if(creditCard == null) {
			creditCard = "0000-0000-0000-0000";
		}
	}
	
	public Integer getBookingId() {
		return bookingId;
	}

	public void setBookingId(Integer bookingID) {
		this.bookingId = bookingID;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getBookingTimes() {
		return bookingTimes;
	}

	public void setBookingTimes(Date bookingTimes) {
		this.bookingTimes = bookingTimes;
	}

	public String getDateOfStay() {
		return dateOfStay;
	}

	public void setDateOfStay(String dateOfStay) {
		this.dateOfStay = dateOfStay;
	}

	public String getBookingName() {
		return bookingName;
	}

	public void setBookingName(String bookingName) {
		this.bookingName = bookingName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) { 
		this.email = email;
	}

	public String getCreditCard() {
		return creditCard;
	}

	public void setCreditCard(String creditCard) {
		this.creditCard = creditCard;
	}

	public String getAnnotation() {
		return annotation;
	}

	public void setAnnotation(String annotation) {
		this.annotation = annotation;
	}

	public String getArriveTimes() {
		return arriveTimes;
	}

	public void setArriveTimes(String arriveTimes) {
		this.arriveTimes = arriveTimes;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getHotelId() {
		return hotelId;
	}
	
	public String getHotelName() {
		return hotel.getHotelName();
	}

	public void setHotelId(Integer hotelID) {
		this.hotelId = hotelID;
	}

	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomID) {
		this.roomId = roomID;
	}

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Booking [bookingId=");
		builder.append(bookingId);
		builder.append(", state=");
		builder.append(state);
		builder.append(", bookingTimes=");
		builder.append(bookingTimes);
		builder.append(", dateOfStay=");
		builder.append(dateOfStay);
		builder.append(", bookingName=");
		builder.append(bookingName);
		builder.append(", email=");
		builder.append(email);
		builder.append(", creditCard=");
		builder.append(creditCard);
		builder.append(", annotation=");
		builder.append(annotation);
		builder.append(", arriveTimes=");
		builder.append(arriveTimes);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", hotelId=");
		builder.append(hotelId);
		builder.append(", roomId=");
		builder.append(roomId);
		builder.append("]");
		return builder.toString();
	}

}

