package com.tw.finalProject.model;

import javax.servlet.http.HttpServletRequest;

public class Utility {

	public static String getSiteURL(HttpServletRequest request) {
		String siteURL = request.getRequestURL().toString();
		
		String servletPath = request.getServletPath().toString(); 
		String replace = siteURL.replace(request.getServletPath(), "");
		
		//此路徑以“/”字符開頭，包括 servlet 名稱或 servlet 的路徑，但不包括任何額外的路徑信息或查詢字符串
		return replace;
	}

}
