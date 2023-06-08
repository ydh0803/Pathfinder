package com.example.pathfinder.Mapper;

import com.example.pathfinder.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface ILoginMapper {

    UserDTO login(Map<String, String> map);

    UserDTO findId(UserDTO pDTO);

    int findIdCheck(UserDTO pDTO)throws Exception;

    int findPwCheck(UserDTO pDTO)throws Exception;

    int deleteUser(UserDTO pDTO) throws Exception;
}