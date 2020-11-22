package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("MemberDTO")
@Getter @Setter
public class MemberDTO {
    private String userId;
    private String userPw;
    private String userNm;
}
