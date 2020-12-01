package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("NoticeDTO")
@Getter
@Setter
public class NoticeDTO extends PagingDTO{

    private String title;
    private String contents;
    private String admin_id;
    private String admin_nick;
    private String reg_date;

    private int notice_seq;
    private int view_cnt;
    private int rownum;

}
