//package com.example.pathfinder.service.impl;
//
//import com.example.pathfinder.dto.DetailDTO;
//import com.example.pathfinder.service.IDetailService;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.stereotype.Service;
//
//import javax.annotation.Resource;
//import java.util.LinkedList;
//import java.util.List;
//
//@Slf4j
//@Service
//public class DetailService implements IDetailService {
//    @Resource(name = "DetailMapper")
//    private IDetailMapper courseMapper;
//
//    @Override
//    public List<DetailDTO> getDetail() throws Exception {
//        log.info(this.getClass().getName() + ".getCourse Start!");
//
//        String colNm = "BikeCourse";
//
//        List<DetailDTO> rList = new LinkedList<>();
//
//        log.info("mongodb data");
//        rList = DetailMapper.getDetail(colNm);
//
//
//        if (rList == null) {
//            rList = new LinkedList<>();
//        }
//        log.info(this.getClass().getName() + ".getCourse End!");
//
//        return rList;
//    }
//}
