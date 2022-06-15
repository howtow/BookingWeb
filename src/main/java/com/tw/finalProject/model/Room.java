package com.tw.finalProject.model;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Room")
public class Room {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "RoomID")
	private Integer roomId;
	
	@Column(name = "RoomName")
	private String roomName;
	
	@Column(name = "Price")
	private String price;
	
	@Column(name = "Tag")
	private String tag;
	
	@Column(name = "Upper_limit")
	private Integer upperLimit;
	
	@Column(name = "Description")
	private String description;
	
	@Column(name = "Capaticy")
	private Integer capaticy;

	@Column(name = "remain")
	private Integer remain;
	
	@Column(name = "HotelID")
	private Integer hotelId;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "HotelID",insertable = false, updatable = false)
	@JsonIgnore
	private Hotel hotel;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "room", cascade = CascadeType.ALL)
	@JsonIgnore
	private Set<Booking> booking = new LinkedHashSet<Booking>();
	//明翰加了jsonignore
	 @JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "room", cascade = CascadeType.ALL)
	private Set<Comment> comment = new LinkedHashSet<Comment>();
	//明翰加了jsonignore
	 @JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "room", cascade = CascadeType.ALL)
	private Set<RoomImg> roomImg = new LinkedHashSet<RoomImg>();
	
	public Room() {
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getPrice() { 
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public Integer getUpperLimit() {
		return upperLimit;
	}

	public void setUpperLimit(Integer upperLimit) {
		this.upperLimit = upperLimit;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getHotelId() {
		return hotel.getHotelId();
	}

	public void setHotelId(Integer hotelId) {
		this.hotelId = hotelId;
	}
	
	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	public Set<Booking> getBooking() {
		return booking;
	}

	public void setBooking(Set<Booking> booking) {
		this.booking = booking;
	}

	public Set<Integer> getCommentId() {
		LinkedHashSet<Integer> set = new LinkedHashSet<Integer>();
		for(Comment c : comment) {
			set.add(c.getCommentId());
		}
		return set;
	}

	public void setComment(Set<Comment> comment) {
		this.comment = comment;
	}

	public Set<RoomImg> getRoomImg() {
		return roomImg;
	}

	public void setRoomImg(Set<RoomImg> roomImg) {
		this.roomImg = roomImg;
	}

	public int getCapaticy() {
		return capaticy;
	}

	public void setCapaticy(int capaticy) {
		this.capaticy = capaticy;
	}

	public int getRemain() {
		return remain;
	}

	public void setCapaticy(Integer capaticy) {
		this.capaticy = capaticy;
	}
	
	public void setRemain(Integer remain) {
		this.remain = remain;
	}
	
	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Room [roomId=");
		builder.append(roomId);
		builder.append(", roomName=");
		builder.append(roomName);
		builder.append(", price=");
		builder.append(price);
		builder.append(", tag=");
		builder.append(tag);
		builder.append(", upperLimit=");
		builder.append(upperLimit);
		builder.append(", description=");
		builder.append(description);
		builder.append("]");
		return builder.toString();
	}
	
}
