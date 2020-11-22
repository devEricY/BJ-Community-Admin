package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.MemberDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MemberService {
    public List<MemberDTO> userInfo() throws Exception;
}
