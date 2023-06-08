package com.example.pathfinder.Mapper;

import com.example.pathfinder.dto.BoardDTO;
import com.example.pathfinder.dto.CommentDTO;
import com.example.pathfinder.dto.Criteria;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Objects;

@Mapper
public interface IBoardMapper {
    int Upload(BoardDTO pDTO);

    int totalCount(Criteria cri) throws Exception;

    int totalCountByCourse(BoardDTO pDTO) throws Exception;

    /* 게시판 목록(페이징 적용) */
    List<BoardDTO> getListPaging(Criteria cri);

    List<BoardDTO> getListPagingByCourse(HashMap<String, Object> hMap);

    BoardDTO getBoardInfo(BoardDTO pDTO) throws Exception;

    int boardUpdate(BoardDTO pDTO) throws Exception;

    int boardDelete(BoardDTO pDTO) throws Exception;

    int insertComment(CommentDTO pDTO) throws Exception;

    List<CommentDTO> getComment(CommentDTO pDTO);

    int commentUpdate(CommentDTO pDTO);

    int getRepCnt(CommentDTO pDTO);

    void repDelete(CommentDTO pDTO);
}