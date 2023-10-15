package com.example.pathfinder.controller;

import com.example.pathfinder.dto.*;
import com.example.pathfinder.service.impl.BoardService;
import com.example.pathfinder.util.CmmUtil;
import com.example.pathfinder.service.impl.S3Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@Slf4j
public class BoardController {


    private final BoardService boardService;
    private final S3Service s3Service;


    public BoardController(BoardService boardService, S3Service s3service) {
        this.boardService = boardService;
        this.s3Service = s3service;
    }

        @GetMapping("/review/reviewWrite")
        public String reviewWrite() {
        return "/review/reviewWrite";
    }



    @PostMapping("/upload")
    public String execWrite(MultipartHttpServletRequest request, Model model) throws Exception {
        log.info(this.getClass().getName() + ".execWrite start");
        String title = CmmUtil.nvl(request.getParameter("title"));
        String contents = CmmUtil.nvl(request.getParameter("contents"));
        log.info(title);
        if(!Objects.requireNonNull(request.getFile("file")).isEmpty()) {
            MultipartFile file = request.getFile("file");
            String imgPath = s3Service.upload(file);
            String imglink = "https://pathfinder22.s3.ap-northeast-2.amazonaws.com/" + imgPath;
            Integer userNo = Integer.parseInt(request.getParameter("userNo"));
            log.info(title);
            log.info(contents);
            log.info(imglink);
            log.info(String.valueOf(userNo));
            BoardDTO pDTO = new BoardDTO();
            pDTO.setTitle(title);
            pDTO.setContents(contents);
            pDTO.setUserNo(String.valueOf(userNo));
            pDTO.setImglink(imglink);
            boardService.Upload(pDTO);
            String msg = "글이 작성되었습니다.";
            model.addAttribute("msg", msg);
        }else{
            int userNo = Integer.parseInt(request.getParameter("userNo"));
            BoardDTO pDTO = new BoardDTO();
            pDTO.setTitle(title);
            pDTO.setContents(contents);
            pDTO.setUserNo(String.valueOf(userNo));
            boardService.Upload(pDTO);
            String msg = "글이 작성되었습니다.";
            model.addAttribute("msg", msg);

        }
        return "/review/MsgToList";

    }

    @ResponseBody
    @PostMapping("/commentReg")
    public void commentReg(@RequestBody List<Map<String, Object>> params, HttpSession session) throws Exception {
        /*ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> param = objectMapper.convertValue(params, new TypeReference<List<Map<String, Object>>>(){});*/
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        for (Map<String, Object> list : params) {
            String comment = (String) list.get("comment");
            Integer bNo = (Integer) list.get("boardNo");
            CommentDTO pDTO = new CommentDTO();
            pDTO.setUserNo(uDTO.getUserNo());
            pDTO.setBoardNo(bNo);
            pDTO.setCommentText(comment);
            boardService.insertComment(pDTO);
        }
    }

    @ResponseBody
    @PostMapping("/commentUpdate")
    public void commentUpdate(@RequestBody List<Map<String, Object>> params) throws Exception {
        /*ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> param = objectMapper.convertValue(params, new TypeReference<List<Map<String, Object>>>(){});*/

        for (Map<String, Object> list : params) {
            String comment = (String) list.get("commentText");
            int commentNo = (int) list.get("commentNo");
            CommentDTO pDTO = new CommentDTO();
            pDTO.setCommentText(comment);
            pDTO.setCommentNo(commentNo);
            boardService.commentUpdate(pDTO);
        }
    }

    @ResponseBody
    @PostMapping(value = "repDelete")
    public int repDelete(@RequestBody List<Map<String, Object>> params) {
        for (Map<String, Object> list : params) {
            String commentNo = (String) list.get("commentNo");
            int cNo = Integer.parseInt(commentNo);
            CommentDTO pDTO = new CommentDTO();
            pDTO.setCommentNo(cNo);
            boardService.repDelete(pDTO);
        }
        return 1;
    }

