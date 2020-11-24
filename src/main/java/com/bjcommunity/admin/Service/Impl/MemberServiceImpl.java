package com.bjcommunity.admin.Service.Impl;

import com.bjcommunity.admin.Dto.MemberDTO;
import com.bjcommunity.admin.Mapper.MemberMapper;
import com.bjcommunity.admin.Service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberMapper memberMapper;

    @Override
    public List<MemberDTO> get_member_list(MemberDTO memberDTO) throws Exception {
        return memberMapper.get_member_list(memberDTO);
    }

    @Override
    public int get_member_listCnt(MemberDTO memberDTO) throws Exception {
        return memberMapper.get_member_listCnt(memberDTO);
    }
}
