package com.bjcommunity.admin.Controller;

import com.bjcommunity.admin.Dto.*;
import com.bjcommunity.admin.Service.AdminService;
import com.bjcommunity.admin.Service.CommonService;
import com.bjcommunity.admin.Service.MemberService;
import com.bjcommunity.admin.Vo.ResultVO;
import com.bjcommunity.admin.utils.CommonUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@RestController
public class MainController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    MemberService memberService;

    @Autowired
    AdminService adminService;

    @Autowired
    CommonService commonService;

    @Autowired
    CommonUtils commonUtils;
    CommonDTO commonDTO;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView main(HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/dashboard");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();

        AdminDTO rtrnData = new AdminDTO();
        AdminDTO adminDTO = new AdminDTO();
        List<Map<String, Object>> rtrnList = new ArrayList<Map<String, Object>>();

        if(session.getAttribute("admin_id") != null) {
            try {
                //rtrnData = adminService.getDashBoard();
            } catch (Exception e) {
                System.out.println(e.getMessage().toString());
            }
        }else{
            modelview = new ModelAndView("/login");
        }

        modelview.addObject("authCd", session.getAttribute("admin_auth"));
        modelview.addObject("adminId", session.getAttribute("admin_id"));
        modelview.addObject("rtrnData", rtrnData);
        modelview.addObject("rtrnGrpData", rtrnList);
        modelview.addObject("curUrl", curUrl);
        modelview.addObject("isMobile", commonUtils.isMobile(request));
        modelview.addObject("urlInfo", commonDTO);

        return modelview;
    }


    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public ResultVO LoginProcess(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        Map<String, String> rtrnMap = new HashMap<String, String>();
        HttpSession session = request.getSession();

        AdminDTO paramMap = new AdminDTO();
        ResultVO resVO = new ResultVO();

        String paramId = String.valueOf(parameters.get("id"));
        String paramPw = String.valueOf(parameters.get("password"));

        paramMap.setAdmin_id(paramId);
        paramMap.setAdmin_pwd(paramPw);

        try {
            resVO = adminService.loginProcess(paramMap, request);

        } catch (Exception e) {
            System.out.println(e.getMessage().toString());
        }

        return resVO;
    }


}
