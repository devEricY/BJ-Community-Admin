package com.bjcommunity.admin.Vo;
import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.Map;

@Alias("ResultVO")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResultVO {
    private String code;
    private String message;
    private Map<String, Object> resMap;
}
