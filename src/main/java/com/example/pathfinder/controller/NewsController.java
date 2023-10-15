package com.example.pathfinder.controller;

import com.example.pathfinder.dto.ApiDTO;
import com.example.pathfinder.dto.NewsDTO;
import com.example.pathfinder.service.impl.NewsService;
import com.example.pathfinder.util.ApiParse;
import com.example.pathfinder.util.CmmUtil;
import com.example.pathfinder.util.Crawling;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class NewsController {

    @GetMapping("/tour/news")
    public String newsCrawling(HttpServletRequest request, Model model) throws IOException, ParseException {

        log.info(this.getClass().getName() + ".newsCrawling start");

        List<NewsDTO> nList = (List<NewsDTO>) Crawling.main(); // 뉴스 정보를 가져옴
        model.addAttribute("nList", nList); // 모델에 뉴스 정보를 추가

//        log.info(nList.toString());

        return "/tour/news";
    }
}
