package com.tw.finalProject.model;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Integer> {

//	@Query(value = "SELECT * FROM Hotel where Region Like %:region%  or Town like %:region%", nativeQuery = true)
//	public List<Hotel> selectHotelByRegionOrTown(@Param("region") String region);

	public Page<Hotel> findAllByRegionContainingOrTownContaining(String keyword, String keyword2, Pageable pageable);

	@Query("select h from Hotel h " + "where (region+town like %?1%) " + "and serviceinfo like %?2% "
			+ "and serviceinfo like %?3% " + "and serviceinfo like %?4% " + "and serviceinfo like %?5% "
			+ "and serviceinfo like %?6% " + "and serviceinfo like %?7% " + "and serviceinfo like %?8% "
			+ "and serviceinfo like %?9% " + "and serviceinfo like %?10% " + "and serviceinfo like %?11% "
			+ "and serviceinfo like %?12% " + "and serviceinfo like %?13% " + "and serviceinfo like %?14% "
			+ "and serviceinfo like %?15% " + "and serviceinfo like %?16% " + "and serviceinfo like %?17% "
			+ "and serviceinfo like %?18% " + "and serviceinfo like %?19% " + "and serviceinfo like %?20% "
			+ "and serviceinfo like %?21% " + "and serviceinfo like %?22% " + "and serviceinfo like %?23% "
			+ "and serviceinfo like %?24% " + "and serviceinfo like %?25% " + "and serviceinfo like %?26% "
			+ "and serviceinfo like %?27% " + "and serviceinfo like %?28% " + "and serviceinfo like %?29% "
			+ "and serviceinfo like %?30% " + "and serviceinfo like %?31% ")
	public List<Hotel> searchHotelByKeywordAndTag(String keyword, String tag1, String tag2, String tag3, String tag4,
			String tag5, String tag6, String tag7, String tag8, String tag9, String tag10, String tag11, String tag12,
			String tag13, String tag14, String tag15, String tag16, String tag17, String tag18, String tag19,
			String tag20, String tag21, String tag22, String tag23, String tag24, String tag25, String tag26,
			String tag27, String tag28, String tag29, String tag30, Sort sort);

	// 多了商務出差條件
	@Query("select h from Hotel h " + "where (region+town like %?1%) " + "and serviceinfo like %?2% "
			+ "and serviceinfo like %?3% " + "and serviceinfo like %?4% " + "and serviceinfo like %?5% "
			+ "and serviceinfo like %?6% " + "and serviceinfo like %?7% " + "and serviceinfo like %?8% "
			+ "and serviceinfo like %?9% " + "and serviceinfo like %?10% " + "and serviceinfo like %?11% "
			+ "and serviceinfo like %?12% " + "and serviceinfo like %?13% " + "and serviceinfo like %?14% "
			+ "and serviceinfo like %?15% " + "and serviceinfo like %?16% " + "and serviceinfo like %?17% "
			+ "and serviceinfo like %?18% " + "and serviceinfo like %?19% " + "and serviceinfo like %?20% "
			+ "and serviceinfo like %?21% " + "and serviceinfo like %?22% " + "and serviceinfo like %?23% "
			+ "and serviceinfo like %?24% " + "and serviceinfo like %?25% " + "and serviceinfo like %?26% "
			+ "and serviceinfo like %?27% " + "and serviceinfo like %?28% " + "and serviceinfo like %?29% "
			+ "and serviceinfo like %?30% " + "and serviceinfo like %?31% " + "and (serviceinfo like %?32% "
			+ "or serviceinfo like %?33%) ")
	public List<Hotel> searchHotelByKeywordAndTag(String keyword, String tag1, String tag2, String tag3, String tag4,
			String tag5, String tag6, String tag7, String tag8, String tag9, String tag10, String tag11, String tag12,
			String tag13, String tag14, String tag15, String tag16, String tag17, String tag18, String tag19,
			String tag20, String tag21, String tag22, String tag23, String tag24, String tag25, String tag26,
			String tag27, String tag28, String tag29, String tag30, String parking, String net, Sort sort);

	// 關鍵字搜尋用(縣市)
	@Query(value = "select region from hotel group by region", nativeQuery = true)
	public List<String> findRegionByHotelOrderByRegion();

	// 關鍵字搜尋用(縣市+區)
	@Query(value = "select region+town from hotel group by region+town", nativeQuery = true)
	public List<String> findRegionAndTownByHotelOrderByRegion();

	// 首頁展示用(依lowestPrice最高價top4)
	@Query(value = "SELECT TOP 4 * FROM Hotel order by lowestPrice desc", nativeQuery = true)
	public List<Hotel> findTop4OrderByPrice();

	// =============================================明翰部分

	@Query("from Hotel where hotelId=:id")
	public Hotel findHotelByHotelId(@Param("id") Integer id);

	@Query("select r from Room r where r.hotel.hotelId=:id")
	public Room findRoomByHotelId(@Param("id") Integer id);

	public void deleteByHotelId(Integer id);

	@Query("select h from Hotel h where "
			+ "concat(h.hotelName, h.add, h.description, h.Tel, h.serviceinfo, h.parkinginfo)" + "like %?1%")
	Page<Hotel> hotelList(String keyword, Pageable pageable);

	// 廠商帳號密碼登入
	@Query("from Hotel where HotelAccount=?1 and HotelPassword=?2")
	Hotel findByHotelAccountAndHotelPassword(String HotelAccount, String HotelPassword);

    //旅館數
    @Query(value = "select count(*) from dbo.Hotel",nativeQuery = true)
    Integer hotelSum();
}
