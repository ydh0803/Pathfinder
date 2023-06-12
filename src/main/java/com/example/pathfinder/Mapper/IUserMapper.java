package com.example.pathfinder.Mapper;

import com.example.pathfinder.dto.NoticeDTO;
import com.example.pathfinder.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IUserMapper {
    void saveUser(UserDTO userdto) throws Exception;

    UserDTO idCheck(UserDTO pDTO);

    UserDTO nameCheck(UserDTO pDTO);

    UserDTO mailCheck(UserDTO pDTO);

    List<NoticeDTO> getNoticeList();

    //회원 비밀번호 체크
    int pwCheck(UserDTO pDTO);

    //회원 비밀번호 변경
    void chgPw(UserDTO pDTO) throws Exception;

    //회원 비밀번호 변경
    void chgName(UserDTO pDTO) throws Exception;

}