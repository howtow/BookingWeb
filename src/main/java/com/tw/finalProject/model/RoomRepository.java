package com.tw.finalProject.model;



import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.tw.finalProject.model.Room;

//=============================================明翰部分
@Repository
public interface RoomRepository extends JpaRepository<Room,Integer> {
	
    Room findRoomByRoomId(Integer id);

    void deleteRoomByRoomId(Integer id);

    @Query("select r from Room r where "
            + "concat(r.roomName, r.price, r.tag, r.description)" +
            "like %?1%")
    Page<Room> roomList(String keyword, Pageable pageable);

    //房間數
    @Query(value = "select count(*) from dbo.Room",nativeQuery = true)
    Integer roomSum();


    //    廠商搜尋自己所屬房間
    @Query("select r from Room r where concat(r.roomName, r.price, r.tag, r.description) like %?1% and r.hotel.hotelId=?2")
    Page<Room> findRoomByHotel_HotelId(String keyword, Integer id, Pageable pageable);

    //廠商全部的房間
    @Query("select r from Room r where r.hotel.hotelId=?1")
    Page<Room> findRoomByHotel_HotelId2(Integer id, Pageable pageable);

    //廠商房間數
    @Query(value = "select count(*) from dbo.Room join dbo.Hotel on Room.HotelID=Hotel.HotelID where Hotel.HotelID=?1",nativeQuery = true)
    Integer firmRoomSum(Integer id);

    //-----------------------------------------舜麟部分
    @Query(value = "select * from Room where hotelId = ?1",nativeQuery = true)
    List<Room> findRoomByHotelId(Integer id);
}
