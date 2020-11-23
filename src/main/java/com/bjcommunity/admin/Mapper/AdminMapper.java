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

    public int chk_pre_info(AdminDTO adminDTO){
        return sqlSession.selectOne(NAMESPACE + "chk_pre_info", adminDTO);
    }

    public AdminDTO get_adm_info(AdminDTO adminDTO){
        return sqlSession.selectOne(NAMESPACE + "get_adm_info", adminDTO);
    }

    public void set_adm_failCnt(AdminDTO adminDTO){
        sqlSession.update(NAMESPACE + "set_adm_failCnt", adminDTO);
    }

    public void set_adm_resetCnt(AdminDTO adminDTO){
        sqlSession.update(NAMESPACE + "set_adm_resetCnt", adminDTO);
    }

    public void set_adm_loginLog(AdminDTO adminDTO){
        sqlSession.insert(NAMESPACE + "set_adm_loginLog", adminDTO);
    }


}
