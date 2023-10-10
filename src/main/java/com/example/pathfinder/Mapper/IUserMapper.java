package com.example.pathfinder.Mapper;

import com.example.pathfinder.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
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

    //개인 일정 호출
    List<CalendarDTO> getCalendarList(CalendarDTO pDTO) throws Exception;

    //개인 일정 추가
    int insertCalendar(CalendarDTO pDTO) throws Exception;

    //개인 일정 삭제
    int deleteCalendar(CalendarDTO pDTO) throws Exception;

    int addBookmark(BookmarkDTO bDTO);

    List<BookmarkDTO> getBookmark(BookmarkDTO bDTO) throws Exception;

    int totalCountByCourse(BookmarkDTO pDTO) throws Exception;

    List<BookmarkDTO> getListPagingByCourse(HashMap<String, Object> hMap);


}