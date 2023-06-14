package com.example.pathfinder.controller;

import com.example.pathfinder.dto.Criteria;
import com.example.pathfinder.dto.NoticeDTO;
import com.example.pathfinder.dto.PageMakeDTO;
import com.example.pathfinder.service.impl.AdminService;
import com.example.pathfinder.service.impl.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;


@Slf4j
@Controller
@RequiredArgsConstructor
public class mainController {


    @Autowired
    UserService userService;
    @Autowired
    AdminService adminService;

    @RequestMapping("/")
    public String main(HttpServletRequest request, Model model, Criteria nCri) throws Exception {
        int tNo = 1;
        log.info("왔나?");
        if (request.getParameter("tNo") != null) {
            log.info("메인");
            tNo = Integer.parseInt(request.getParameter("tNo"));
            List<NoticeDTO> nList = adminService.getNoticePaging(tNo);
            model.addAttribute("rList", nList);
            log.info("ggg" + model);
            int result = adminService.userTotalCount(nCri);
            PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
            model.addAttribute("noticePageMake", noticePageMake);
        }
        model.addAttribute("rList", adminService.getNoticePaging(tNo));
        int result = adminService.noticeTotalCount(nCri);
        PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
        model.addAttribute("noticePageMake", noticePageMake);
        return "index";
    }
    @RequestMapping("/index")
    public String index(HttpServletRequest request, Model model, Criteria nCri) throws Exception {
        int tNo = 1;
        if (request.getParameter("tNo") != null) {
            log.info("메인");
            tNo = Integer.parseInt(request.getParameter("tNo"));
            List<NoticeDTO> nList = adminService.getNoticePaging(tNo);
            model.addAttribute("rList", nList);
            int result = adminService.userTotalCount(nCri);
            PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
            model.addAttribute("noticePageMake", noticePageMake);
        }
        model.addAttribute("rList", adminService.getNoticePaging(tNo));
        int result = adminService.noticeTotalCount(nCri);
        PageMakeDTO noticePageMake = new PageMakeDTO(nCri, result);
        model.addAttribute("noticePageMake", noticePageMake);
        return "/index";
    }
}

