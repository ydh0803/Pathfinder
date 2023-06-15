package com.example.pathfinder.controller;

import com.example.pathfinder.dto.*;
import com.example.pathfinder.service.IAdminService;
import com.example.pathfinder.service.impl.BoardService;
import com.example.pathfinder.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Slf4j
@Controller
public class AdminController {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private BoardService boardService;

    @GetMapping("/adminPage")
    public String adminPage(HttpServletRequest request,Model model,Criteria nCri, Criteria uCri) throws Exception {
        int uNo = 1;
        int tNo = 1;
        if (request.getParameter("uNo") != null) {
            log.info("열로 들어왔지롱");
            uNo = Integer.parseInt(request.getParameter("uNo"));
            List<UserDTO> uList = adminService.getUserPaging(uNo);
            model.addAttribute("uList", uList);
            int res = adminService.userTotalCount(uCri);
            PageMakeDTO userPageMake = new PageMakeDTO(uCri, res);
            model.addAttribute("userPageMake", userPageMake);
        }
        model.addAttribute("uList", adminService.getUserPaging(uNo));
        int res = adminService.userTotalCount(uCri);
        PageMakeDTO userPageMake = new PageMakeDTO(uCri, res);
        model.addAttribute("userPageMake", userPageMake);

        if (request.getParameter("tNo") != null) {
            log.info("열로 들어왔지롱");
            tNo = Integer.parseInt(request.getParameter("tNo"));
            List<NoticeDTO> nList = adminService.getNoticePaging(tNo);
            model.addAttribute("nList", nList);
            int result = adminService.userTotalCount(nCri);
            PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
            model.addAttribute("noticePageMake", noticePageMake);
        }
        model.addAttribute("nList", adminService.getNoticePaging(tNo));
        int result = adminService.noticeTotalCount(nCri);
        PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
        model.addAttribute("noticePageMake", noticePageMake);
        return "/admin/ddd";
    }

    @GetMapping(value = "/NoticeDetail")
    public String noticeDetail(HttpServletRequest request, Model model){
        int bNo = Integer.parseInt(request.getParameter("bNo"));
        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setNoticeNo(bNo);
        NoticeDTO rDTO = adminService.noticeDetail(pDTO);
        model.addAttribute("rDTO", rDTO);
        return "/NoticeDetail";
    }


    @GetMapping(value = "/noticeDelete")
    public String noticeDelete(HttpServletRequest request, Model model){
        int notice_no = Integer.parseInt(request.getParameter("nSeq"));
        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setNoticeNo(notice_no);
        adminService.deleteNotice(pDTO);
        model.addAttribute("msg","공지가 삭제되었습니다.");
        return "/club/MsgToClose";
    }

    @GetMapping(value = "/admin/noticeInsertForm")
    public String noticeInsertForm(){
        return "/admin/NoticeWrite";
    }

    @PostMapping(value="/noticeReg")
    public String noticeReg(HttpServletRequest request, Model model){
        String title = request.getParameter("title");
        String contents = request.getParameter("contents");
        String adminName = request.getParameter("adminName");
        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setAdminname(adminName);
        pDTO.setContents(contents);
        pDTO.setTitle(title);
        adminService.insertNotice(pDTO);
        model.addAttribute("msg","공지작성이 완료되었습니다.");
        return "/admin/MsgToAdmin";
    }

    @GetMapping(value = "/userDetail")
    public String userInfo(HttpServletRequest request, Model model, Criteria cri) throws Exception {
        log.info(this.getClass().getName()+".userInfo start!");
        int userNo = Integer.parseInt(request.getParameter("bNo"));
        UserDTO pDTO = new UserDTO();
        pDTO.setUserNo(userNo);
        UserDTO rDTO = adminService.getUserInfo(pDTO);
        List<BoardDTO> rList = adminService.getUserBoard(pDTO);
        model.addAttribute("rDTO",rDTO);
        model.addAttribute("rList", rList);

        return "admin/userInfo";
    }

    @GetMapping(value = "/adminDeleteUser")
    public String deleteUser(HttpSession session, HttpServletRequest request, Model model) throws Exception {
        log.info(this.getClass().getName()+".adminDeleteUser start!");
        int userNo = Integer.parseInt(CmmUtil.nvl(request.getParameter("bNo")));
        UserDTO pDTO = new UserDTO();
        pDTO.setUserNo(userNo);

        adminService.deleteUser(pDTO);

        model.addAttribute("msg", "회원삭제가 완료되었습니다");
        log.info(this.getClass().getName()+".adminDeleteUser end!");

        return "/admin/MsgToAdmin";
    }

    @GetMapping(value = "/userBoardDetail")
    public String userBoardDetail(HttpServletRequest request, Model model) throws Exception {
        log.info(request.getParameter("bNo"));
        int userNo = Integer.valueOf(CmmUtil.nvl(request.getParameter("bNo")));
        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoardNo(userNo);
        BoardDTO rDTO = adminService.userBoardDetail(pDTO);
        CommentDTO cDTO = new CommentDTO();
        cDTO.setBoardNo(userNo);
        List<CommentDTO> rList = boardService.getComment(cDTO);

        model.addAttribute("rDTO", rDTO);
        model.addAttribute("rList",rList);

        return "/admin/userBoardDetail";
    }

    @GetMapping(value = "/userBoardDelete")
    public String userBoardDelete(HttpServletRequest request, Model model)throws Exception{
        log.info(CmmUtil.nvl(request.getParameter("bNo")));
        int boardNo = Integer.valueOf(CmmUtil.nvl(request.getParameter("bNo")));
        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoardNo(boardNo);
        adminService.boardDelete(pDTO);

        model.addAttribute("msg","글이 삭제되었습니다.");

        return "/admin/MsgToAdmin";
    }
}
