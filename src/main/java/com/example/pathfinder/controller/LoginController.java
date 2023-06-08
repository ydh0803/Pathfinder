package com.example.pathfinder.controller;

import com.example.pathfinder.dto.UserDTO;
import com.example.pathfinder.service.impl.LoginService;
import com.example.pathfinder.util.CmmUtil;
import com.example.pathfinder.util.UseSha256;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Slf4j
@Controller
public class LoginController {

    @Autowired
    LoginService loginService;

    //로그인
    @GetMapping("LoginPage")
    public String LoginPage(){

        return "signUp/login";
    }

    @PostMapping("login")
    public String login(@RequestParam Map<String, String> map, HttpServletRequest request, Model model, HttpSession session) {
        log.info(this.getClass().getName() + ".login start!");
        String userId = CmmUtil.nvl(request.getParameter("userid"));
        log.info(userId);


        String userpwd = UseSha256.encrypt(map.get("userpwd"));
        log.info(userpwd);
        map.put("userid", userId);
        map.put("userpwd", userpwd);
        try {
            if (map.get("userid") == null || map.get("userpwd") == null) {
                log.info("로그인 에러1");
                model.addAttribute("msg", "아이디 또는 비밀번호를 입력해주세요");
                return "/signUp/MsgToMain";
            }
            UserDTO rDTO = loginService.login(map);
            log.info("gggg :"+ rDTO);
            if (rDTO != null) {
                log.info(rDTO.getAuth());
                session.setAttribute("user", rDTO);
                log.info("로그인 세션생성 완료");
                log.info(this.getClass().getName() + ".login end");
                model.addAttribute("msg", rDTO.getUserName()+"님 환영합니다.");
                return "/signUp/MsgToMain";

            } else {
                log.info("로그인 에러2");
                model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                return "/signUp/MsgToMain";
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.info("로그인 에러3");
            model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
            return "/signUp/MsgToMain";
        }
    } // end of PostMapping("login")


    @RequestMapping(value = "/logOut", method = RequestMethod.GET)
    public String logOutPost( HttpSession session, Model model){
        log.info("입장");
        session.invalidate();
        log.info("로그아웃 완료");
        model.addAttribute("msg","로그아웃 되었습니다.");
        return "/signUp/MsgToMain";
    }

    @GetMapping(value = "/findIdPw")
    public String findIdPw() {
        log.info(this.getClass().getName()+ ".findIdPw 시작");

        return "/signUp/find";
    }

   @ResponseBody
    @PostMapping(value = "/findId")
    public List<Map<String, Object>> findId(@RequestBody List<Map<String, Object>> params) throws Exception {
        log.info(this.getClass().getName()+".findID 시작");
        JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();
        HashMap<String, Object> hash = new HashMap<>();
        for (Map<String, Object> list : params) {
            String userMailid = (String) list.get("userMailid");
            log.info(userMailid);
            String userMaildomain = (String) list.get("userMaildomain");
            log.info(userMaildomain);
            UserDTO pDTO = new UserDTO();
            pDTO.setUserMailid(userMailid);
            pDTO.setUserMaildomain(userMaildomain);
            UserDTO rDTO = loginService.findByemail(pDTO);
            String userId = rDTO.getUserId();
            log.info(userId);
            hash.put("userId",userId);
            jsonObj = new JSONObject(hash);
            jsonArr.add(jsonObj);
        }
        log.info("jsonArrCheck: {}", jsonArr);
        return jsonArr;
    }

    @GetMapping(value = "/findPw")
    public String findPwView() throws Exception{

        return "/signUp/findPw";
    }

    @GetMapping(value = "/pwCheck")
    public String pwCheck() {

        return "/signUp/pwCheck";
    }

   @GetMapping(value = "/deleteUser")
    public String deleteUser(HttpSession session, HttpServletRequest request, Model model) throws Exception {
        log.info(this.getClass().getName()+".deleteUser start!");
        int userNo = Integer.parseInt(CmmUtil.nvl(request.getParameter("userNo")));
        log.info(String.valueOf(userNo));
        UserDTO pDTO = new UserDTO();
        pDTO.setUserNo(userNo);

        loginService.deleteUser(pDTO);
        session.invalidate();

        model.addAttribute("msg", "회원탈퇴가 완료되었습니다");
        log.info(this.getClass().getName()+".deleteUser end!");

        return "/signUp/MsgToMain";
    }
}