package com.example.pathfinder.service.impl;

import com.example.pathfinder.Mapper.IUserMapper;
import com.example.pathfinder.dto.NoticeDTO;
import com.example.pathfinder.dto.UserDTO;
import com.example.pathfinder.service.IUserService;
import com.example.pathfinder.util.CmmUtil;
import lombok.RequiredArgsConstructor;
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
        String userId = CmmUtil.nvl(pDTO.getUserId());
        log.info(userId);


        UserDTO rDTO = userMapper.idCheck(pDTO);
        if (rDTO == null) {
            res = 0;
        } else {
            String userId2 = CmmUtil.nvl(rDTO.getUserId());
            log.info(userId2);
            if (userId.equals(userId2)) {
                res = 1;
            } else {
                res = 0;
            }
        }
        return res;
    }


        @Override
    public int nameCheck(UserDTO pDTO) {
        log.info(this.getClass().getName() + ".nameCheck start");

        int res = 0;
        String userName = CmmUtil.nvl(pDTO.getUserName());
        log.info(userName);

        UserDTO rDTO = userMapper.nameCheck(pDTO);

            if (rDTO == null) {
                res = 0;
            } else {
                String userName2 = CmmUtil.nvl(rDTO.getUserName());
                log.info(userName2);
                if (userName.equals(userName2)) {
                    res = 1;
                } else {
                    res = 0;
                }
            }
            return res;
    }

    @Override
    public int mailCheck(UserDTO pDTO) {
        int res = 0;
        String userMailid = CmmUtil.nvl(pDTO.getUserMailid());
        String userMaildomain = CmmUtil.nvl(pDTO.getUserMaildomain());
        log.info(userMailid+"@"+userMaildomain);

        String Mail = userMailid + "@" + userMaildomain;
        log.info(Mail);

        UserDTO rDTO = userMapper.mailCheck(pDTO);
        log.info("ggg" + rDTO);

        if (rDTO == null) {
            res = 0;
        } else {
            String userMailid2 = CmmUtil.nvl(rDTO.getUserMailid());
            String userMaildomain2 = CmmUtil.nvl(rDTO.getUserMaildomain());
            String Mail2 = userMailid2 + "@" + userMaildomain2;
            log.info(Mail2);
            if (Mail.equals(Mail2)) {
                res = 1;
            } else {
                res = 0;
            }
        }
        return res;
    }

    @Override
    public List<NoticeDTO> getNoticeList() {
        return userMapper.getNoticeList();
    }

    @Override
    public int pwCheck(UserDTO pDTO) {
        log.info(this.getClass().getName()+".pwCheck start");
        return userMapper.pwCheck(pDTO);


    }

    @Override
    public int chgPw(UserDTO pDTO) throws Exception {
        userMapper.chgPw(pDTO);
        return 0;
    }

    @Override
    public int chgName(UserDTO pDTO) throws Exception {
        userMapper.chgName(pDTO);
        return 0;
    }


}