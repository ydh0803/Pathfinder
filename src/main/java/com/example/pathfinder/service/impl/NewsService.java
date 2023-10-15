package com.example.pathfinder.service.impl;

import com.example.pathfinder.dto.NewsDTO;
import com.example.pathfinder.service.INewsService;
import com.example.pathfinder.util.CmmUtil;
import com.example.pathfinder.util.DateUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;

@Slf4j
@RequiredArgsConstructor
@Service
public class NewsService implements INewsService {



//    private List<NewsDTO> doCollect() throws Exception {
//
//        log.info(this.getClass().getName() + ".doCollect Start!");
//
//        List<NewsDTO> pList = new LinkedList<>();
//
//        String url = "https://www.joongang.co.kr/travel/news";
//
//        Document doc = (Document) Jsoup.connect(url).get();
//
//        Elements elements = doc.select("div.photo_list_area");
//
//        for (Element headline : elements.select("div.card_body")) {
//
//            String title = CmmUtil.nvl(headline.select(h2.a).text());
//
//            log.info("tltle : " + title);
//
//            if ((title.length() > 0)) {
//
//                NewsDTO pDTO = new NewsDTO();
//                pDTO.setNewsTitle(title);
//                pDTO.setCollectTime(DateUtil.getDateTime("yyyyMMddhhmmss"));
//
//                pList.add(pDTO);
//
//            }
//
//        }
//
//        log.info(this.getClass().getName() + "doCollect End");
//
//        return pList;
//    }
//
//    @Override
//    public int collectNews() throws Exception {
//
//        int res = 0;
//
//        String colNm = "News_" + DateUtil.getDateTime("yyyyMMdd");
//
//        List<NewsDTO> rList = this.doCollect();
//
//        res = newsMapper.insertNews(rList, colNm);
//
//    }

}
