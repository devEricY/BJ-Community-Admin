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

    public List<MemberDTO> get_member_list(MemberDTO memberDTO){
        return sqlSession.selectList(NAMESPACE + "get_member_list", memberDTO);
    }

    public int get_member_listCnt(MemberDTO memberDTO){
        return sqlSession.selectOne(NAMESPACE + "get_member_listCnt", memberDTO);
    }

}
