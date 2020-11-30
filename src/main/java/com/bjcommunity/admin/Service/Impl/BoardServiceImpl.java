package com.bjcommunity.admin.Service.Impl;

import com.bjcommunity.admin.Dto.BoardDTO;
import com.bjcommunity.admin.Dto.InquiryDTO;
import com.bjcommunity.admin.Dto.NoticeDTO;
import com.bjcommunity.admin.Mapper.BoardMapper;
import com.bjcommunity.admin.Service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardServiceImpl implements BoardService {

    @Autowired
    BoardMapper boardMapper;

    @Override
    public List<BoardDTO> get_board_list(BoardDTO boardDTO) throws Exception {
        return boardMapper.get_board_list(boardDTO);
    }

    @Override
    public int get_board_listCnt(BoardDTO boardDTO) throws Exception {
        return boardMapper.get_board_listCnt(boardDTO);
    }

    @Override
    public List<BoardDTO> get_inquiry_list(InquiryDTO inquiryDTO) throws Exception {
        return boardMapper.get_inquiry_list(inquiryDTO);
    }

    @Override
    public int get_inquiry_listCnt(InquiryDTO inquiryDTO) throws Exception {
        return boardMapper.get_inquiry_listCnt(inquiryDTO);
    }

    @Override
    public List<BoardDTO> get_notice_list(NoticeDTO noticeDTO) throws Exception {
        return boardMapper.get_notice_list(noticeDTO);
    }

    @Override
    public int get_notice_listCnt(NoticeDTO noticeDTO) throws Exception {
        return boardMapper.get_notice_listCnt(noticeDTO);
    }

}
