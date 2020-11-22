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
    public List<MemberDTO> userInfo() throws Exception {
        return memberMapper.getUserInfo();
    }
}
