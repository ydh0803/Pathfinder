package com.example.pathfinder.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class UserDTO {
    private int userNo;
    private String userId;
    private String userPw;
    private String userName;
    private String userMailid;
    private String userMaildomain;
    private String usesExists;
    private String auth;

}
