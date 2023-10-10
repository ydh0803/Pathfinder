package com.example.pathfinder.service.impl;

import com.example.pathfinder.Mapper.IUserMapper;
import com.example.pathfinder.dto.*;
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
        log.info("mail1 " + Mail);

        UserDTO rDTO = userMapper.mailCheck(pDTO);
        log.info("rDTO mail " + rDTO);

        if (rDTO == null) {
            res = 0;
        } else {
            String userMailid2 = CmmUtil.nvl(rDTO.getUserMailid());
            String userMaildomain2 = CmmUtil.nvl(rDTO.getUserMaildomain());
            String Mail2 = userMailid2 + "@" + userMaildomain2;
            log.info("mail2 " + Mail2);
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

    public List<CalendarDTO> getCalendarList(CalendarDTO pDTO) throws Exception{
        return userMapper.getCalendarList(pDTO);
    }

    public void insertCalendar(CalendarDTO pDTO) throws Exception{
        userMapper.insertCalendar(pDTO);
    }

    public void deleteCalendar(CalendarDTO pDTO) throws Exception{
        userMapper.deleteCalendar(pDTO);
    }

    public void addBookmark(BookmarkDTO bDTO){
        log.info(this.getClass().getName() + ".upload start");
        log.info(String.valueOf(bDTO));
        log.info(this.getClass().getName() + ".upload end");
        userMapper.addBookmark(bDTO);

    }

    public List<BookmarkDTO> getBookmark(BookmarkDTO bDTO) throws Exception{
        log.info(this.getClass().getName() + ".select start");
        log.info(String.valueOf(bDTO));
        return userMapper.getBookmark(bDTO);

    }

//    public List<BookmarkDTO> getBookmark(BookmarkDTO bDTO) {
//
//        return userMapper.getBookmark(bDTO);
//    }

    public List<BookmarkDTO> getListPagingByCourse(int pNo, BookmarkDTO pDTO) {
        HashMap<String, Object> hMap = new HashMap();
        Criteria cri = new Criteria();
        cri.setPageNum(pNo);
        hMap.put("skip", cri.getSkip());
        hMap.put("amount", cri.getAmount());
        hMap.put("userNo", pDTO.getUserNo());

        return userMapper.getListPagingByCourse(hMap);
    }

    public int totalCountByCourse(BookmarkDTO pDTO) throws Exception {

        return userMapper.totalCountByCourse(pDTO);
    }


}