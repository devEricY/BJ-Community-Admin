package com.bjcommunity.admin.Dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias("FileDTO")
@Getter
@Setter
public class FileDTO {
    private int fno;
    private int bno;
    private int seqno;
    private String fileName;     //저장할 파일
    private String fileOriName;  //실제 파일
    private String fileUrl;
    private String fileEts;
    private String regId;


}
