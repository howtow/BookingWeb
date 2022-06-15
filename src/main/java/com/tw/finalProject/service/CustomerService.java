package com.tw.finalProject.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ThreadLocalRandom;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.tw.finalProject.model.Customer;
import com.tw.finalProject.model.CustomerRespository;
import com.tw.finalProject.model.Hotel;
import com.tw.finalProject.model.HotelRepository;

import net.bytebuddy.utility.RandomString;

@Service
public class CustomerService {

	@Autowired // 依賴注入
	private CustomerRespository cusDao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private HotelRepository hotelDao;
	
	/**
	 * 	密碼、Email、姓名 格式的正規表示式
	 */
	private final Pattern emailRegex = Pattern.compile("^[_a-z0-9-]+([.][_a-z0-9-]+)*@[a-z0-9-]+([.][a-z0-9-]+)*$");

	private final Pattern passwdRegex = Pattern.compile("^\\w{8,16}$");

	private final Pattern userNameRegex = Pattern.compile("^\\w{1,16}$");

	
	public Customer findCustomerByEmail(String email) {
		Customer customer = cusDao.findByEmail(email);
		return customer;
	}
	
	
	/**
	 * 檢查輸入值是否為符合格式的有效Email
	 * @param email 
	 * @return boolean
	 */
	private boolean validateEmail(String email) {
		return email != null && emailRegex.matcher(email).find();
	}
	
	/**
	 * 檢查輸入值是否為符合格式的有效密碼
	 * @param password
	 * @param password2
	 * @return boolean
	 */
	private boolean validatePasswd(String password, String password2) {
		return password != null && passwdRegex.matcher(password).find() && password.equals(password2); 
	}
	
	/**
	 * 檢查輸入值是否為符合有效姓名
	 * 判斷是否為空值
	 * 判斷是否符合格式
	 * @param userName
	 * @return boolean
	 */
	private boolean validateUserName(String userName) {
		return userName != null && userNameRegex.matcher(userName).find();
	}
	
	/**
	 * 確認申請表單Email是否有已經有人申請
	 * @param email
	 * @return boolean
	 */
	public boolean checkDuplicateEmail(String email) {
		if(cusDao.findByEmail(email)!=null) {
			return false;
		}
		return true;
	} 
	
	
	

	
	public boolean findByUserIdAndPwd(Integer userId , String password) {
		Customer result = cusDao.findByUserId(userId);
		 Integer salt = result.getSalt();
		 String pwd = result.getPassword();
		 System.out.println(salt);
		 String inputpwd =String.valueOf(password.hashCode()+salt);
		 System.out.println(inputpwd);
		 
		 
		 if(inputpwd.equals(pwd)) {
			 return true;
		 }else {		 
			 return false;
		 }
		 
	}
	
	/**
	 * 確認輸入值是否符合格式
	 * 如果不符，將它的錯誤訊息存進ArrayList型態的變數signUpErrors
	 * 目前的錯誤訊息有三:
	 * 郵件、密碼、姓名
	 * @param email
	 * @param password
	 * @param password2
	 * @param userName
	 * @return signUpErrors
	 */
	public ArrayList<String> checksignUp(String email, String password, String password2, String userName) {
		
		ArrayList<String> signUpErrors = new ArrayList<String>();
		
		if(!checkDuplicateEmail(email)) {
			signUpErrors.add("Oops!該郵件已被使用，請重新註冊!");
		}
		
		if (!validateEmail(email)) {
			signUpErrors.add("未填寫郵件或格式不正確");
		}
		if (!validatePasswd(password, password2)) {
			signUpErrors.add("請確認密碼符合格式並再度確認密碼");
		}
		if (!validateUserName(userName)) {
			signUpErrors.add("未填寫郵件或格式不正確");
		}
		if (signUpErrors.isEmpty()) {
			return null;
		}else {
			return signUpErrors;			
		}
	}
	
	
	//包含照片的update
	public  void updateInfo(Integer userId, String email, String userName,Integer phone,
			 Date birthday, String nationality, String gender, String address,
			 String creditCard, String state ,byte[] photo) {
		
		
		cusDao.updateCustomerById(userId, email, userName, phone, birthday, nationality, gender, address,
				creditCard, state, photo);
	}
	
