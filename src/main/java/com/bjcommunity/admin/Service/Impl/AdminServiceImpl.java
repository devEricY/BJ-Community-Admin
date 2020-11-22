package com.bjcommunity.admin.Service.Impl;

import com.bjcommunity.admin.Dto.*;
import com.bjcommunity.admin.Mapper.AdminMapper;
import com.bjcommunity.admin.Service.AdminService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;

    public Map<String, Object> loginProcess(AdminDTO adminDTO){
        Map<String, Object> results = new HashMap<String, Object>();
        int dataCnt = adminMapper.chkAdmInfo(adminDTO);

        if(dataCnt <= 0){
            results.put("returnFlag", 1);                                                                               // returnFlag = 1 테이블에 자료가 없을 때
            results.put("returnMsg", "아이디 혹은 비밀번호를 확인해주세요.");
        }else{
            AdminDTO rtrnAdmDTO = adminMapper.getAdmInfo(adminDTO);

            if(rtrnAdmDTO != null) {
                if (!rtrnAdmDTO.getUsrId().isEmpty() && !rtrnAdmDTO.getUsrPw().isEmpty()) {
                    if (rtrnAdmDTO.getFailCnt() >= 5) {
                        results.put("returnFlag", 3);                                                                       // returnFlag = 3 비밀번호 횟수가 5회 이상일 때
                        results.put("returnMsg", "비밃번호를 5회이상 틀리셨습니다. 관리자에게 문의해주세요.");
                    } else {
                        results.put("returnFlag", 7);                                                                       // returnFlag = 7 데이터를 정상적으로 가져왔을 때
                        results.put("adminInfo", rtrnAdmDTO);
                        rtrnAdmDTO.setPageUrl("loginProcessing");
                        adminMapper.setAdmLog(rtrnAdmDTO);
                        adminMapper.setCntReset(rtrnAdmDTO);
                    }
                } else {
                    adminMapper.setFailedLogin(adminDTO);
                    results.put("returnFlag", 2);                                                                           // returnFlag = 2 비밀번호가 맞지 않을 때
                    results.put("returnMsg", "아이디 혹은 비밀번호를 확인해주세요.");
                }
            }else {
                adminMapper.setFailedLogin(adminDTO);
                results.put("returnFlag", 2);                                                                           // returnFlag = 2 비밀번호가 맞지 않을 때
                results.put("returnMsg", "아이디 혹은 비밀번호를 확인해주세요.");
            }
        }
        return results;
    }
}
