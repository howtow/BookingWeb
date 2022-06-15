package com.tw.finalProject.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;


@Table(name="ad_Email")

public class AdEmail {

	@Id
	@Column(name="email")
	String email;
	
	
	public AdEmail() {
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}

}
