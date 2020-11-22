package com.bjcommunity.admin.Controller;

import com.bjcommunity.admin.Dto.*;
import com.bjcommunity.admin.Service.AdminService;
import com.bjcommunity.admin.Service.CommonService;
import com.bjcommunity.admin.Service.MemberService;
import com.bjcommunity.admin.utils.CommonUtils;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
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
        commonDTO = commonUtils.getUrlInfo("default");
        ModelAndView  modelview = new ModelAndView("/dashboard");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();

        AdminDTO rtrnData = new AdminDTO();
        AdminDTO adminDTO = new AdminDTO();
        List<Map<String, Object>> rtrnList = new ArrayList<Map<String, Object>>();

        if(session.getAttribute("admUsrId") != null) {
            try {
                rtrnData = adminService.getDashBoard();
            } catch (Exception e) {
                System.out.println(e.getMessage().toString());
            }
        }else{
            modelview = new ModelAndView("/login");
        }

        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("rtrnData", rtrnData);
        modelview.addObject("rtrnGrpData", rtrnList);
        modelview.addObject("curUrl", curUrl);
        modelview.addObject("isMobile", commonUtils.isMobile(request));
        modelview.addObject("urlInfo", commonDTO);

        return modelview;
    }


}
