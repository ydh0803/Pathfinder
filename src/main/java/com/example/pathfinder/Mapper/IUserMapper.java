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
}