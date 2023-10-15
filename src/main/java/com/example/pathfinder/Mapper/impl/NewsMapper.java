package com.example.pathfinder.Mapper.impl;

import com.example.pathfinder.Mapper.INewsMapper;
import com.example.pathfinder.dto.NewsDTO;
import com.example.pathfinder.util.AbstractMongoDBComon;
import com.mongodb.client.MongoCollection;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class NewsMapper extends AbstractMongoDBComon implements INewsMapper {

//    private final MongoTemplate mongodb;
//
//    @Override
//    public int insertNews(List<NewsDTO> pList, String colNm) throws Exception {
//
//        log.info(this.getClass().getName() + "insertNews Start");
//
//        int res = 0;
//
//        if (pList == null) {
//            pList = new LinkedList<>();
//        }
//
//        super.createCollection(mongodb, colNm, "collectTime");
//
//        MongoCollection<Document> col = mongodb.getCollection(colNm);
//
//
//
//    }

}
