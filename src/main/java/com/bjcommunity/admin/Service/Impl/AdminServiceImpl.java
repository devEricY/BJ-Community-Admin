package com.bjcommunity.admin.Service.Impl;

import com.bjcommunity.admin.Dto.*;
import com.bjcommunity.admin.Enum.AdminEnum;
import com.bjcommunity.admin.Mapper.AdminMapper;
import com.bjcommunity.admin.Service.AdminService;
import com.bjcommunity.admin.Vo.ResultVO;
import com.bjcommunity.admin.utils.CommonUtils;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Repository
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;

    public ResultVO loginProcess(AdminDTO adminDTO, HttpServletRequest request){
        ResultVO resultVO = null;
        int dataCnt = adminMapper.chk_pre_info(adminDTO);

        if(dataCnt <= 0){
            resultVO = new ResultVO("500", AdminEnum.LOGIN_FAIL.getValue(), null);
        }else{
            AdminDTO infoDTO = adminMapper.get_adm_info(adminDTO);

            if(infoDTO != null){
                if(infoDTO.getFailCnt() >= 5) {
                    resultVO = new ResultVO("500", AdminEnum.LOGIN_FIVE_FAIL.getValue(), null);
                }else{

                    if(BCrypt.checkpw(adminDTO.getAdmin_pwd(), infoDTO.getAdmin_pwd())){

                        HttpSession session = request.getSession();

                        resultVO = new ResultVO("200", AdminEnum.LOGIN_SUCCESS.getValue(), null);

                        session.setAttribute("admin_id", infoDTO.getAdmin_id());
                        session.setAttribute("admin_name", infoDTO.getAdmin_name());
                        session.setAttribute("admin_auth", infoDTO.getAdmin_auth());

                        adminDTO.setAccess_device(CommonUtils.isDevice(request));
                        adminDTO.setAccess_page("LoginProcess");
                        adminDTO.setAccess_ip(String.valueOf(request.getHeader("X-FORWARDED-FOR")));
                        adminMapper.set_adm_loginLog(adminDTO);
                        adminMapper.set_adm_resetCnt(adminDTO);

                    }else{
                        adminMapper.set_adm_failCnt(adminDTO);
                        resultVO = new ResultVO("500", AdminEnum.LOGIN_FAIL.getValue(), null);
                    }
                }
            }else{
                adminMapper.set_adm_failCnt(adminDTO);
                resultVO = new ResultVO("500", AdminEnum.LOGIN_FAIL.getValue(), null);
            }
        }

        return resultVO;
    }

    public AdminDTO dashBoard_step1(){
        return adminMapper.get_adm_dashBoard_step1();
    }

    public List<AdminDTO> dashBoard_step2(){
        return adminMapper.get_adm_dashBoard_step2();
    }
}
