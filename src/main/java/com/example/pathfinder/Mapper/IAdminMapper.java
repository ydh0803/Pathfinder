package com.example.pathfinder.Mapper;

import com.example.pathfinder.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IAdminMapper {

    //회원 리스트 호출
    List<UserDTO> getUserPaging(Criteria cri);

    //회원 리스트 페이징
    int userTotalCount(Criteria cri) throws Exception;

    //공지 리스트 호출
    List<NoticeDTO> getNoticePaging(Criteria cri);

    //공지 리스트 페이징
    int NoticeTotalCount(Criteria cri) throws Exception;

    //공지 리스트 호출
    List<NoticeDTO> getNoticeList();

    //공지 상세보기
    NoticeDTO noticeDetail(NoticeDTO pDTO);

    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

    int noticeUpdate(NoticeDTO pDTO) throws Exception;

    //공지 삭제
    int deleteNotice(NoticeDTO pDTO);

    int insertNotice(NoticeDTO pDTO);

    //회원 정보 호출
    UserDTO getUserInfo(UserDTO pDTO) throws Exception;

    //회원 작성글 목록
    List<BoardDTO> getUserBoard(UserDTO pDTO);

    //회원 작성글 상세보기
    BoardDTO userBoardDetail(BoardDTO pDTO) throws Exception;

    //회원 작성글 삭제
    void boardDelete(BoardDTO pDTO) throws Exception;

    //회원 정보 삭제
    void deleteUser(UserDTO pDTO) throws Exception;


}