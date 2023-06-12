package com.example.pathfinder.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentDTO {
    private int commentNo;
    private String commentText;
    private String regdate;
    private int userNo;
    private int boardNo;
    private String userName;
    private int repCnt;
}