package com.tw.finalProject.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tw.finalProject.model.BookingRepository;
import com.tw.finalProject.model.Room;
import com.tw.finalProject.model.RoomImg;
import com.tw.finalProject.model.RoomImgRepository;
import com.tw.finalProject.model.RoomRepository;
import com.tw.finalProject.util.Util;

//=============================================明翰部分
@Service
@Transactional
public class RoomService {

    @Autowired
    private RoomRepository roomDao;

    @Autowired
    private RoomImgRepository roomimgDao;

    @Autowired
    private BookingRepository bookingDao;
    
    public void saveRoom(Room room) {
        roomDao.save(room);
    }

    public void updateRoom(Room room) {

        roomDao.save(room);
    }

    public void deleteRoom(Integer id) {

        roomDao.deleteRoomByRoomId(id);
    }

    public Page<Room> roomList(Integer pageNumber, String keyword) {
//        Sort sort = Sort.by(sortField);
//        sort = sortDir.equals("asc")? sort.ascending():sort.descending();
        Pageable pageable = PageRequest.of(pageNumber - 1, 10, Sort.Direction.ASC, "roomId");
        if (keyword != null) {
            return roomDao.roomList(keyword, pageable);
        }
        return roomDao.findAll(pageable);
    }

    public Room getRoomById(Integer id) {

        return roomDao.findRoomByRoomId(id);
    }

    //房間數
    public Integer roomSum(){
        return roomDao.roomSum();
    }

//    -------------------------------------------------------
    //廠商拿到自己的資料
    public Page<Room> findRoom1(Integer id,String keyword, Integer pageNumber) {
        Pageable pageable = PageRequest.of(pageNumber - 1, 10, Sort.Direction.ASC, "roomId");

        if (keyword != null) {
            Page<Room> room = roomDao.findRoomByHotel_HotelId(keyword, id, pageable);
            return room;
        }
        return roomDao.findRoomByHotel_HotelId2(id, pageable);
    }
    public Integer firmRoomSum(Integer id){
        return roomDao.firmRoomSum(id);
    }
    
    //-----------------------------------------舜麟部分
    //點擊飯店return空房
    public List<Room> findEmptyRoom(
    		int hotelId,
    		String loginDate,
    		String logoutDate,
    		String num){
    
    	List<Room> allRoom = roomDao.findRoomByHotelId(hotelId);
    	//假設沒設時間就直接return
    	if(loginDate.equals("") || logoutDate.equals("")) {
    		return allRoom;
    	}
    	
    	//整理要搜尋的所有日期
    	List<String> between = new Util().getBetween(loginDate, logoutDate);
    	List<Room> emptyRoom = new ArrayList<Room>();
    	roomLoop:
    	for(Room room : allRoom) {
    		for(String date : between) {
    			//該日期該房間已經賣出的數量
    			int sellout = bookingDao.getNumByIdAndDate(room.getRoomId(),date);
    			//入住時間某一天房間上限-已賣出<=0 代表房間不可住
    			if(room.getUpperLimit() - sellout <= 0) {
    				//只要其中一天不可住，就換比對下一間
    				continue roomLoop;
    			}else {
    				//取剩餘的最小房間數
    				if(sellout<room.getRemain()) {
    					room.setRemain(sellout);
    				}
    				//如果跑到最後確定每天都可住.就把該房間加入return的list
    				if(date == between.get(between.size()-1)) {
    					room.setRemain(room.getUpperLimit() - sellout);
    					emptyRoom.add(room);
    				}
    			}    			
    		}
    	}
    	return emptyRoom;
    }

    public List<RoomImg> findImgByRoomId(int id){
    	return roomimgDao.findByRoomId(id);
    }
    
    public RoomImg getImg(int id) {
    	return roomimgDao.findById(id).get();
    }
    
    //找出訂單選擇的房間
    public List<Room> showBookingRoom(int[] num, int[] roomId){
    	List<Room> roomList = new ArrayList<Room>();
    	for(int i=0 ; i<num.length ; i++) {
    		//當數量!=0找出Room加入List,最後return
    		if(num[i] != 0) {
    			roomList.add(roomDao.findById(roomId[i]).get());
    		}
    	}
    	return roomList;
    }
}
