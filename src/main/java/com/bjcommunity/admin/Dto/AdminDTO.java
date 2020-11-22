package com.bjcommunity.admin.Dto;


import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("AdminDTO")
@Getter
@Setter
public class AdminDTO extends PagingDTO{
    private String admin_id;
    private String admin_pwd;
    private String admin_name;
    private String admin_nick;
    private String admin_email;
    private String admin_phone;
}
