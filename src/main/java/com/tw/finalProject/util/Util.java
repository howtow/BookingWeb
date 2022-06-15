package com.tw.finalProject.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.tw.finalProject.model.Room;

public class Util {
	
	//計算兩個日期String之間的所有日子
	public List<String> getBetween(String startday,String endday){
		startday = startday.replace("/", "-");
		endday = endday.replace("/", "-");
		SimpleDateFormat df = new SimpleDateFormat ("yyyy-MM-dd");
		List<String> dateList = new ArrayList<String>();
		try {
			Date start = df.parse(startday);
			Date end = df.parse(endday);
			Calendar calendar = Calendar.getInstance();
			while(start.getTime()<=end.getTime()) {
				dateList.add(df.format(start));
				calendar.setTime(start);
				calendar.add(Calendar.DATE, 1);
				start = calendar.getTime();
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dateList;
	}
	
	//string算出星期幾
	public String getWeek(String date) throws ParseException {
		SimpleDateFormat dfParse = new SimpleDateFormat ("yyyy-MM-dd");
		SimpleDateFormat dfFormat = new SimpleDateFormat ("EEEE");
		String loginWeek = dfFormat.format(dfParse.parse(date));
		return loginWeek;
	}
	
	//算訂單總價
	public int getTotalPrice(List<Integer> num, List<Room> room) {
		int total = 0;
		int c = 0;
		for(int i=0 ; i<num.size() ; i++) {
			c = num.get(i);
			total += c*Integer.parseInt(room.get(i).getPrice());
		}
		return total;
	}
	
}
