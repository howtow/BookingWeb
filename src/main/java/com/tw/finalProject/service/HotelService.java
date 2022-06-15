package com.tw.finalProject.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tw.finalProject.model.BookingRepository;
import com.tw.finalProject.model.CommentRepository;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.model.HotelRepository;
import com.tw.finalProject.model.Room;
import com.tw.finalProject.model.RoomRepository;
import com.tw.finalProject.util.Util;

@Service
@Transactional
public class HotelService {

	@Autowired
	private HotelRepository hotelDao;

	@Autowired
	private BookingRepository bookingDao;

	@Autowired
	private RoomRepository roomDao;

	private Direction desc = Sort.Direction.DESC;

	private Direction asc = Sort.Direction.ASC;

	// 找單間ByID
	public Hotel findById(int id) {
		Optional<Hotel> rs = hotelDao.findById(id);
		if (rs.isPresent()) {
			Hotel h = rs.get();
			return h;
		}
		return null;
	}

	// 全找.丟回page
	public Page<Hotel> findAllByPage(Integer pageNumber, String order, String orderby) {
		Direction o = null;
		if (order.equals("desc")) {
			o = desc;
		}
		if (order.equals("asc")) {
			o = asc;
		}
		Pageable pgb = PageRequest.of(pageNumber - 1, 5, o, orderby);
		Page<Hotel> page = hotelDao.findAll(pgb);
		return page;
	}

	// findByRegionOrTown
	public Page<Hotel> selectHotelByRegionOrTown(Integer pageNumber, String order, String orderby, String keyword) {
		Direction o = null;
		if (order.equals("desc")) {
			o = desc;
		}
		if (order.equals("asc")) {
			o = asc;
		}
		Pageable pgb = PageRequest.of(pageNumber - 1, 5, o, orderby);
		Page<Hotel> page = hotelDao.findAllByRegionContainingOrTownContaining(keyword, keyword, pgb);
		return page;
	}

	// 全條件搜有空房的飯店
	public Page<Hotel> searchHotelOfEmptyRoom(String keyword, String loginDate, String logoutDate, String num,
			int pageNumber, String order, String orderby, String tag, String business) {
		// 整理Page格式
		Direction o = null;
		if (order.equals("desc")) {
			o = desc;
		}
		if (order.equals("asc")) {
			o = asc;
		}
		Pageable pgb = PageRequest.of(pageNumber - 1, 5, o, orderby);

		// 整理標籤
		String[] tags = tag.split(",");
		List<String> tagList = new ArrayList<String>();
		for (String a : tags) {
			if (!a.equals("")) {
				tagList.add(a);
			}
		}
		for (int i = tagList.size(); i <= 30; i++) {
			tagList.add("");
		}

		// 先找出符合關鍵字和標籤的所有飯店,「排序直接在這做!!」
		List<Hotel> hotelList = new ArrayList<Hotel>();
		if (business.equals("on")) {
			// 商務出差要另外搜尋標籤有停車或網路的飯店
			hotelList = hotelDao.searchHotelByKeywordAndTag(keyword, tagList.get(0), tagList.get(1), tagList.get(2),
					tagList.get(3), tagList.get(4), tagList.get(5), tagList.get(6), tagList.get(7), tagList.get(8),
					tagList.get(9), tagList.get(10), tagList.get(11), tagList.get(12), tagList.get(13), tagList.get(14),
					tagList.get(15), tagList.get(16), tagList.get(17), tagList.get(18), tagList.get(19),
					tagList.get(20), tagList.get(21), tagList.get(22), tagList.get(23), tagList.get(24),
					tagList.get(25), tagList.get(26), tagList.get(27), tagList.get(28), tagList.get(29), "停車", "網路",
					Sort.by(o, orderby));
		} else {
			// 一般旅遊按照勾選標籤搜尋就好
			hotelList = hotelDao.searchHotelByKeywordAndTag(keyword, tagList.get(0), tagList.get(1), tagList.get(2),
					tagList.get(3), tagList.get(4), tagList.get(5), tagList.get(6), tagList.get(7), tagList.get(8),
					tagList.get(9), tagList.get(10), tagList.get(11), tagList.get(12), tagList.get(13), tagList.get(14),
					tagList.get(15), tagList.get(16), tagList.get(17), tagList.get(18), tagList.get(19),
					tagList.get(20), tagList.get(21), tagList.get(22), tagList.get(23), tagList.get(24),
					tagList.get(25), tagList.get(26), tagList.get(27), tagList.get(28), tagList.get(29),
					Sort.by(o, orderby));
		}
		// 如果沒設時間就不做空房篩選直接return
		if (loginDate.equals("") || logoutDate.equals("")) {
			int start = (int) pgb.getOffset();
			int end = Math.min((start + pgb.getPageSize()), hotelList.size());
			final Page<Hotel> page = new PageImpl<Hotel>(hotelList.subList(start, end), pgb, hotelList.size());
			return page;
		}

		// 整理要搜尋的所有日期
		List<String> between = new Util().getBetween(loginDate, logoutDate);

		// 檢查飯店房間數-該日訂單量(先暫時以一筆一間做計算)>0代表有空房
		List<Hotel> newList = new ArrayList<Hotel>();
		for (Hotel hotel : hotelList) {
			// 飯店里所有房間
			roomLoop: for (Room room : hotel.getRoom()) {
				for (String date : between) {
					// 房間數量 - 訂單中該日期.該房間被訂走的數量,
					//最後一天退房，上下午分開所以下午還是可以賣
					if(date == between.get(between.size()-1)) {
						newList.add(hotel);
						break roomLoop;
					}else {
						// 假設>0代表有房間可訂，把該飯店記錄下來，直接跳出迴圈換確認下一間飯店，否則就繼續搜尋
						if (room.getUpperLimit() - bookingDao.getNumByIdAndDate(room.getRoomId(), date) > 0) {
							newList.add(hotel);
							break roomLoop;
						}						
					}
				}
			}
		}
		// 最後得到的就是符合所有條件又有空房的飯店列表，轉成Page return
		int start = (int) pgb.getOffset();
		int end = Math.min((start + pgb.getPageSize()), newList.size());
		final Page<Hotel> page = new PageImpl<Hotel>(newList.subList(start, end), pgb, newList.size());
		return page;
	}

