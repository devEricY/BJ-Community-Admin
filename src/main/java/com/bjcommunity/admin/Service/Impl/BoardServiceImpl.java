package com.bjcommunity.admin.Service.Impl;

import com.bjcommunity.admin.Dto.BoardDTO;
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
}
