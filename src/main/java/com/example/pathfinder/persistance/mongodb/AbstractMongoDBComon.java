package com.example.pathfinder.persistance.mongodb;

import com.mongodb.client.model.Indexes;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.mongodb.core.MongoTemplate;

@Slf4j
@RequiredArgsConstructor
public abstract class AbstractMongoDBComon {
    protected boolean createCollection(MongoTemplate mongodb, String colNm) {

        boolean res;

        if (mongodb.collectionExists(colNm)) {
            res = false;

        } else {
            mongodb.createCollection(colNm);
            res = true;
        }

        return res;
    }

    protected boolean createCollection(MongoTemplate mongodb, String colNm, String[] index) {

        log.info(this.getClass().getName() + ".createCollection Start!");

        boolean res = false;

        if (mongodb.collectionExists(colNm)) {

            if (index.length > 0) {

                mongodb.createCollection(colNm).createIndex(Indexes.ascending(index));

            } else {

                mongodb.createCollection(colNm);

            }

            res = true;
        }

        log.info(this.getClass().getName() + "createCollection End!");
        return res;
    }

    protected boolean createCollection(MongoTemplate mongodb, String colNm, String index) {

        String[] indexArr = {index};

        return createCollection(mongodb, colNm, indexArr);
    }

    protected boolean dropCollection(MongoTemplate mongodb, String colNm) {
        boolean res = false;

        if (mongodb.collectionExists(colNm)) {
            mongodb.dropCollection(colNm);
            res = true;
        }

        return res;
    }

}