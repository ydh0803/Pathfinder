package com.example.pathfinder.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDTO {
    private int noticeNo;
    private String title;
    private String contents;
    private String regdate;
    private String adminname;
}