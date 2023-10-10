package com.example.pathfinder.controller;

import com.example.pathfinder.dto.*;
import com.example.pathfinder.service.IUserService;
import com.example.pathfinder.service.impl.UserService;
import com.example.pathfinder.util.CmmUtil;
import com.example.pathfinder.util.UseSha256;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserController {


    @Autowired
    UserService userService;

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
        return "/signUp/MsgToMain";
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
        log.info("ggg" + res);
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

    @GetMapping("/calendar")
    public String Calendar(HttpSession session, Model model) throws Exception {
        log.info(this.getClass().getName() + ".calendar start");
        UserDTO uDTO = (UserDTO) session.getAttribute("user");

        return "/signUp/calendar";
    }

    @ResponseBody
    @GetMapping(value = "/signUp/getUserCalendar")
    public List<Map<String, Object>> userCalendar(CalendarDTO pDTO) throws Exception{
        log.info(String.valueOf(pDTO.getUserNo()));
        List<CalendarDTO> rList = userService.getCalendarList(pDTO);
        JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();

        HashMap<String, Object> hash = new HashMap<>();

        for (int i = 0; i < rList.size(); i++) {
            hash.put("title", rList.get(i).getTitle());
            hash.put("start", rList.get(i).getStartdate());
            hash.put("end",rList.get(i).getEnddate());
            hash.put("time",  rList.get(i).getEnddate());
            hash.put("calNo", rList.get(i).getCalNo());
            jsonObj = new JSONObject(hash);
            jsonArr.add(jsonObj);
        }
        log.info("jsonArrCheck: {}", jsonArr);
        return jsonArr;

    }

    @ResponseBody
    @PostMapping(value = "/signUp/insertCalendar")
    public String insertCalendar(@RequestBody List<Map<String, Object>> param) throws Exception {
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);

        for (Map<String, Object> list : param) {
            String eventName = (String) list.get("title"); // 이름 받아오기
            log.info(eventName);
            String startDateString = (String) list.get("start");
            log.info(startDateString);
            String endDateString = (String) list.get("end");
            log.info(endDateString);
            LocalDateTime startDate = LocalDateTime.parse(startDateString, dateTimeFormatter);
            LocalDateTime endDate = LocalDateTime.parse(endDateString, dateTimeFormatter);
            int userNo = (Integer) list.get("userNo");
            System.out.println("userNo : " + userNo);
            //시작시간, 종료시간을 한국 시간으로 변환
            System.out.println("=================================");
            System.out.println("startDate = " + String.valueOf(startDate));
            System.out.println("eventName = " + eventName);
            CalendarDTO pDTO = new CalendarDTO();
            pDTO.setTitle(eventName);
            pDTO.setStartdate(String.valueOf(startDate));
            pDTO.setEnddate(String.valueOf(endDate));
            pDTO.setUserNo(userNo);
            userService.insertCalendar(pDTO);

        }
        return "/signUp/getUserCalendar";
    }

    @ResponseBody
    @DeleteMapping(value = "/signUp/deleteCalendar")
    public String deleteCalendar(@RequestBody List<Map<String, Object>> param) throws Exception{

        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);

        for (Map<String, Object> list : param) {

            String title = (String) list.get("title"); // 이름 받아오기
            String startDateString = (String) list.get("start");
            String endDateString = (String) list.get("end");
            int userNo = (Integer) list.get("userNo");
            System.out.println("startDateString = " + startDateString);
            LocalDateTime startDate = LocalDateTime.parse(startDateString, dateTimeFormatter);
            LocalDateTime endDate = LocalDateTime.parse(endDateString, dateTimeFormatter);

            System.out.println("startDate = " + startDate);

            CalendarDTO pDTO = new CalendarDTO();
            pDTO.setUserNo(userNo);
            pDTO.setStartdate(String.valueOf(startDate));
            pDTO.setEnddate(String.valueOf(endDate));
            pDTO.setTitle(title);
            userService.deleteCalendar(pDTO);

        }

        return "/signUp/getUserbCalendar";
    }


    @ResponseBody
    @RequestMapping("/user/bookmark")
    public String Bookmark(@RequestParam String url, String title, int userNo, Model model) throws Exception {
        log.info(this.getClass().getName() + ".bookmark start");

        log.info(url);
        log.info(title);
        log.info("q" + userNo);

        String link = url;

        BookmarkDTO bDTO = new BookmarkDTO();
        bDTO.setTitle(title);
        bDTO.setLink(link);
        bDTO.setUserNo(userNo);
        userService.addBookmark(bDTO);
        String msg = "북마크가 등록되었습니다..";
        model.addAttribute("msg", msg);

        return url;
    }

    @GetMapping("/bookmark")
    public String BookmarkList(HttpSession session, Model model) throws Exception {
        log.info(this.getClass().getName() + ".bookmarkList start");

        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        int userNo = uDTO.getUserNo();
        log.info(String.valueOf(userNo));

        BookmarkDTO bDTO = new BookmarkDTO();
        bDTO.setUserNo(userNo);

        List<BookmarkDTO> bList = userService.getBookmark(bDTO);
        model.addAttribute("bList", bList);

        for (BookmarkDTO bookmark : bList) {
            log.info(bookmark.getTitle() + bookmark.getLink());
        }

        return "/signUp/bookmark";
    }

    @GetMapping("/getBookmarkList")
    public String getBookmarkList(HttpServletRequest request, Model model, Criteria cri) throws Exception {
        int pNo = 1;
//        int userNo = Integer.parseInt(request.getParameter("userNo"));
        int userNo = 1;
        log.info("q"+userNo);
        BookmarkDTO pDTO = new BookmarkDTO();
        pDTO.setUserNo(userNo);

        if (request.getParameter("pNo") != null) {
            pNo = Integer.valueOf(request.getParameter("pNo"));

            log.info("cri : " + cri);


            model.addAttribute("list", userService.getListPagingByCourse(pNo, pDTO));
            model.addAttribute("userNo",userNo);

            int total = userService.totalCountByCourse(pDTO);
            cri.setPageNum(pNo);
            PageMakeDTO pageMake = new PageMakeDTO(cri, total);

            model.addAttribute("pageMaker", pageMake);

            String res = pDTO.getTitle();
            log.info(res);

            return res;
        }

        log.info("cri : " + cri);

        model.addAttribute("list", userService.getListPagingByCourse(pNo, pDTO));

        int total = userService.totalCountByCourse(pDTO);

        PageMakeDTO pageMake = new PageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);
        model.addAttribute("userNo",userNo);

        String res = pDTO.getTitle();
        log.info(res);
        return res;

    }

//    @GetMapping("/bookmarkList")
//    public String BookmarkList(HttpSession session, Model model, HttpServletRequest request) throws Exception {
//        log.info(this.getClass().getName() + ".Bookmark start");
//        UserDTO uDTO = (UserDTO) session.getAttribute("user");
//
//        int tNo = 1;
//        if (request.getParameter("tNo") != null) {
//            log.info("메인");
//            tNo = Integer.parseInt(request.getParameter("tNo"));
//            List<NoticeDTO> nList = userService.getNoticePaging(tNo);
//            model.addAttribute("rList", nList);
//            int result = userService.userTotalCount(nCri);
//            PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
//            model.addAttribute("noticePageMake", noticePageMake);
//        }
//        model.addAttribute("rList", userService.getNoticePaging(tNo));
//        int result = userService.noticeTotalCount(nCri);
//        PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
//        model.addAttribute("noticePageMake", noticePageMake);
//
//
//        return "/signUp/bookmark";
//    }

}