	// 首頁input列表autocomplete
	public List<String> locationList() {
		List<String> list1 = hotelDao.findRegionByHotelOrderByRegion();
		List<String> list2 = hotelDao.findRegionAndTownByHotelOrderByRegion();
		for (String s : list2) {
			list1.add(s);
		}
		return list1;
	}

	// 首頁飯店展示
	public List<Hotel> hotelExhibit() {
		List<Hotel> list = hotelDao.findTop4OrderByPrice();
		return list;
	}

	// =======================明翰的部份

    public Page<Hotel> findHotelByPage(Integer pageNumber) {
        Pageable request = PageRequest.of(pageNumber - 1, 10, Sort.Direction.ASC, "hotelId");
        Page<Hotel> hotels = hotelDao.findAll(request);
        return hotels;
    }
    //    刪除旅館
    public void deleteHotelById(Integer id) {
        hotelDao.deleteByHotelId(id);
    }

    //    找到旅館資料
    public Hotel getHotelById(Integer id) {
        Hotel hotel = hotelDao.findHotelByHotelId(id);
        return hotel;
    }

    //    更新旅館
    public void updateHotel(Hotel hotel) {
         hotelDao.save(hotel);
    }

    //新增旅館
    public void addHotel(Hotel hotel){
        hotelDao.save(hotel);
    }


    //拿到房間列表
    public Page<Hotel> hotelList(Integer pageNumber,String keyword){
        Pageable pageable = PageRequest.of(pageNumber - 1, 10, Sort.Direction.ASC, "hotelId");
        if(keyword != null){
            return hotelDao.hotelList(keyword,pageable);

        }
        return hotelDao.findAll(pageable);
    }

    //廠商登入
    public Hotel login(String account,String password){
        Hotel tempMember = hotelDao.findByHotelAccountAndHotelPassword(account, password);
        if(tempMember!=null){
            return tempMember;
        }else {
            return null;
        }
    }

    //旅館數
    public Integer hotelSum(){
        return hotelDao.hotelSum();
    }

}
