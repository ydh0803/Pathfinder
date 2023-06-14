package com.example.pathfinder.util;

import lombok.extern.slf4j.Slf4j;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;

@Slf4j
public class ApiFesta {
    public static StringBuilder main(String areaCode) throws IOException {
        String Today = com.example.pathfinder.util.Today.today();
        StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/B551011/KorService1/searchFestival1"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=I%2FxoZkq49gH4V%2FtiPHP7zSEY%2B45KWXDDYkv%2B6uVYUE%2B5vDiH2y46yBbVo94ZcANN9aKxvYFmzkbPnwet5SdQBw%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("EventStartDate","UTF-8") + "=" + Today); /*축제시작일*/
        urlBuilder.append("&" + URLEncoder.encode("AreaCode","UTF-8") + "=" + areaCode); /*지역코드*/
        urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("and", "UTF-8")); /*OS*/
        urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("pathfinder", "UTF-8")); /*이름(XML/JSON) Default: XML*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*검색 결과 수*/


        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        return sb;
    }

}

