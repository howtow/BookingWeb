package com.tw.finalProject.model;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRespository extends JpaRepository<Customer, Integer> {
	
	@Query("SELECT cus FROM Customer cus WHERE cus.email = ?1 and cus.password = ?2")
	Customer findByEmailAndPassword(String email , String password);
	
	@Query("SELECT cus FROM Customer cus WHERE cus.email = ?1")
	Customer findByEmail(String email);
	
	@Query("SELECT cus FROM Customer cus WHERE cus.password = ?1")
	Customer findByPassword(String password);
	
	@Query("SELECT cus FROM Customer cus WHERE cus.userId = ?1")
	Customer findByUserId(Integer id);
	
	@Query("UPDATE Customer cus "
			+ "SET "
			+ "cus.email=?2,"
			
			+ "cus.userName=?3,"
			+ "cus.phone=?4,"
			+ "cus.birthday=?5,"
			+ "cus.nationality=?6,"
			+ "cus.gender=?7,"
			+ "cus.address=?8,"
			+ "cus.creditCard=?9,"
			+ "cus.state=?10,"
			+ "cus.photo=?11 " 
			+ "WHERE cus.userId =?1 ")
	@Transactional
	@Modifying
	void updateCustomerById(@Param("userId") Integer userId,
							@Param("email") String email,
							@Param("userName") String userName,
							@Param("phone") Integer phone,
							@Param("birthday") Date birthday,
							@Param("nationality") String nationality,
							@Param("gender") String gender,
							@Param("address") String address,
							@Param("creditCard") String creditCard, 
							@Param("state") String state,
							@Param("photo")byte[] photo
							);

	@Query("UPDATE Customer cus "
			+ "SET "
			+ "cus.email=?2,"
			+ "cus.userName=?3,"
			+ "cus.phone=?4,"
			+ "cus.birthday=?5,"
			+ "cus.nationality=?6,"
			+ "cus.gender=?7,"
			+ "cus.address=?8,"
			+ "cus.creditCard=?9,"
			+ "cus.state=?10 "
			+ "WHERE cus.userId =?1 ")
	@Transactional
	@Modifying
	void updateCustomerById2(@Param("userId") Integer userId,
							@Param("email") String email,
							@Param("userName") String userName,
							@Param("phone") Integer phone,
							@Param("birthday") Date birthday,
							@Param("nationality") String nationality,
							@Param("gender") String gender,
							@Param("address") String address,
							@Param("creditCard") String creditCard, 
							@Param("state") String state
							
							);
	
	@Query("UPDATE Customer cus "
			+ "SET "
			+ "cus.password=?2,"
			+ "cus.salt=?3 " 
			+ "WHERE cus.verificationCode =?1 ")
	@Transactional
	@Modifying
	void updateCustomerByVerificationCode(
							@Param("verificationCode") String code,
							@Param("password") String password,
							@Param("salt")Integer salt
							);
	
	@Query("UPDATE Customer cus "
			+ "SET "
			+ "cus.password=?2,"
			+ "cus.salt=?3 " 
			+ "WHERE cus.userId =?1 ")
	@Transactional
	@Modifying
	void updatePwdByUserId(
			@Param("userId") Integer userId,
			@Param("password") String password,
			@Param("salt")Integer salt
			);
	
	
	@Query("UPDATE Customer cus SET cus.enabled  = true WHERE cus.userId = ?1")
	@Modifying
	@Transactional
	public void enable(Integer id);
	
	@Query("SELECT cus FROM Customer cus Where cus.verificationCode = ?1")
	public Customer findByVerificationCode(String code);
	
	//=============================================明翰部分
	
    @Query("from Customer where userId= :userId")
    Customer findCustomerByUserId(@Param("userId") Integer userId);


    void deleteByUserId(Integer userId);

    @Query("select c from Customer c where " +
            "concat(c.email, c.userName, c.nationality, c.gender, c.address, c.state) " +
            "like %?1%")
    Page<Customer> customerList(String keyword, Pageable pageable);

    //會員數
    @Query(value = "select count(*) from dbo.Customer",nativeQuery = true)
    Integer customerSum();
	
}
