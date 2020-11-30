package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("InquiryDTO")
@Getter
@Setter
public class InquiryDTO extends PagingDTO{

    private String title;
    private String contents;
    private String lock_yn;
    private String lock_pwd;
    private String member_id;
    private String reg_date;
    private String del_yn;
    private String response_yn;

    private String inquiry_refer;
    private String inquiry_level;
    private String inquiry_type;

    private int view_cnt;
    private int inquiry_seq;
    private int rownum;

}
