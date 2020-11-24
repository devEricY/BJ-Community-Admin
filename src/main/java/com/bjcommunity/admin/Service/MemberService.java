package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.MemberDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MemberService {
    public List<MemberDTO> get_member_list(MemberDTO memberDTO) throws Exception;

    public int get_member_listCnt(MemberDTO memberDTO) throws Exception;
}
