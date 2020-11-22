package com.bjcommunity.admin.Mapper;

import com.bjcommunity.admin.Dto.MemberDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberMapper {
    protected static final String NAMESPACE = "com.bjcommunity.admin.Mapper.";

    @Autowired
    private SqlSession sqlSession;

    public String getUserNm(){
        return sqlSession.selectOne(NAMESPACE + "getUserNm");
    }

    public List<MemberDTO> getUserInfo(){
        return sqlSession.selectList(NAMESPACE + "getUserInfo");
    }
}
