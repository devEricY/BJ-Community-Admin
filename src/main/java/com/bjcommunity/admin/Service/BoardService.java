package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.BoardDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface BoardService {
    public List<BoardDTO> get_board_list(BoardDTO boardDTO) throws Exception;

    public int get_board_listCnt(BoardDTO boardDTO) throws Exception;
}
