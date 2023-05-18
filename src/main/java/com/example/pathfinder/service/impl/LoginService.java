package com.example.pathfinder.service.impl;

import com.example.pathfinder.Mapper.ILoginMapper;
import com.example.pathfinder.dto.UserDTO;
import com.example.pathfinder.service.ILoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.Map;

@Slf4j
@Service
@Repository
public class LoginService implements ILoginService {
   /* @Autowired
    private MailService mailService;*/

    @Autowired
    private ILoginMapper userMapper;

    @Override
    public UserDTO login(Map<String, String> map) throws Exception {
        log.info(this.getClass().getName() + ".login start");
        log.info(String.valueOf(map));

        return userMapper.login(map);
    }

    @Override
    public UserDTO findByemail(UserDTO pDTO) {
        log.info(this.getClass().getName() + ".findByemail 시작");
        return userMapper.findId(pDTO);
    }

    @Override
    public int findIdCheck(UserDTO pDTO) throws Exception {
        return userMapper.findIdCheck(pDTO);
    }

    @Override
    public int findPwCheck(UserDTO pDTO) throws Exception {
        return userMapper.findPwCheck(pDTO);
    }

    @Override
    public void resetPw(UserDTO pDTO) throws Exception {

    }

    /*@Override
    public void resetPw(UserDTO pDTO) throws Exception {
        String user_mailid = pDTO.getUser_mailid();
        String user_maildomain = pDTO.getUser_maildomain();
        String userEmail = user_mailid + "@" + user_maildomain;
        String userPw = mailService.sendPassword(userEmail);
        pDTO.setUser_pw(userPw);
        userMapper.resetPw(pDTO);

    }*/

    @Override
    public void deleteUser(UserDTO pDTO) throws Exception {

        userMapper.deleteUser(pDTO);

    }
}