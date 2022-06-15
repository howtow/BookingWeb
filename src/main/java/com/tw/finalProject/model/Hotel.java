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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Hotel")
public class Hotel {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "HotelID")
	private Integer hotelId;
	
	@Column(name = "Name")
	private String hotelName;
	
	@Column(name = "Description")
	private String description;
	
	@Column(name = "Address")
	private String add;
	
	@Column(name = "Region")
	private String region;
	
	@Column(name = "Px")
	private String px;
	
	@Column(name = "Py")
	private String py;
	
	@Column(name = "Town")
	private String town;

	@Column(name = "Tel")
	private String Tel;
	
	@Column(name = "Pics")
	private String pics;
	
	@Column(name = "PicDIscribe")
	private String picDIscribe;
	
	@Column(name = "Serviceinfo")
	private String serviceinfo;
	
	@Column(name = "Parkinginfo")
	private String parkinginfo;
	
	@Column(name = "TotalNumberofRooms")
	private Integer totalNumberofRooms;
	
	@Column(name = "LowestPrice")
	private Integer lowestPrice;
	
	@Column(name = "CeilingPrice")
	private Integer ceilingPrice;
	
	@Column(name = "HotelAccount")
	private String hotelAccount;
	
	@Column(name = "HotelPassword")
	private String hotelPassword;
	
	@Column(name = "AverageRating")
	private Double averageRating;
	
	//明翰加了jsonignore
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hotel", cascade = CascadeType.ALL)
	private Set<Room> room = new LinkedHashSet<Room>();
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hotel", cascade = CascadeType.ALL)
	private Set<Comment> comment = new LinkedHashSet<Comment>();
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hotel", cascade = CascadeType.ALL)
	private Set<Booking> booking = new LinkedHashSet<Booking>();
	
	public Hotel() {
	}

	public Integer getHotelId() {
		return hotelId;
	}

	public void setHotelId(Integer hotelId) {
		this.hotelId = hotelId;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAdd() {
		return add;
	}

	public void setAdd(String add) {
		this.add = add;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getTown() {
		return town;
	}

	public void setTown(String town) {
		this.town = town;
	}

	public String getPx() {
		return px;
	}

	public void setPx(String px) {
		this.px = px;
	}

	public String getPy() {
		return py;
	}

	public void setPy(String py) {
		this.py = py;
	}

	public String getTel() {
		return Tel;
	}

	public void setTel(String tel) {
		Tel = tel;
	}

	public String getPics() {
		return pics;
	}

	public void setPics(String pics) {
		this.pics = pics;
	}

	public String getPicDIscribe() {
		return picDIscribe;
	}

	public void setPicDIscribe(String picDIscribe) {
		this.picDIscribe = picDIscribe;
	}

	public String getServiceinfo() {
		return serviceinfo;
	}

	public void setServiceinfo(String serviceinfo) {
		this.serviceinfo = serviceinfo;
	}

	public String getParkinginfo() {
		return parkinginfo;
	}

	public void setParkinginfo(String parkinginfo) {
		this.parkinginfo = parkinginfo;
	}

	public Integer getTotalNumberofRooms() {
		return totalNumberofRooms;
	}

	public void setTotalNumberofRooms(Integer totalNumberofRooms) {
		this.totalNumberofRooms = totalNumberofRooms;
	}

	public Integer getLowestPrice() {
		return lowestPrice;
	}

	public void setLowestPrice(Integer lowestPrice) {
		this.lowestPrice = lowestPrice;
	}

	public Integer getCeilingPrice() {
		return ceilingPrice;
	}

	public void setCeilingPrice(Integer ceilingPrice) {
		this.ceilingPrice = ceilingPrice;
	}

	public String getHotelAccount() {
		return hotelAccount;
	}

	public void setHotelAccount(String hotelAccount) {
		this.hotelAccount = hotelAccount;
	}

	public String getHotelPassword() {
		return hotelPassword;
	}

	public void setHotelPassword(String hotelPassword) {
		this.hotelPassword = hotelPassword;
	}

	public double getAverageRating() {
		return averageRating;
	}

	public void setAverageRating(double averageRating) {
		this.averageRating = averageRating;
	}

	public Set<Room> getRoom() {
		return room;
	}

	public void setRoom(Set<Room> room) {
		this.room = room;
	}
	
	public Set<Comment> getComment() {
		return comment;
	}

	public void setComment(Set<Comment> comment) {
		this.comment = comment;
	}

	public Set<Booking> getBooking() {
		return booking;
	}

	public void setBooking(Set<Booking> booking) {
		this.booking = booking;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Hotel [hotelId=");
		builder.append(hotelId);
		builder.append(", hotelName=");
		builder.append(hotelName);
		builder.append(", description=");
		builder.append(description);
		builder.append(", add=");
		builder.append(add);
		builder.append(", region=");
		builder.append(region);
		builder.append(", px=");
		builder.append(px);
		builder.append(", py=");
		builder.append(py);
		builder.append(", town=");
		builder.append(town);
		builder.append(", Tel=");
		builder.append(Tel);
		builder.append(", pics=");
		builder.append(pics);
		builder.append(", picDIscribe=");
		builder.append(picDIscribe);
		builder.append(", serviceinfo=");
		builder.append(serviceinfo);
		builder.append(", parkinginfo=");
		builder.append(parkinginfo);
		builder.append(", totalNumberofRooms=");
		builder.append(totalNumberofRooms);
		builder.append(", lowestPrice=");
		builder.append(lowestPrice);
		builder.append(", ceilingPrice=");
		builder.append(ceilingPrice);
		builder.append(", hotelAccount=");
		builder.append(hotelAccount);
		builder.append(", hotelPassword=");
		builder.append(hotelPassword);
		builder.append(", averageRating=");
		builder.append(averageRating);
		builder.append("]");
		return builder.toString();
	}

}
