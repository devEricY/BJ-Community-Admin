package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.BoardDTO;
import com.bjcommunity.admin.Dto.InquiryDTO;
import com.bjcommunity.admin.Dto.NoticeDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface BoardService {
    public List<BoardDTO> get_board_list(BoardDTO boardDTO) throws Exception;

    public int get_board_listCnt(BoardDTO boardDTO) throws Exception;

    public List<InquiryDTO> get_inquiry_list(InquiryDTO inquiryDTO) throws Exception;

    public int get_inquiry_listCnt(InquiryDTO inquiryDTO) throws Exception;

    public List<NoticeDTO> get_notice_list(NoticeDTO noticeDTO) throws Exception;

    public int get_notice_listCnt(NoticeDTO noticeDTO) throws Exception;

}
