package com.example.pathfinder.service;

import com.example.pathfinder.dto.UserDTO;

import java.util.List;
import java.util.Map;

public interface ILoginService {

    UserDTO login(Map<String, String > map) throws Exception;

    UserDTO findByemail(UserDTO pDTO);

    int findIdCheck(UserDTO pDTO)throws Exception;

    int findPwCheck(UserDTO pDTO)throws Exception;

    void resetPw(UserDTO pDTO) throws Exception;

    void deleteUser(UserDTO pDTO) throws Exception;


}