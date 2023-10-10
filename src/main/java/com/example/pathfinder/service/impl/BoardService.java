package com.example.pathfinder.service.impl;

import com.example.pathfinder.Mapper.IBoardMapper;
import com.example.pathfinder.dto.BoardDTO;
import com.example.pathfinder.dto.CommentDTO;
import com.example.pathfinder.dto.Criteria;
import com.example.pathfinder.service.IBoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class BoardService implements IBoardService {
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date time = new Date();
    String localTime = format.format(time);

    @Autowired
    IBoardMapper iBoardMapper;

    //게시글 등록
    public void Upload(BoardDTO pDTO){
        log.info(this.getClass().getName() + ".upload start");
        log.info(String.valueOf(pDTO));
        log.info(this.getClass().getName() + ".upload end");
        pDTO.setRegdate(localTime);
        iBoardMapper.Upload(pDTO);

    }


    //게시글 총갯수 조회
    public int totalCount(Criteria cri) throws Exception {

        return iBoardMapper.totalCount(cri);
    }

    public int totalCountByCourse(BoardDTO pDTO) throws Exception {

        return iBoardMapper.totalCountByCourse(pDTO);
    }

    //게시판 상세보기
    public BoardDTO getBoardInfo(BoardDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getBoardInfo start!");


        return iBoardMapper.getBoardInfo(pDTO);

    }

    //게시글 수정
    public void boardUpdate(BoardDTO pDTO) throws Exception{
        log.info(this.getClass().getName() + ".boardUpdate start!");
        pDTO.setRegdate(localTime);
        iBoardMapper.boardUpdate(pDTO);
    }

    //게시글 삭제
    public void boardDelete(BoardDTO pDTO) throws Exception{
        log.info(this.getClass().getName()+".boardDelete start!");
        iBoardMapper.boardDelete(pDTO);
    }

    public List<BoardDTO> getListPaging(int pNo) {
        Criteria cri = new Criteria();
        cri.setPageNum(pNo);
        return iBoardMapper.getListPaging(cri);
    }


    public int insertComment(CommentDTO pDTO) throws Exception {
        int res = 0;
        pDTO.setRegdate(localTime);
        iBoardMapper.insertComment(pDTO);
        res = 1;
        return res;
    }

    public List<CommentDTO> getComment(CommentDTO pDTO) {

        return iBoardMapper.getComment(pDTO);
    }

    public int getRepCnt(CommentDTO pDTO) {
        return iBoardMapper.getRepCnt(pDTO);
    }

    public int repDelete(CommentDTO pDTO) {
        iBoardMapper.repDelete(pDTO);
        return 0;
    }

    public void commentUpdate(CommentDTO pDTO) throws Exception{
        log.info(this.getClass().getName() + ".commentUpdate start!");
        pDTO.setRegdate(localTime);
        iBoardMapper.commentUpdate(pDTO);
    }

//    @Autowired
//    private final IBoardMapper boardMapper;
//
//    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//    Date time = new Date();
//    String localTime = format.format(time);
//
//    @Autowired
//    public BoardService(IBoardMapper boardMapper) {
//
//        this.boardMapper = boardMapper;
//    }
//
//    @Transactional
//    @Override
//    public void WriteReview(BoardDTO boardDTO) throws Exception {
//        log.info(this.getClass().getName() + "start!");
//
//        boardMapper.writeBoard(boardDTO);
//
//        log.info((this.getClass().getName() + "end!"));
//    }

}
