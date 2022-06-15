package com.tw.finalProject.model;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Integer> {
	
//	@Query(value = "SELECT * FROM Booking WHERE userId=(SELECT userId from Customer WHERE userId = ?1)", nativeQuery = true)
//	Optional<List<Booking>> findBookingByUserId(Integer userId);
//	
	@Query("SELECT bk FROM Booking bk WHERE bk.userId = ?1")
	List<Booking> findAllByUserId(Integer Id);
	
	@Query("SELECT bk FROM Booking bk WHERE bk.userId=?1 ORDER BY bk.bookingId DESC")
	List<Booking> findAllByUserIdOrderByDesc(Integer Id);
	
	@Query("SELECT bk FROM Booking bk WHERE bk.userId=?1 ORDER BY bk.bookingId ASC")
	List<Booking> findAllByUserIdOrderByAsc(Integer Id);
	
	@Query("SELECT bk FROM Booking bk WHERE concat(bk.bookingTimes) BETWEEN ?1 AND ?2 ")
	List<Booking> findAllByDateOrderByDesc(String start_date, String end_date);
	
	@Query(" SELECT bk FROM Booking bk WHERE bk.state=?1 and bk.userId=?2 ORDER BY bk.bookingId DESC")
	List<Booking> findByState(String state, Integer userId);
	
	@Query(value="DELETE FROM booking WHERE userId=?1 and bookingId=?2 ",nativeQuery = true )
	@Transactional
	@Modifying
	void deleteBkBybookIdAndUserId(Integer userId, Integer bookingId);
	
	
	//===============================================明翰部分
    @Query("from Booking where bookingId=:id")
    Booking findBookingByBookingId(@Param("id") Integer id);

    void deleteByBookingId(Integer id);

//    -------------------------------------

    //廠商找到自己的訂單
//    @Query("select b from Booking b where b.hotel.hotelId=?1")
    Page<Booking> findBookingByHotel_HotelId(Integer id, Pageable pageable);

    //廠商搜尋自己訂單
    @Query("select b from Booking b where concat(b.bookingName,b.annotation,b.email) like %?1% and b.hotel.hotelId=?2")
    Page<Booking> findBookingByHotel_HotelId2(String keyword,Integer id,Pageable pageable);

    //訂單總額
    @Query(value = "select sum(cast(Room.price as int)) from dbo.Booking join dbo.Room on Booking.RoomID=Room.RoomID",nativeQuery = true)
    Integer BookingSum();

    @Query(value = "select sum(cast(Room.price as int)) from dbo.Booking join dbo.Room on Booking.RoomID=Room.RoomID where Booking.HotelID=?1",nativeQuery = true)
    Integer firmBookingSum(Integer id);

    
    //===============================================舜麟部分
    @Query(value = "select count(*) from booking where roomid=?1 and DateOfStay like %?2%",nativeQuery = true)
	public int getNumByIdAndDate(int id, String date);
}

