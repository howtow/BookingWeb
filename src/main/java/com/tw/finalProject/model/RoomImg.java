package com.tw.finalProject.model;

import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "RoomImg")
public class RoomImg {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "RoomImgID")
	private Integer roomImgId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "RoomID")
	@JsonIgnore
	private Room room;
	
	@Lob
	@Column(name = "Img")
	private byte[] img;
	
	@Column(name = "ImgDescribe")
	private String imgDescribe;
	
	public RoomImg() {
	}

	public Integer getRoomImgId() {
		return roomImgId;
	}

	public void setRoomImgId(Integer roomImgId) {
		this.roomImgId = roomImgId;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public byte[] getImg() {
		return img;
	}

	public void setImg(byte[] img) {
		this.img = img;
	}

	public String getImgDescribe() {
		return imgDescribe;
	}

	public void setImgDescribe(String imgDescribe) {
		this.imgDescribe = imgDescribe;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RoomImg [roomImgId=");
		builder.append(roomImgId);
		builder.append(", room=");
		builder.append(room.getRoomId());
		builder.append(", img=");
		builder.append(Arrays.toString(img));
		builder.append(", imgDescribe=");
		builder.append(imgDescribe);
		builder.append("]");
		return builder.toString();
	}

}
