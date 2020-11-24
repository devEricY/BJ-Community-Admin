package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.*;
import com.bjcommunity.admin.Vo.ResultVO;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Service
public interface AdminService {
    public ResultVO loginProcess(AdminDTO adminDTO, HttpServletRequest request) throws Exception;

    public AdminDTO dashBoard_step1() throws Exception;

    public List<AdminDTO> dashBoard_step2() throws Exception;
}
