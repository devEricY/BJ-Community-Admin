package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.CommonDTO;
import com.bjcommunity.admin.Dto.FileDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CommonService {
    public CommonDTO getUrlInfo(CommonDTO commonDTO);

    public String fileUpload(FileDTO fileDTO);

    public String fileUpload(List<FileDTO> fileDTO);
}
