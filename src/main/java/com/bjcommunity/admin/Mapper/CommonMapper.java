package com.bjcommunity.admin.Mapper;

import com.bjcommunity.admin.Dto.CommonDTO;
import com.bjcommunity.admin.Dto.FileDTO;
import com.bjcommunity.admin.Dto.InquiryDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommonMapper {
    protected static final String NAMESPACE = "com.bjcommunity.admin.Mapper.";

    @Autowired
    private SqlSession sqlSession;

    public CommonDTO getUserInfo(CommonDTO commonDTO){
        return sqlSession.selectOne(NAMESPACE + "getUrlInfo", commonDTO);
    }

    public void setInquiry(InquiryDTO inquiryDTO){
        sqlSession.insert(NAMESPACE + "setInquiry", inquiryDTO);
    }

    public int fileUpload(FileDTO fileDTO){
        sqlSession.insert(NAMESPACE + "fileUpload", fileDTO);

        return fileDTO.getSeqno();
    }

}
