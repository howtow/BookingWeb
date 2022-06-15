package com.tw.finalProject.service;

import com.tw.finalProject.model.Booking;
import com.tw.finalProject.model.BookingRepository;
import com.tw.finalProject.util.Util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class BookingService {

	@Autowired
	private BookingRepository bookingDao;
	
	
	// 找到訂單狀態
	public List<Booking> findByOrderCheck(String state, Integer userId){
		List<Booking> result = bookingDao.findByState(state, userId);
		return result;
	}
	
	public List<Booking> findAllByUserId(Integer userId){
		List<Booking> result = bookingDao.findAllByUserId(userId);
		return result;
	}
	//--------------------------------------------明翰
    //    根據頁數找到幾筆資料
    public Page<Booking> findByPage(Integer pageNumber) {
        Pageable pageRequest = PageRequest.of(pageNumber - 1, 10, Sort.Direction.DESC, "bookingId");
        Page<Booking> bookings = bookingDao.findAll(pageRequest);
        return bookings;
    }
    //    根據頁數找到幾筆資料 顯示最近訂單
    public Page<Booking> findByPage1(Integer pageNumber) {
        Pageable pageRequest = PageRequest.of(pageNumber - 1, 10, Sort.Direction.DESC, "bookingId");
        Page<Booking> bookings = bookingDao.findAll(pageRequest);
        return bookings;
    }
    //    刪除會員
    public void deleteBookingById(Integer id) {
        bookingDao.deleteByBookingId(id);
    }

    //    找到訂單資料
    public Booking getBookingById(Integer id) {
        Booking booking = bookingDao.findBookingByBookingId(id);
        return booking;
    }

    //    更新訂單
    public void updateBooking(Booking booking) {
        Booking booking1 = bookingDao.save(booking);
    }

    //訂單總額
    public Integer bookingSum(){
        return bookingDao.BookingSum();
    }


//    -------------------------------------------------
//    廠商自己的訂單

    public Page<Booking> findBooking(Integer id,String keyword,Integer pageNumber){
        Pageable pageable = PageRequest.of(pageNumber - 1, 10, Sort.Direction.DESC, "bookingId");
        if (keyword!=null){
            return bookingDao.findBookingByHotel_HotelId2(keyword,id,pageable);
        }
        return bookingDao.findBookingByHotel_HotelId(id,pageable);


    }
    //廠商訂單總額
    public Integer firmBookingSum(Integer id){
        return bookingDao.firmBookingSum(id);
    }

    //    根據頁數找到幾筆資料 顯示最近訂單
    public Page<Booking> findByPage1(Integer pageNumber,Integer id) {
        Pageable pageRequest = PageRequest.of(pageNumber - 1, 10, Sort.Direction.DESC, "bookingId");
        Page<Booking> bookings = bookingDao.findBookingByHotel_HotelId(id,pageRequest);
        return bookings;
    }
	
	//-------------------舜麟部分-------------------
    //建立臨時訂單(先不save),每種房型/每個房間都拆成單獨訂單
	 public List<Booking> buildNewBooking(
    		String loginDate,
    		String logoutDate,
    		String name,
    		String mail,
    		String annotation,
    		String arriveTimes,
    		int[] num,
    		int[] roomId,
    		int hotelId,
    		int userId
    		){
    	//訂單:住宿時間整理成String
    	List<String> betweenList = new Util().getBetween(loginDate, logoutDate);
    	String between = "";
    	for(String s : betweenList) {
    		between += s;
    		if(s != betweenList.get(betweenList.size()-1)) {
    			between += ",";
    		}
    	}
    	List<Booking> bookingList = new ArrayList<Booking>();
    	//訂單:每筆只放一間/一種房型
    	for(int index=0 ; index<num.length ; index++) {
    		for(int roomnum=0 ; roomnum<num[index] ; roomnum++) {
    			Booking booking = new Booking();
    			booking.setState("未確認");
    			booking.setDateOfStay(between);
    			booking.setBookingName(name);
    			booking.setEmail(mail);
    			booking.setAnnotation(annotation);
    			booking.setArriveTimes(arriveTimes);
    			booking.setUserId(userId);
    			booking.setHotelId(hotelId);
    			booking.setRoomId(roomId[index]);
    			//加入要回傳的List
    			bookingList.add(booking);
    			System.out.println(booking);
    		}
    	}
    	
    	return bookingList;
    }
}
