package com.example.pathfinder.controller;

import com.example.pathfinder.dto.NoticeDTO;
import com.example.pathfinder.dto.UserDTO;
import com.example.pathfinder.service.IUserService;
import com.example.pathfinder.service.impl.UserService;
import com.example.pathfinder.util.CmmUtil;
import com.example.pathfinder.util.UseSha256;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserController {


    @Autowired
    UserService userService;

    //메인화면
   /* @GetMapping("/main")
    public String MainPage(HttpServletRequest request, Model model, Criteria nCri) throws Exception {
        int tNo = 1;
        if (request.getParameter("tNo") != null) {
            log.info("열로 들어왔지롱");
            tNo = Integer.parseInt(request.getParameter("tNo"));
            List<NoticeDTO> nList = adminService.getNoticePaging(tNo);
            model.addAttribute("rList", nList);
            int result = adminService.userTotalCount(nCri);
            PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
            model.addAttribute("noticePageMake", noticePageMake);
        }
        model.addAttribute("rList", adminService.getNoticePaging(tNo));
        int result = adminService.noticeTotalCount(nCri);
        List<BikeRentalDTO> rList = weatherService.getBikeRental();
        PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
        model.addAttribute("noticePageMake", noticePageMake);
        return "/main";
    }*/

    //회원가입
    @GetMapping("/signUp")
    public String signUpForm() {
        log.info(this.getClass().getName() + ".SignUpForm start");
        return "signUp/sign";
    }

    @GetMapping("/myPage")
    public String Mypage(HttpSession session, Model model) throws Exception {
        log.info(this.getClass().getName() + ".SignUpForm start");
        UserDTO uDTO = (UserDTO) session.getAttribute("user");

        return "/signUp/myPage";
    }


    @PostMapping("/signUpReg")
    public String signUp(HttpServletRequest request, Model model) {

        log.info(this.getClass().getName() + ".SingUpReg start");

        String msg = "";

        try {

            String userId = CmmUtil.nvl(request.getParameter("userId"));
            String userPwd = CmmUtil.nvl(request.getParameter("userPw"));
            String userName = CmmUtil.nvl(request.getParameter("userName"));
            String userMailid = CmmUtil.nvl(request.getParameter("userMailid"));
            String userMaildomain = CmmUtil.nvl(request.getParameter("userMaildomain"));
            String certificationYN = CmmUtil.nvl(request.getParameter("certificationYN"));

            String userPw = UseSha256.encrypt(userPwd);

            log.info("userId : " + userId);
            log.info("userPw : " + userPw);
            log.info("userName : " + userName);
            log.info(userMailid + "@" + userMaildomain);
            log.info(certificationYN);

            UserDTO pDTO = new UserDTO();

            pDTO.setUserId(userId);
            pDTO.setUserPw(userPw);
            pDTO.setUserName(userName);
            pDTO.setUserMailid(userMailid);
            pDTO.setUserMaildomain(userMaildomain);
            pDTO.setAuth("user");

            userService.InsertUserInfo(pDTO);


            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".signUpReg end!");


        }
        model.addAttribute("msg","회원가입이 완료되었습니다.");
        return "/index";
    }
    //아이디 중복체크
    @ResponseBody
    @PostMapping(value = "/idCheck")
    public int idCheck(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".idCheck start!");
        String msg = "";


        String userId = CmmUtil.nvl(request.getParameter("userId"));

        log.info("userId : " + userId);

        UserDTO pDTO = new UserDTO();

        pDTO.setUserId(userId);

        int result = userService.idCheck(pDTO);

        return result;
    }

    //닉네임 중복체크
    @ResponseBody
    @RequestMapping(value = "/nameCheck", method = RequestMethod.POST)
    public int nameCheck(UserDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".nameCheck start!");
        int res = userService.nameCheck(pDTO);
        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".nameCheck end!");
        return res;
    }

    //메일 중복체크
    @ResponseBody
    @RequestMapping(value = "/mailCheck", method = RequestMethod.POST)
    public int mailCheck(UserDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".mailCheck start!");
        int res = userService.mailCheck(pDTO);
        log.info(this.getClass().getName() + ".mailCheck end!");
        return res;
    }



    @PostMapping(value= "/user/pwCheck")
    public String pwCheck(HttpServletRequest request, Model model) {
        String userPw = UseSha256.encrypt(request.getParameter("userPw"));
        log.info(userPw);
        int userNo = Integer.parseInt(request.getParameter("userNo"));
        log.info(String.valueOf(userNo));
        UserDTO pDTO = new UserDTO();
        pDTO.setUserPw(userPw);
        pDTO.setUserNo(userNo);
        int result = userService.pwCheck(pDTO);

        if (result == 1) {
            return "/signUp/chgPW";
        }else {
            String msg = "비밀번호가 틀렸습니다";
            model.addAttribute("msg", msg);
            return "/signUp/MsgToMain";
        }

    }

    @GetMapping(value = "/user/chgName")
    public String chgNameForm() {
        return "/signUp/chgName";
    }

    @PostMapping(value = "/user/chgName")
    public String chgName(HttpServletRequest request, Model model, HttpSession session) throws Exception {
        String userName = request.getParameter("userName");
        int userNo = Integer.valueOf(request.getParameter("userNo"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUserName(userName);
        pDTO.setUserNo(userNo);
        userService.chgName(pDTO);
        session.invalidate();
        model.addAttribute("msg","닉네임이 변경되었습니다. 다시 로그인 해주시기 바랍니다.");

        return "/signUp/popupclose";

    }

    @PostMapping(value = "/user/chgPw")
    public String chgPw(HttpServletRequest request, Model model, HttpSession session) throws Exception {
        String pw = UseSha256.encrypt(request.getParameter("pw"));
        int userNo = Integer.parseInt(request.getParameter("userNo"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUserPw(pw);
        pDTO.setUserNo(userNo);
        int res =  userService.chgPw(pDTO);
        session.invalidate();
        String msg = "비밀번호가 변경되었습니다. 다시 로그인 해주세요";
        model.addAttribute("msg",msg);
        return "/signUp/popupclose";

    }



}