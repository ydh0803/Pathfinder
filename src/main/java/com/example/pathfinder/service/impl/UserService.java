package com.example.pathfinder.service.impl;

import com.example.pathfinder.Mapper.IUserMapper;
import com.example.pathfinder.dto.NoticeDTO;
import com.example.pathfinder.dto.UserDTO;
import com.example.pathfinder.service.IUserService;
import com.example.pathfinder.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class UserService implements IUserService {

    @Autowired
    private final IUserMapper userMapper;



    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date time = new Date();
    String localTime = format.format(time);

    @Autowired
    public UserService(IUserMapper userMapper) {

        this.userMapper = userMapper;
    }

    @Transactional
    @Override
    public void InsertUserInfo(UserDTO userdto) throws Exception {
        log.info(this.getClass().getName() + "start!");

        userMapper.saveUser(userdto);

        log.info(this.getClass().getName() + "end!");
    }

    @Override
    public int idCheck(UserDTO pDTO) {
        log.info(this.getClass().getName() + ".idCheck start");

        int res = 0;
        String user_id = CmmUtil.nvl(pDTO.getUser_id());
        log.info(user_id);

        UserDTO rDTO = userMapper.idCheck(pDTO);



        if (rDTO == null) {
            rDTO = new UserDTO();
        }

        if (CmmUtil.nvl(rDTO.getUses_exists()).equals("Y")){
            res = 1;
        }else{
            res = 0;

        }
        log.info(this.getClass().getName() + ".idCheck end");
        return res;
    }

    @Override
    public int nameCheck(UserDTO pDTO) {
        log.info(this.getClass().getName() + ".nameCheck start");

        int res = 0;
        String user_name = CmmUtil.nvl(pDTO.getUser_name());
        log.info(user_name);

        UserDTO rDTO = userMapper.nameCheck(pDTO);

        if (rDTO == null) {
            rDTO = new UserDTO();
        }

        if (CmmUtil.nvl(rDTO.getUses_exists()).equals("Y")){
            res = 1;
        }else{
            res = 0;

        }

        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".idCheck end");
        return res;
    }

    @Override
    public int mailCheck(UserDTO pDTO) {
        int res = 0;
        String user_mailid = CmmUtil.nvl(pDTO.getUser_mailid());
        String user_maildomain = CmmUtil.nvl(pDTO.getUser_maildomain());
        log.info(user_mailid+"@"+user_maildomain);

        UserDTO rDTO = userMapper.mailCheck(pDTO);

        if (rDTO == null) {
            rDTO = new UserDTO();
        }

        if (CmmUtil.nvl(rDTO.getUses_exists()).equals("Y")) {
            res = 1;
        } else {
            res = 0;

        }

        log.info(String.valueOf(res));
        log.info(this.getClass().getName() + ".mailCheck end");
        return res;
    }

    @Override
    public List<NoticeDTO> getNoticeList() {
        return userMapper.getNoticeList();
    }


}