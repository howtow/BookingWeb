package com.tw.finalProject.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tw.finalProject.model.Customer;
import com.tw.finalProject.model.CustomerRespository;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.model.Utility;
import com.tw.finalProject.service.CustomerService;

@Controller
public class CustomerController {

	@Autowired // 依賴注入 
	private CustomerRespository dao;
	
	@Autowired
	private CustomerService customerService;
	

	@GetMapping("/customerlogout")
	public String customerLoginOut(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		//清除瀏覽器快快取以及Kill the session
		
		request.getSession().invalidate();
		
		Cookie[] cookies = request.getCookies();
		for(Cookie c : cookies) {
			if(c.getName().equals("JSESSIONID")) {
				c.setMaxAge(0);
				break; 
			}
		}
		redirectAttributes.addFlashAttribute("logoutMessage", "已登出，請重新登入");
		return "redirect:customerlogin";

	}
	

	@PostMapping("/process_register")
	public String processRegistration(
			@RequestParam(value = "email") String email, @RequestParam(value = "password") String password,
			@RequestParam(value = "password2") String password2,
			@RequestParam(value = "userName") String userName, 
			@RequestParam(value = "phone") Integer phone,
			@RequestParam(value = "birthday") Date birthday, 
			@RequestParam(value = "nationality") String nationality,
			@RequestParam(value = "gender") String gender, 
			@RequestParam(value = "address") String address,
			@RequestParam(value = "creditCard") String creditCard, 
			@RequestParam(value = "state") String state, 
			RedirectAttributes redirectAttributes,HttpServletRequest request) throws UnsupportedEncodingException, 
			MessagingException {
		
		ArrayList<String> checksignUp = customerService.checksignUp( email, password, password2, userName);
		
		
		if(checksignUp != null) {
			redirectAttributes.addFlashAttribute("signUpError", checksignUp);
			return "redirect:customerlogin";
		}else {
			
			Customer tempCustomer = customerService.encryptAndSave(email, password, userName, phone, birthday, nationality, gender, address, creditCard, state);
			
			String siteURL = Utility.getSiteURL(request);
			
			customerService.sendVerificationEmail(tempCustomer, siteURL);
			
		}

		return "register_success";
	}		
	

	@PostMapping("/checkMail")
	@ResponseBody
	public boolean checkVaildMail(@RequestParam(name="mail" ,defaultValue = "") String mail) {
		
		return customerService.checkDuplicateEmail(mail);

	}
	
	/**
	 * 確認密碼後讓使用者修改
	 * @param password
	 * @param userId
	 * @return
	 */
	@PostMapping("/checkPwd")
	@ResponseBody
	public boolean checkVaildIdentity(@RequestParam(name="password",defaultValue="") String password,@RequestParam(name="userId",defaultValue="") Integer userId){
		
		return customerService.findByUserIdAndPwd(userId, password);
		
	}
	
	@PostMapping("/updatePwd")
	@ResponseBody
	public String updateCusPwd(@RequestParam(name="password") String password,@RequestParam(name="userId",defaultValue="") Integer userId){
		
		System.out.println(password);
		System.out.println(userId);
		customerService.updateNewPassword(password, userId);
		
		return "true";
		
	}
	
	

	@PostMapping("/signIn")
	public String PostLoginForm(@RequestParam("email") String loginEmail, @RequestParam("password") String loginPwd,
			HttpSession httpSession, RedirectAttributes redirectAttributes) {
		

		
		Customer tempCustomer = customerService.isCorrectPassword(loginEmail, loginPwd);
		

		if (tempCustomer == null ||tempCustomer.isEnabled() == false) {
			while(tempCustomer == null) {
				redirectAttributes.addFlashAttribute("loginError", "帳號密碼錯誤，請重新輸入");
				return "redirect:customerlogin";				
			}
			while(tempCustomer.isEnabled() == false) {
				redirectAttributes.addFlashAttribute("loginError", "尚未完成會員Email驗證，請確認信件");
				return "redirect:customerlogin";				
			}
			
		}
		

		httpSession.setAttribute("loginCustomer", tempCustomer);

		return "index";
	}

