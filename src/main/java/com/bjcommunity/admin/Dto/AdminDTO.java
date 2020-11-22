package com.bjcommunity.admin.Dto;


import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("AdminDTO")
@Getter
@Setter
public class AdminDTO extends PagingDTO{
    private String usrId;
    private String usrPw;
    private String usrNm;
    private String pageUrl;
    private String subNm;
    private String months;
    int rownum;

    private int auth;
    private int failCnt;
    private int totalRsvCnt;
    private int totalRsvAmt;
    private int monthCnt;
    private int price;
    private int cnt;
    private int CurYear;

}