	//不含照片的update
	public  void  updateInfo(Integer userId, String email,String userName,Integer phone,
			Date birthday, String nationality, String gender, String address,
			String creditCard, String state) {
		
		cusDao.updateCustomerById2(userId, email, userName, phone, birthday, nationality, gender, address,
				creditCard, state);
	}
	
	/**
	 * 密碼加密，將資寮存取成Persistence狀態
	 * @param email
	 * @param password
	 * @param userName
	 * @param phone
	 * @param birthday
	 * @param nationality
	 * @param gender
	 * @param address
	 * @param creditCard
	 * @param state
	 * @return
	 */
	public Customer encryptAndSave(String email,String password,String userName, Integer phone, Date birthday,String nationality,String gender,String address,String creditCard,String state) {
		
		int salt = ThreadLocalRandom.current().nextInt(); //產生int隨機數
		String encrypt = String.valueOf(salt + password.hashCode());
		String randomCode = RandomString.make(64);
		Customer customer = new Customer();
		
		customer.setSalt(salt);
		customer.setEmail(email);
		customer.setPassword(encrypt);
		customer.setUserName(userName);
		customer.setPhone(phone);
		customer.setBirthday(birthday);
		customer.setNationality(nationality);
		customer.setGender(gender);
		customer.setAddress(address);
		customer.setCreditCard(creditCard); 
		customer.setState(state);
		customer.setEnabled(false);
		customer.setVerificationCode(randomCode);
	
		cusDao.save(customer);
		
		return customer;
	}
	
	
	
	public Customer findByVerificationCode(String code) {
		Customer customer = cusDao.findByVerificationCode(code);
		return customer;
	}
	
	
	public void updateNewPassword(String password,String code){
	
		
		int salt = ThreadLocalRandom.current().nextInt(); //產生int隨機數
		String encrypt = String.valueOf(salt + password.hashCode());
	
		cusDao.updateCustomerByVerificationCode(code, encrypt, salt);
		
	}
	
	/**
	 * 依照userId 更新密碼
	 * @param password
	 * @param userId
	 */
	public void updateNewPassword(String password, Integer userId){
		
		int salt = ThreadLocalRandom.current().nextInt(); //產生int隨機數
		String encrypt = String.valueOf(salt + password.hashCode());
		
		cusDao.updatePwdByUserId(userId,encrypt,salt);
		
	}
	
	
	/**
	 * 先由Email判斷使用者是否存在，
	 * 不存在return null
	 * 存在則
	 * 判斷明瑪與資料庫加密密瑪是否一致
	 * 捼一致則return使用者資料
	 * @param loginEmail
	 * @param loginPwd
	 * @return
	 */
	public Customer isCorrectPassword(String loginEmail,String loginPwd) {
		
		Customer checkExist= cusDao.findByEmail(loginEmail);
		
		if(checkExist == null) {
			
			return null;
			
		}else {
			Integer salt = checkExist.getSalt();
			int encrypt = Integer.parseInt(checkExist.getPassword());
			
			String inputPwd =String.valueOf(loginPwd.hashCode()+salt);
			Customer result = cusDao.findByEmailAndPassword(loginEmail, inputPwd);
	
			return result;
		}	
	}
	
	/**
	 * Check 認證信件狀態
	 * @param verificationCode
	 * @return boolean
	 */
	 public boolean verify(String verificationCode) {
		  Customer customer = cusDao.findByVerificationCode(verificationCode);
		  
		  if (customer == null || customer.isEnabled()) {
		  	return false;
	  	}else {
	  		cusDao.enable(customer.getUserId());
	  		return true;
	  	}
		
	  }
	 
	 /**
	  * 季驗證信
	  * 信箱格式、內容、URL
	  * @param tempCustomer
	  * @param siteURL
	  * @throws UnsupportedEncodingException
	  * @throws MessagingException
	  */
	 public void sendVerificationEmail(Customer tempCustomer, String siteURL) throws UnsupportedEncodingException, MessagingException {
			System.out.println(tempCustomer);
			String subject="Formosa 確認您的會員驗證";
			String senderName="Formosa Team";
			String mailContent = "<p>Dear " + tempCustomer.getUserName() + ",</p>";
			mailContent += "<p>請點擊下方按鈕完成驗證: </p>";
			
			String verifyURL = siteURL + "/verify?code=" + tempCustomer.getVerificationCode();
			
			mailContent += "<h3><a href =" + verifyURL + ">VERIFY</a></h3>";		
			mailContent += "<p>Thank you <br> The Formosa Team</p>";
			
			MimeMessage message= mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message);
			
