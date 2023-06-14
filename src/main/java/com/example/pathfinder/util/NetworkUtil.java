package com.example.pathfinder.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.Nullable;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

@Slf4j
public class NetworkUtil {

    public static String get(String apiUrl){

        log.info(apiUrl);
        return get(apiUrl, null);
    }

    public static String get(String apiUrl, @Nullable Map<String , String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);

        try {
            con.setRequestMethod("GET");

            if (requestHeaders != null) {
                for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
                    con.setRequestProperty(header.getKey(), header.getValue());
                }
            }
            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return readBody(con.getInputStream());
            }else {
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        }finally {
            con.disconnect();
        }

    }
    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);

            return (HttpURLConnection) url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : "+ apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패하였습니다. : " + apiUrl, e);
        }
    }
    private static String readBody(InputStream body) {
        InputStreamReader streamReader = new InputStreamReader(body);
        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        }catch (IOException e){
            throw new RuntimeException("API 응답을 읽는데 실패했습니다", e);
        }
    }

    public static String post(String apiUrl, @Nullable Map<String , String> requestHeaders, String postParams) {
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("POST");


            log.info(requestHeaders.get("X-Naver-Client-Id"));
            log.info(requestHeaders.get("X-Naver-Client-Secret"));

            for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            con.setDoOutput(true);
            try(DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.write(postParams.getBytes());
                wr.flush();
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return readBody(con.getInputStream());
            } else {
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


}