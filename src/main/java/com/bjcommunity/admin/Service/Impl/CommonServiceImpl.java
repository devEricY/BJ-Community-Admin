package com.bjcommunity.admin.Service.Impl;

import com.bjcommunity.admin.Dto.CommonDTO;
import com.bjcommunity.admin.Dto.FileDTO;
import com.bjcommunity.admin.Dto.InquiryDTO;
import com.bjcommunity.admin.Mapper.CommonMapper;
import com.bjcommunity.admin.Service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommonServiceImpl implements CommonService {
    @Autowired
    CommonMapper commonMapper;

    @Override
    public CommonDTO getUrlInfo(CommonDTO commonDTO){
        return commonMapper.getUserInfo(commonDTO);
    }

    @Override
    public void setInquiry(InquiryDTO inquiryDTO){ commonMapper.setInquiry(inquiryDTO); }

    @Override
    public String fileUpload(FileDTO fileDTO){
        return String.valueOf(commonMapper.fileUpload(fileDTO));
    };

    @Override
    public String fileUpload(List<FileDTO> fileDTO){
        String rtrnSeq = "";

        for(int i=0; i < fileDTO.size(); i++){
            if( i == 0 ){
                rtrnSeq += commonMapper.fileUpload(fileDTO.get(i));
            }else{
                rtrnSeq += "," + commonMapper.fileUpload(fileDTO.get(i));
            }
        }

        return rtrnSeq;
    };
}
