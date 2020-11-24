package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("MemberDTO")
@Getter @Setter
public class MemberDTO extends PagingDTO{
    private String member_id;
    private String member_name;
    private String member_nick;
    private String member_phone;
    private String member_email;
    private String member_profile;

    private int member_seq;
    private int member_grade;
    private int member_state;
    private int member_point;

    private int fail_cnt;

    private String mail_yn;
    private String sms_yn;
    private String privacy_yn;
    private String reg_date;

}
