package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("MemberDTO")
@Getter @Setter
public class MemberDTO {
    private String member_id;
    private String member_name;
    private String member_nick;
    private String member_phone;
}