	@PostMapping("/editSave")
	public String saveEditInfo(@RequestParam(value = "userId") Integer userId,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "userName") String userName, @RequestParam(value = "phone") Integer phone,
			@RequestParam(value = "birthday") String birth, @RequestParam(value = "nationality") String nationality,
			@RequestParam(value = "gender") String gender, @RequestParam(value = "address") String address,
			@RequestParam(value = "creditCard") String creditCard, @RequestParam(value = "state") String state,
			@RequestParam(value = "profilephoto",required = false) MultipartFile photo) throws ParseException, IOException {
		System.out.println(photo);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date birthday = df.parse(birth);
		//如果照片沒動就不存照片
		if(photo == null) {
			customerService.updateInfo(userId, email,userName, phone, birthday, nationality,
					gender, address, creditCard, state);
		}else {
			customerService.updateInfo(userId, email,userName, phone, birthday, nationality,
					gender, address, creditCard, state, photo.getBytes());
		}
		String back = "redirect:myAccountPage?userId="+userId;
		return back;

	}
	
	//照片
	@GetMapping("downloadAvatar/{userId}")
	@ResponseBody
	public ResponseEntity<byte[]> downloadImage(@PathVariable("userId") Integer id){
		Customer cus = customerService.getCustomerById(id);
		
		byte[] photoFile = cus.getPhoto();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
										// 要回傳的物件, header , HttpStatus 回應
		return new ResponseEntity<byte[]>(photoFile, headers , HttpStatus.OK);
	}
	
	@GetMapping("/verify")
	public String verifyAccount(String code,Model model ,RedirectAttributes redirectAttributes) {
		boolean verified = customerService.verify(code);
		
		String pageTitle = verified ? "驗證成功" : "驗證失敗";
		model.addAttribute("pageTitle", pageTitle);
		redirectAttributes.addFlashAttribute("mailCheckMessage","驗證成功! 請登入");
		
		//未完成
		//帶值跳轉
		
		return (verified ? "redirect:customerlogin" : "verified_fail");
	}
	
	/**
	 * 寄忘記密碼確認信
	 * @param email
	 * @param redirectAttributes
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws MessagingException
	 */
	
	@PostMapping("/findPwd")
	public String sendPwdEmail(@RequestParam(value="email") String email,RedirectAttributes redirectAttributes,HttpServletRequest request) throws UnsupportedEncodingException, MessagingException {
	
		Customer tempCustomer = customerService.findCustomerByEmail(email);
		
		if(tempCustomer == null) {
			redirectAttributes.addFlashAttribute("sendMessage", "Oops! 請輸入註冊信箱");
			return "redirect:customerlogin";
		}else {
			String siteURL = Utility.getSiteURL(request);
			customerService.sendEditPwdMail(tempCustomer, siteURL);
			redirectAttributes.addFlashAttribute("mailCheckMessage", "信件已寄出，請完成信件忘記密碼步驟");
			return "redirect:customerlogin";
		}
	}
	
	/**
	 * 頁面跳轉到修改密碼
	 * @param code
	 * @param model
	 * @return
	 */
	@GetMapping("/changePwd")
	public String goEditPwd(String code,Model model) {
		Customer customer = customerService.findByVerificationCode(code);
		model.addAttribute("customerInfo", customer);
		return "confirmEditPwd";
	}
	
	/**
	 * 修改密碼後更新資料庫
	 * @param code
	 * @param password
	 * @param password2
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@PostMapping("/upadateEdit")
	public String changePassword(@RequestParam(value="code") String code,
								@RequestParam(value="password") String password,
								@RequestParam(value="password2") String password2,
								RedirectAttributes redirectAttributes,HttpServletRequest request) {
		
		customerService.updateNewPassword(password,code);
		redirectAttributes.addFlashAttribute("updateSuccee", "更新成功");
		
		request.getSession().invalidate();
		
		Cookie[] cookies = request.getCookies();
		for(Cookie c : cookies) {
			if(c.getName().equals("JSESSIONID")) {
				c.setMaxAge(0);
				break; 
			}
		}
		
		return  "redirect:customerlogin";
	}
	
	@GetMapping("/myAccountPage")
	public String goMyAccountPage(Model model,Integer userId) {
		
		Customer customer = customerService.getCustomerById(userId);
		model.addAttribute("cusInfomation",customer);
		
		return "myAccount";
	}
	
	
	/**
	 * 用於資料繫結、設定資料轉換器等，字面意思是“初始化繫結器”。
	 * @param binder
	 * @param request
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder, WebRequest request) {
		// 轉換日期 這裡轉換的格式要和傳進來的一樣 如果2015-9-9 就yyyy-MM-dd
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));// CustomDateEditor为自定义日期编辑器
	}
	
	
	
	// =============================明翰的部分(後臺管理員)=======================================
	
    //拿到所有會員資料
    @GetMapping("/customerManage")
    public ModelAndView customerList(ModelAndView mav, @RequestParam(name = "p",defaultValue = "1") Integer pageNumber,
                                     @RequestParam(name = "customerKeyword",required=false) String keyword){
        Page<Customer> customerByPage = customerService.customerList(pageNumber, keyword);
        List<Customer> list = customerByPage.getContent();
        mav.getModel().put("customerList",list);
        mav.getModel().put("page",customerByPage);
        mav.getModel().put("customerKeyword",keyword);
        mav.setViewName("customerManage");
        return mav;

    }

    //跳到更新會員頁面 改成跳到查看會員資料
    @GetMapping("/editCustomer")
    public String editCustomer(@RequestParam("userId")Integer id,Model model){
        Customer customer = customerService.getCustomerById(id);
        model.addAttribute("customerBean" ,customer);

        return "updateCustomer";
    }

    //更新會員資料 改成查看會員資料
    @GetMapping("postEditCustomer")
    public String editCustomer(@ModelAttribute("customerBean") Customer customer){


//            customerService.updateCustomer(customer);
            return "redirect:customerManage";


    }

    //刪除會員
    @GetMapping("deleteCustomer")
    public String deleteCustomer(@RequestParam("userId") Integer id){
        customerService.deleteCustomer(id);

        return "redirect:customerManage";
    }
    
  //----------------------------舜麟部分------------------------
    @GetMapping("addfavorite")
    @ResponseBody
    public boolean addfavorite(@RequestParam("hotelId") String hotelId, @RequestParam("userId") String userId) {
    	return customerService.addfavorite(hotelId,userId);
    }
    
    @GetMapping("removefavorite")
    @ResponseBody
    public boolean removefavorite(@RequestParam("hotelId") String hotelId, @RequestParam("userId") String userId) {
    	return customerService.removefavorite(hotelId,userId);
    }

    @GetMapping("removeandrefresh")
    @ResponseBody
    public List<Hotel> removeandrefresh(@RequestParam("hotelId") String hotelId, @RequestParam("userId") String userId) {
    	customerService.removefavorite(hotelId,userId);
    	List<Hotel> hotellist = customerService.myFavorite(userId);
    	return hotellist;
    }
    
    @PostMapping("findcus")
    @ResponseBody
    public Customer findcus(@RequestParam("userId") String userId) {
    	return dao.findById(Integer.parseInt(userId)).get();
    }
    
    @GetMapping("myFavorite")
    @ResponseBody
    public List<Hotel> myFavorite(@RequestParam("userId") String userId) {
    	List<Hotel> hotellist = customerService.myFavorite(userId);
    	return hotellist;
    }
}
