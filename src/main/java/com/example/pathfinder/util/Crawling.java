package com.example.pathfinder.util;
import com.example.pathfinder.dto.NewsDTO;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Crawling {

    public static Object main() {
        final String URL = "https://www.joongang.co.kr/travel/domestic";
        Connection conn = Jsoup.connect(URL);

        List<NewsDTO> nList = new ArrayList<>();


        int i = 0;

        try {
            Document document = conn.get();
            Elements linkElements = document.select(".card.col_sm6.col_lg4 .card_image a");

            for (Element linkElement : linkElements) {
                String headline = linkElement.select("img").attr("alt");
                String image = linkElement.select("img").attr("src");
                String link = linkElement.attr("href");


//                System.out.println("제목: " + headline);
//                System.out.println("사진: " + image);
//                System.out.println("주소: " + link);

                NewsDTO nDTO = new NewsDTO();

                nDTO.setHeadline(headline);
                nDTO.setImage(image);
                nDTO.setLink(link);

                i += 1;
                nDTO.setNewsNo(i);

                Connection innerConn = Jsoup.connect(link);
                Document innerDocument = innerConn.get();

//                Elements text = innerDocument.select(".article_body.fs3");

//                String caption = text.attr("p");
//
//                System.out.println("내용: " + caption);

                Elements paragraphs = innerDocument.select(".article_body.fs3 p:not(.caption)");
                StringBuilder content = new StringBuilder();

                for (Element paragraph : paragraphs) {
                    content.append(paragraph.text()).append("\n");

                }

                String text = content.toString().trim();
//                System.out.println(text);

                nDTO.setText(text);

                nList.add(nDTO);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return nList;
    }

}