			helper.setFrom("formosateameeit@gmail.com",senderName);
			helper.setTo(tempCustomer.getEmail());
			helper.setSubject(subject);
			helper.setText(mailContent, true);
			
			mailSender.send(message);
						
		}
	 
	 public void sendEditPwdMail(Customer customer, String siteURL) throws UnsupportedEncodingException, MessagingException {
		 
		 	String subject="Formosa 修改您的會員資訊";
			String senderName="Formosa Team";
			String mailContent = "<p>Dear " + customer.getUserName() + ",</p>";
			mailContent += "<p>請點擊下方連結修改您的密碼: </p>";
			
			String editPwdURL = siteURL + "/changePwd?code=" + customer.getVerificationCode();
			
			mailContent += "<h3><a href =" + editPwdURL + ">修改密碼</a></h3>";		
			mailContent += "<p>Thank you <br> The Formosa Team</p>";
			
			MimeMessage message= mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message);
			
			helper.setFrom("formosateameeit@gmail.com",senderName);
			helper.setTo(customer.getEmail());
			helper.setSubject(subject);
			helper.setText(mailContent, true);
			
			mailSender.send(message);
		 
	 }
	 
	 
//=============================================明翰部分
//   找到會員資料
   public Page<Customer> customerList(Integer pageNumber,String keyword) {
       Pageable pageable = PageRequest.of(pageNumber - 1, 10, Sort.Direction.ASC, "userId");
       if (keyword!=null){
           return cusDao.customerList(keyword,pageable);
       }

       return cusDao.findAll(pageable);
   }


   //    更新會員
   public void updateCustomer(Customer customer) {

       cusDao.save(customer);
   }

   public Customer getCustomerById(Integer id) {
       Customer customer = cusDao.findCustomerByUserId(id);
       return customer;
   }

   public void deleteCustomer(Integer id) {

       cusDao.deleteByUserId(id);
   }

   // 會員數
   public Integer customerSum(){
       return cusDao.customerSum();
   }
	
  //=============================================舜麟部分
//新增收藏
  public boolean addfavorite(String hotelId, String userId) {
	  Customer cus = cusDao.findById(Integer.parseInt(userId)).get();
	  String fa = cus.getFavorite();
	  if(fa==null || fa.equals("")) {
		  cus.setFavorite(hotelId);
		  cusDao.save(cus);
	  }else {
		  cus.setFavorite(cus.getFavorite() + "," + hotelId);
		  cusDao.save(cus);
	  }
	  return true;
  }

  //刪除收藏
  public boolean removefavorite(String hotelId, String userId) {
	  Customer cus = cusDao.findById(Integer.parseInt(userId)).get();
	  String fa = cus.getFavorite();
	  String[] arr = fa.split(",");
	  System.out.println(hotelId);
	  System.out.println(userId);
	  if(fa == null || fa.equals("")) {
		  return false;
	  }else {
		  String newfa = "";
		  for(String s : arr) {
			  if(!s.equals(hotelId)) {
				  newfa += (s+",");
			  }
		  }
		  
		  if(newfa.length()!=0) {			  
			  newfa = newfa.substring(0, newfa.length()-1);
		  }else {
			  newfa = null;
		  }
		  cus.setFavorite(newfa);
		  cusDao.save(cus);
		  return true;
	  }
  }
  
  //找收藏的飯店
  public List<Hotel> myFavorite(String userId){
	  Customer cus = cusDao.findById(Integer.parseInt(userId)).get();
	  ArrayList<Hotel> hotellist = new ArrayList<Hotel>();
	  if(cus.getFavorite()!=null) {
		  String[] faArr = cus.getFavorite().split(",");
		  for(String s : faArr) {
			  if((!s.equals("")) || (!s.equals(" ")) || s!=null) {
				  Hotel hotel = hotelDao.findById(Integer.parseInt(s)).get();
				  hotellist.add(hotel);
			  }
		  }		  
	  }
	  return hotellist;
  }
}