    @GetMapping(value = "/review/reviewDetail")
    public String NoticeInfo(HttpServletRequest request, ModelMap model, Criteria cri) {

        log.info(this.getClass().getName() + ".boardInfo start!");

        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String bNo = CmmUtil.nvl(request.getParameter("bNo")); // 공지글번호(PK)

            /*
             * ####################################################################################
             * 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
             * ####################################################################################
             */
            log.info("bNo : " + bNo);

            /*
             * 값 전달은 반드시 DTO 객체를 이용해서 처리함 전달 받은 값을 DTO 객체에 넣는다.
             */
            BoardDTO pDTO = new BoardDTO();
            pDTO.setBoardNo(Integer.parseInt(bNo));

            // 공지사항 상세정보 가져오기
            BoardDTO rDTO = boardService.getBoardInfo(pDTO);

            CommentDTO cDTO = new CommentDTO();
            cDTO.setBoardNo(Integer.parseInt(bNo));
            List<CommentDTO> rList = boardService.getComment(cDTO);
            int res = boardService.getRepCnt(cDTO);

            log.info("getBoardInfo success");

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);
            model.addAttribute("rList", rList);
            model.addAttribute("res", res);

        } catch (Exception e) {
            // 저장이 실패되면 사용자에게 보여줄 메시지
            log.info(e.toString());
            e.printStackTrace();
        } finally {
            log.info(this.getClass().getName() + ".boardInfo end!");

        }

        log.info(this.getClass().getName() + ".boardInfo end!");

        return "/review/reviewDetail";
    }
    @GetMapping(value = "/review/reviewEdit")
    public String BoardEditInfo(HttpServletRequest request, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".BoardEditInfo start!");
        String msg = "";
        String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 글번호(PK)
        log.info("nSeq : " + nSeq);
        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoardNo(Integer.parseInt(nSeq));
        BoardDTO rDTO = boardService.getBoardInfo(pDTO);
        if (rDTO == null) {
            rDTO = new BoardDTO();
        }
        model.addAttribute("rDTO", rDTO);
        log.info(this.getClass().getName() + ".BoardEditInfo end!");
        return "/review/reviewEdit";
    }

    @PostMapping(value = "/reviewUpdate")
    public String boardUpdate(MultipartHttpServletRequest request, Model model) throws Exception {
        String title = CmmUtil.nvl(request.getParameter("title"));
        String contents = CmmUtil.nvl(request.getParameter("contents"));
        int boardNo = Integer.parseInt(CmmUtil.nvl(request.getParameter("nSeq")));
        String imgLink = CmmUtil.nvl(request.getParameter("imglink"));
        log.info(imgLink);
        if(!Objects.requireNonNull(request.getFile("file")).isEmpty()) {
            s3Service.deleteS3("static/image " + imgLink);
            MultipartFile file = request.getFile("file");
            String imgPath = s3Service.upload(file);
            String imglink = "https://pathfinder22.s3.ap-northeast-2.amazonaws.com/" + imgPath;
            log.info(title);
            log.info(contents);
            log.info(imglink);
            BoardDTO pDTO = new BoardDTO();
            pDTO.setTitle(title);
            pDTO.setContents(contents);
            pDTO.setBoardNo(boardNo);
            pDTO.setImglink(imglink);
            boardService.boardUpdate(pDTO);
            String msg = "글이 수정되었습니다.";
            model.addAttribute("msg", msg);
        }else{
            BoardDTO pDTO = new BoardDTO();
            pDTO.setTitle(title);
            pDTO.setContents(contents);
            pDTO.setBoardNo(boardNo);
            pDTO.setImglink(imgLink);
            boardService.boardUpdate(pDTO);
            String msg = "글이 수정되었습니다.";
            model.addAttribute("msg", msg);
        }
        return "/review/MsgToList";

    }

    @GetMapping(value = "/reviewDelete")
    public String boardDelete(HttpServletRequest request, Model model) throws Exception{
        int boardNo = Integer.parseInt(CmmUtil.nvl(request.getParameter("nSeq")));
        BoardDTO pDTO = new BoardDTO();
        pDTO.setBoardNo(boardNo);
        BoardDTO rDTO = boardService.getBoardInfo(pDTO);
        if (rDTO.getImglink() != null) {
            String[] fileName = rDTO.getImglink().split("/");
            s3Service.deleteS3(fileName[3]);
            boardService.boardDelete(pDTO);
            String msg = "게시글이 삭제 되었습니다.";
            model.addAttribute("msg",msg);
            return "/review/MsgToList";
        }else {
            boardService.boardDelete(pDTO);
            String msg = "게시글이 삭제 되었습니다.";
            model.addAttribute("msg",msg);
            return "/review/MsgToList";
        }
    }

    @GetMapping("/review/reviewList")
    public String boardListGET(HttpServletRequest request, Model model, Criteria cri) throws Exception {
        int pNo = 1;
        if (request.getParameter("pNo") != null) {
            pNo = Integer.valueOf(request.getParameter("pNo"));

            log.info("cri : " + cri);

            model.addAttribute("list", boardService.getListPaging(pNo));

            int total = boardService.totalCount(cri);

            PageMakeDTO pageMake = new PageMakeDTO(cri, total);

            model.addAttribute("pageMaker", pageMake);

            log.info("ggg" + model);
            return "/review/ReviewList";
        }
        log.info("boardListGET");

        log.info("cri : " + cri);

        model.addAttribute("list", boardService.getListPaging(pNo));

        int total = boardService.totalCount(cri);

        PageMakeDTO pageMake = new PageMakeDTO(cri, total);

        model.addAttribute("pageMaker", pageMake);
        return "/review/reviewList";
    }


}
