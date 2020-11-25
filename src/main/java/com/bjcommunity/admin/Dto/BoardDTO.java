package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("BoardDTO")
@Getter
@Setter
public class BoardDTO extends PagingDTO {

    private String board_title;
    private String board_content;
    private String board_lock_yn;
    private String board_lock_pwd;

    private String member_id;
    private String member_name;

    private String reg_date;

    private int rownum;
    private int board_seq;
    private int board_class_seq;
    private int board_view_cnt;
    private int board_recomm_cnt;
}
