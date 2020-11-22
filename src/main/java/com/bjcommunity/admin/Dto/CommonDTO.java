package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("CommonDTO")
@Getter
@Setter
public class CommonDTO {
    private String pageUrl;
    private String seoKeyWords;
    private String seoDesc;
    private String ogType;
    private String ogTitle;
    private String ogDesc;
    private String ogImg;
    private String seoTitle;
}
