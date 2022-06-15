package com.tw.finalProject.model;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotEmpty;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Customer")
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "UserID")
	private Integer userId;

	@Column(name = "Email", unique = true, length = 45) // Email為unique
	private String email;

	@Column(name = "Password", length = 64)
	private String password;

	@Column(name = "UserName")
	@NotEmpty(message = "請輸入名字")
	private String userName;

	@Column(name = "Phone")
	private Integer phone;

	@DateTimeFormat(pattern = "yyyy/MM/dd")
	@Temporal(TemporalType.DATE)
	@Column(name = "Birthday", columnDefinition = "date")
	private Date birthday;

	@Column(name = "Nationality")
	private String nationality;

	@Column(name = "Gender")
	private String gender;

	@Column(name = "Address")
	private String address;

	@Column(name = "CreditCard")
	private String creditCard;

	@Column(name = "State", length = 2)
	private String state;

	@Column(name = "Enabled")
	private boolean enabled;
	
	@Column(name = "Verification_code", updatable = false)
	private String verificationCode;
	
	@Column(name = "Salt")
	private Integer salt;
	
	@Lob
	@Column(name = "photo")
	private byte[] photo;
	
	@Column(name = "favorite")
	private String favorite;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customer", cascade = CascadeType.ALL)
	@JsonIgnore
	private Set<Comment> comment = new LinkedHashSet<Comment>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customer", cascade = CascadeType.ALL)
	@JsonIgnore
	private Set<Booking> booking = new LinkedHashSet<Booking>();

	public Customer() {
	}

	
	
	public boolean isEnabled() {
		return enabled;
	}



	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}



	public String getVerificationCode() {
		return verificationCode;
	}



	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}



	public Integer getSalt() {
		return salt;
	}



	public void setSalt(Integer salt) {
		this.salt = salt;
	}



	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getPhone() {
		return phone;
	}

	public void setPhone(Integer phone) {
		this.phone = phone;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCreditCard() {
		return creditCard;
	}

	public void setCreditCard(String creditCard) {
		this.creditCard = creditCard;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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
	
	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getFavorite() {
		return favorite;
	}
	
	public void setFavorite(String favorite) {
		this.favorite = favorite;
	}



	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Customer [userId=");
		builder.append(userId);
		builder.append(", email=");
		builder.append(email);
		builder.append(", password=");
		builder.append(password);
		builder.append(", userName=");
		builder.append(userName);
		builder.append(", phone=");
		builder.append(phone);
		builder.append(", birthday=");
		builder.append(birthday);
		builder.append(", nationality=");
		builder.append(nationality);
		builder.append(", gender=");
		builder.append(gender);
		builder.append(", address=");
		builder.append(address);
		builder.append(", creditCard=");
		builder.append(creditCard);
		builder.append(", state=");
		builder.append(state);
		builder.append(", enabled=");
		builder.append(enabled);
		builder.append(", verificationCode=");
		builder.append(verificationCode);
		builder.append(", salt=");
		builder.append(salt);
		builder.append(", comment=");
		builder.append(comment);
		builder.append(", booking=");
		builder.append(booking);
		builder.append("]");
		return builder.toString();
	}

	
	

}
