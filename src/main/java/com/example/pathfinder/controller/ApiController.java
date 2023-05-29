package com.example.pathfinder.controller;

import com.example.pathfinder.dto.ApiDTO;
import com.example.pathfinder.dto.FestaDTO;
import com.example.pathfinder.dto.SearchDTO;
import com.example.pathfinder.util.ApiFesta;
import com.example.pathfinder.util.ApiParse;
import com.example.pathfinder.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.parser.JSONParser;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
public class ApiController {

    @GetMapping("keywordSearch")
    public String Keyword(HttpServletRequest request, Model model) throws IOException, ParseException {

        log.info(this.getClass().getName() + ".keywordSearch start");

        String Keyword = CmmUtil.nvl(request.getParameter("AR"));
        String aaa = URLEncoder.encode(Keyword, "UTF-8");
        log.info("keyword : " + aaa);

        String api = String.valueOf(ApiParse.main(aaa));

        JSONParser jsonParser = new JSONParser();
        JSONObject obj = (JSONObject) jsonParser.parse(api);
        JSONObject response = (JSONObject) obj.get("response");
        JSONObject body = (JSONObject) response.get("body");
        JSONObject items = (JSONObject) body.get("items");
        JSONArray item = (JSONArray) items.get("item");
        log.info(String.valueOf(item));

        List<ApiDTO> list = new ArrayList<ApiDTO>();
        for(Object arr : item){
            JSONObject array = (JSONObject) arr;
            ApiDTO rDTO = new ApiDTO();
            rDTO.setAreacode((String) array.get("areacode"));
            rDTO.setContentid((String) array.get("contentid"));
            rDTO.setTitle((String) array.get("title"));
            rDTO.setContenttypeid((String) array.get("contenttypeid"));
            rDTO.setFirstimage2((String) array.get("firstimage2"));
            rDTO.setFirstimage((String) array.get("firstimage"));
            rDTO.setSigungucode((String) array.get("sigungucode"));
            rDTO.setTel((String) array.get("tel"));
            rDTO.setAddr1((String) array.get("addr1"));
            rDTO.setAddr2((String) array.get("addr2"));

            list.add(rDTO);

        }

        log.info(list.toString());
        model.addAttribute("list", list);


        return "/tour/Search";
    }

    @GetMapping("/map")
    public String signUpForm() {
        log.info(this.getClass().getName() + ".kakao map start");
        return "tour/map";
    }

    @GetMapping("/tour/Festa")
    @ResponseBody
    public List<FestaDTO> festa(HttpServletRequest request, Model model) throws IOException, ParseException {

        log.info(this.getClass().getName() + ".festamap start");
        String areaCode = CmmUtil.nvl(request.getParameter("area"));
        String api = String.valueOf(ApiFesta.main(areaCode));
        log.info(areaCode);

        JSONParser jsonParser = new JSONParser();
        JSONObject obj = (JSONObject) jsonParser.parse(api);
        JSONObject response = (JSONObject) obj.get("response");
        JSONObject body = (JSONObject) response.get("body");
        JSONObject items = (JSONObject) body.get("items");
        JSONArray item = (JSONArray) items.get("item");
        log.info(String.valueOf(item));

        List<FestaDTO> list = new ArrayList<>();
        for(Object arr : item){
            JSONObject array = (JSONObject) arr;
            FestaDTO rDTO = new FestaDTO();
            rDTO.setAreacode((String) array.get("areacode"));
            rDTO.setContentid((String) array.get("contentid"));
            rDTO.setTitle((String) array.get("title"));
            rDTO.setContenttypeid((String) array.get("contenttypeid"));
            rDTO.setFirstimage2((String) array.get("firstimage2"));
            rDTO.setFirstimage((String) array.get("firstimage"));
            rDTO.setSigungucode((String) array.get("sigungucode"));
            rDTO.setTel((String) array.get("tel"));
            rDTO.setAddr1((String) array.get("addr1"));
            rDTO.setAddr2((String) array.get("addr2"));
            rDTO.setEventenddate((String) array.get("eventstartdate"));
            rDTO.setEventstartdate((String) array.get("eventenddate"));
            rDTO.setMapx((String) array.get("mapx"));
            rDTO.setMapy((String) array.get("mapy"));

            list.add(rDTO);

        }
        log.info("dddd");
        return list;
    }
    @GetMapping("/fiesta")
    public String fiesta() {

        return "tour/Festa";
    }

    @PostMapping("/area")
    public String signUp(HttpServletRequest request, Model model) {

        log.info(this.getClass().getName() + ".AreaCode Select start");

        String ac = "";

        try {

            String areaCode = CmmUtil.nvl(request.getParameter("areaCode"));
        } catch (Exception e) {
            throw new RuntimeException(e);
        } return "/tour/Festa";
    }

    @GetMapping(value = "/tour/SearchDetail")
    public String SearchDetail(HttpServletRequest request, HttpSession session, Model model) throws Exception {
        String contentid = CmmUtil.nvl(request.getParameter("contentid"));
        log.info(contentid);
        ApiDTO pDTO = new ApiDTO();
        pDTO.setContentid(contentid);
        String contenttypeid = CmmUtil.nvl(request.getParameter("contenttypeid"));
        pDTO.setContenttypeid(contenttypeid);
        SearchDTO iDTO = new SearchDTO();
//        iDTO.setContentid(contentid);
//                ApiDTO rDTO = courseService.getCourseByName(contentid);
//        SearchDTO mDTO = imageService.getImg(iDTO);
//        List<SearchDTO> rList = bikeService.selectReview(iDTO);
//
//        model.addAttribute("rDTO", rDTO);
//        model.addAttribute("iDTO",mDTO);
//        model.addAttribute("rList", rList);
        return "/tour/SearchDetail";
    }
}

