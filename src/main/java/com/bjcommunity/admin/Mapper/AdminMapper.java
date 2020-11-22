package com.bjcommunity.admin.Mapper;

import com.bjcommunity.admin.Dto.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminMapper {
    protected static final String NAMESPACE = "com.bjcommunity.admin.Mapper.";

    @Autowired
    private SqlSession sqlSession;

    public int chkAdmInfo(AdminDTO adminDTO){
        return sqlSession.selectOne(NAMESPACE + "chkAdmInfo", adminDTO);
    }

}
