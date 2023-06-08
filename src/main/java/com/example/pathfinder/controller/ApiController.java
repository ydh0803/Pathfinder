package com.example.pathfinder.controller;

import com.example.pathfinder.dto.*;
import com.example.pathfinder.util.*;
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
    public String SearchDetail(HttpServletRequest request, Model model) throws IOException, ParseException {
        log.info(this.getClass().getName() + ".SearchDetail start");
        String contentid = CmmUtil.nvl(request.getParameter("contentid"));
        String title = CmmUtil.nvl(request.getParameter("title"));
        String tel = CmmUtil.nvl(request.getParameter("tel"));
        String firstimage = CmmUtil.nvl(request.getParameter("firstimage"));
        String addr1 = CmmUtil.nvl(request.getParameter("addr1"));
        String addr2 = String.valueOf(ApiSearchDetail.main("addr2"));
        String api = String.valueOf(ApiSearchDetail.main(contentid));
        log.info(contentid);
        log.info(title);

        JSONParser jsonParser = new JSONParser();
        JSONObject obj = (JSONObject) jsonParser.parse(api);
        JSONObject response = (JSONObject) obj.get("response");
        JSONObject body = (JSONObject) response.get("body");
        JSONObject items = (JSONObject) body.get("items");
        JSONArray item = (JSONArray) items.get("item");
        log.info(String.valueOf(item));

        DetailDTO rDTO = null;
        JSONObject array = null;
        for (Object arr : item) {
            array = (JSONObject) arr;
            rDTO = new DetailDTO();
            // rDTO를 사용하는 코드
        }
        rDTO.setChkpet((String) array.get("chkpet"));
        rDTO.setChkcreditcard((String) array.get("chkcreditcard"));
        rDTO.setAccomcount((String) array.get("accomcount"));
        rDTO.setChkbabycarriage((String) array.get("chkbabycarriage"));
        rDTO.setParking((String) array.get("parking"));
        rDTO.setInfocenter((String) array.get("infocenter"));
        rDTO.setUsetime((String) array.get("usetime"));
        rDTO.setExpagerange((String) array.get("expagerange"));
        rDTO.setExpguide((String) array.get("expguide"));
        rDTO.setOpendate((String) array.get("opendate"));
        rDTO.setRestdate((String) array.get("restdate"));
        rDTO.setHeritage1((String) array.get("heritage1"));
        rDTO.setHeritage2((String) array.get("heritage2"));
        rDTO.setHeritage3((String) array.get("heritage3"));
        rDTO.setTitle(title);
        rDTO.setTel(tel);
        rDTO.setFirstimage(firstimage);
        rDTO.setAddr1(addr1);
        rDTO.setAddr2(addr2);


        model.addAttribute("Detail", rDTO);


        log.info("dddd");
        return "/tour/SearchDetail";
    }



//        String conentid = CmmUtil.nvl(request.getParameter("contentid"));
//        log.info(conentid);
//        DetailDTO pDTO = new DetailDTO();
//        pDTO.setContentid(conentid);
//        String conenttypeid = CmmUtil.nvl(request.getParameter("contentTypeId"));
//        log.info(conenttypeid);
//        pDTO.setContenttypeid(conenttypeid);
//
//        DetailDTO rDTO = DetailService.getDetail(contentid);
//
//        model.addAttribute("rDTO", rDTO);
//        model.addAttribute("rList", rList);
//        return "/tour/SearchDetail";
//    }

    @GetMapping("/gps")
    public String gps(){
        return "/tour/gps";
    }

    @GetMapping("/tour/gpsScan")
    @ResponseBody
    public List<ScanDTO> gpsScan(HttpServletRequest request, Model model) throws IOException, ParseException {

            log.info(this.getClass().getName() + ".gpsScanning start");

        String mapX = CmmUtil.nvl(request.getParameter("mapX"));
        String mapY = CmmUtil.nvl(request.getParameter("mapY"));
        String ContentTypeId = CmmUtil.nvl(request.getParameter("ContentTypeId"));

        log.info(mapX);
        log.info(mapY);
        log.info(ContentTypeId);

        String api = String.valueOf(ApiScan.main(mapX, mapY, ContentTypeId));

        JSONParser jsonParser = new JSONParser();
        JSONObject obj = (JSONObject) jsonParser.parse(api);
        JSONObject response = (JSONObject) obj.get("response");
        JSONObject body = (JSONObject) response.get("body");
        JSONObject items = (JSONObject) body.get("items");
        JSONArray item = (JSONArray) items.get("item");
        log.info(String.valueOf(item));

        List<ScanDTO> list = new ArrayList<>();
        for(Object arr : item){
            JSONObject array = (JSONObject) arr;
            ScanDTO sDTO = new ScanDTO();
            sDTO.setAreacode((String) array.get("areacode"));
            sDTO.setContentid((String) array.get("contentid"));
            sDTO.setTitle((String) array.get("title"));
            sDTO.setContenttypeid((String) array.get("contenttypeid"));
            sDTO.setFirstimage2((String) array.get("firstimage2"));
            sDTO.setFirstimage((String) array.get("firstimage"));
            sDTO.setSigungucode((String) array.get("sigungucode"));
            sDTO.setTel((String) array.get("tel"));
            sDTO.setAddr1((String) array.get("addr1"));
            sDTO.setAddr2((String) array.get("addr2"));
            sDTO.setDist((String) array.get("dist"));
            sDTO.setMapx((String) array.get("mapx"));
            sDTO.setMapy((String) array.get("mapy"));

            list.add(sDTO);

        }

        log.info(list.toString());


            return list;
        }
    }


