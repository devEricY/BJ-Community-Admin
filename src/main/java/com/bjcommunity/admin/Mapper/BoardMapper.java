package com.bjcommunity.admin.Mapper;

import com.bjcommunity.admin.Dto.BoardDTO;
import com.bjcommunity.admin.Dto.InquiryDTO;
import com.bjcommunity.admin.Dto.NoticeDTO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardMapper {
    protected static final String NAMESPACE = "com.bjcommunity.admin.Mapper.";

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SqlSession sqlSession;

    public List<BoardDTO> get_board_list(BoardDTO boardDTO){
        return sqlSession.selectList(NAMESPACE + "get_board_list", boardDTO);
    }

    public int get_board_listCnt(BoardDTO boardDTO){
        return sqlSession.selectOne(NAMESPACE + "get_board_listCnt", boardDTO);
    }

    public List<BoardDTO> get_inquiry_list(InquiryDTO inquiryDTO){
        return sqlSession.selectList(NAMESPACE + "get_inquiry_list", inquiryDTO);
    }

    public int get_inquiry_listCnt(InquiryDTO inquiryDTO){
        return sqlSession.selectOne(NAMESPACE + "get_inquiry_listCnt", inquiryDTO);
    }

    public List<BoardDTO> get_notice_list(NoticeDTO noticeDTO){
        return sqlSession.selectList(NAMESPACE + "get_notice_list", noticeDTO);
    }

    public int get_notice_listCnt(NoticeDTO noticeDTO){
        return sqlSession.selectOne(NAMESPACE + "get_notice_listCnt", noticeDTO);
    }
}
