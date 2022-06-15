package com.tw.finalProject.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomImgRepository extends JpaRepository<RoomImg,Integer>{
	
	@Query(value = "select * from RoomImg where roomId = ?1", nativeQuery=true)
	List<RoomImg> findByRoomId(int id);
	//-----------------明翰
    @Query("select r from RoomImg r where r.room.roomId=?1")
    List<RoomImg> getALLImg(Integer id);
}
