package com.bjcommunity.admin.Mapper;

import com.bjcommunity.admin.Dto.BoardDTO;
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

}
