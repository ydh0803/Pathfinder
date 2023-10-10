package com.example.pathfinder.service;

import com.example.pathfinder.dto.BookmarkDTO;
import com.example.pathfinder.dto.NoticeDTO;
import com.example.pathfinder.dto.UserDTO;

import java.util.List;

public interface IUserService {

    //회원가입
    void InsertUserInfo(UserDTO pDTO) throws Exception;

    //아이디 중복체크
    int idCheck(UserDTO pDTO);

    //닉네임 중복체크
    int nameCheck(UserDTO pDTO);

    //메일 중복체크
    int mailCheck(UserDTO pDTO);

    List<NoticeDTO> getNoticeList();

    //회원 비밀번호 체크
    int pwCheck(UserDTO pDTO);

    //회원 비밀번호 변경
    int chgPw(UserDTO pDTO) throws Exception;

    //회원 비밀번호 변경
    int chgName(UserDTO pDTO) throws Exception;



}
