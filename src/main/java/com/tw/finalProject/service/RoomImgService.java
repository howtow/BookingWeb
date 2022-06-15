package com.tw.finalProject.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tw.finalProject.model.RoomImg;
import com.tw.finalProject.model.RoomImgRepository;

@Service
@Transactional
public class RoomImgService {

    @Autowired
    private RoomImgRepository roomImgDao;

    public void saveRoomImg(RoomImg roomImg){

        roomImgDao.save(roomImg);
    }

    public List<RoomImg> getRoomImgByRoomID(Integer id){
        return roomImgDao.getALLImg(id);
    }

    public RoomImg getImgById(Integer id){

        Optional<RoomImg> option = roomImgDao.findById(id);
        return option.orElse(null);
    }

    //刪除圖片
    public void deleteImgByImgId(Integer id){
        roomImgDao.deleteById(id);

    }
}