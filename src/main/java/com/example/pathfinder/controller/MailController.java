package com.example.pathfinder.controller;

import com.example.pathfinder.dto.UserDTO;
import com.example.pathfinder.service.impl.LoginService;
import com.example.pathfinder.service.impl.MailService;
import com.example.pathfinder.util.CmmUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Slf4j
@AllArgsConstructor
public class MailController {

    private MailService mailService;

    @Autowired
    private LoginService loginService;

    //이메일 인증번호 발송
    @ResponseBody
    @PostMapping(value = "/mailSend")
    private int sendEmail(HttpServletRequest request){
        String userEmail = CmmUtil.nvl(request.getParameter("userEmail"));
        int res = 0;
        log.info(this.getClass().getName() + ".sendEmail start");

        HttpSession session = request.getSession();

        mailService.sendEmail(session, userEmail);
        log.info(this.getClass().getName() + ".sendEmail end");
        res = 1;
        return res;

    }

    //이메일 인증번호 진위여부 확인
    @ResponseBody
    @PostMapping(value = "/mailReg")
    private boolean emailCertification(HttpServletRequest request, String userEmail,String inputCode){
        System.out.println(inputCode);
        log.info(this.getClass().getName() + ".emailCertification start");
        HttpSession session = request.getSession();
        boolean result = mailService.emailCertification(session, userEmail, Integer.parseInt(inputCode));
        log.info(this.getClass().getName() + ".emailCertification end");
        log.info(String.valueOf(result));
        return result;

    }

    @ResponseBody
    @GetMapping(value = "/sendPw")
    private void sendPassword(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".sendEmail start");
        String userId = CmmUtil.nvl(request.getParameter("userId"));
        String userMailid = CmmUtil.nvl(request.getParameter("userMailid"));
        String userMaildomain = CmmUtil.nvl(request.getParameter("userMaildomain"));
        String userEmail = userMailid+"@"+userMaildomain;
        log.info(userEmail);
        log.info(userId);
        UserDTO pDTO = new UserDTO();
        pDTO.setUserMailid(userMailid);
        pDTO.setUserMaildomain(userMaildomain);
        pDTO.setUserId(userId);

        loginService.resetPw(pDTO);


    }
}