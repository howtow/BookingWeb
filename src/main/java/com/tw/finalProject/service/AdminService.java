package com.tw.finalProject.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tw.finalProject.model.Admin;
import com.tw.finalProject.model.AdminRepository;

//=============================================明翰部分
@Service
@Transactional
public class AdminService {

    @Autowired
    private AdminRepository adminDao;

    public Admin login(String adminEmail,String password){
        Admin tempMember = adminDao.findByAdminEmailAndPassword(adminEmail,password);

        if(tempMember!=null){
            return tempMember;
        }else {
            return null;
        }
    }
}

