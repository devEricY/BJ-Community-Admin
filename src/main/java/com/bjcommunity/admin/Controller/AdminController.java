package com.bjcommunity.admin.Controller;

import com.bjcommunity.admin.Dto.*;
import com.bjcommunity.admin.Service.AdminService;
import com.bjcommunity.admin.Service.CommonService;
import com.bjcommunity.admin.Service.RentService;
import com.bjcommunity.admin.utils.CommonUtils;
import com.bjcommunity.admin.utils.PageMaker;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.juli.logging.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.logging.logback.LogbackLoggingSystem;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class AdminController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    AdminService adminService;

    @Autowired
    RentService rentService;

    @Autowired
    CommonService commonService;

    @Autowired
    CommonUtils commonUtils;

    @RequestMapping(value = "/admin/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/login");

        String paramFlag = parameters.get("flag");
        String paramMsg = parameters.get("msg");

        if(paramFlag != null){
            modelview.addObject("flag", paramFlag);
            modelview.addObject("msg", paramMsg);
        }else{
            modelview.addObject("flag", 0);
            modelview.addObject("msg", "");
        }

        logger.debug("commonUtils.isMobile(request) : " + commonUtils.isMobile(request));
        modelview.addObject("isMobile", commonUtils.isMobile(request));

        return modelview;
    }

    @RequestMapping(value = "/admin/S_login", method = RequestMethod.POST)
    public ModelAndView S_login(@RequestParam Map<String, String> parameters, HttpServletRequest request){

        Map<String, Object> results = new HashMap<String, Object>();
        ModelAndView  modelview = new ModelAndView("redirect:/admin/login");
        AdminDTO adminDTO = new AdminDTO();

        String paramId = String.valueOf(parameters.get("id"));
        String paramPw = String.valueOf(parameters.get("password"));

        if(!"".equals(paramId) && !"".equals(paramPw)){
            adminDTO.setUsrId(paramId);
            adminDTO.setUsrPw(paramPw);
            try{
                results = adminService.loginProcess(adminDTO);

                if(results.get("returnFlag").equals(7)){
                    HttpSession session = request.getSession();

                    AdminDTO resultDTO = (AdminDTO) results.get("adminInfo");

                    session.setAttribute("admUsrId", resultDTO.getUsrId());
                    session.setAttribute("admUsrNm", resultDTO.getUsrPw());
                    session.setAttribute("admAuthCd", resultDTO.getAuth());

                    modelview.setViewName("redirect:/admin/dashboard");
                }else{
                    modelview.setViewName("redirect:/admin/login");
                }

            }catch (Exception e){
                //System.out.println(e.getMessage().toString());
                results.put("returnFlag", 4);                                                // returnFlag = 4 서비스 진행중에 오류가 났을 때
                results.put("returnMsg", "진행중 오류가 발생했습니다. 관리자에게 문의해주세요.");
            }
        }

        modelview.addObject("flag", results.get("returnFlag"));
        modelview.addObject("msg", results.get("returnMsg"));

        return modelview;
    }

    @RequestMapping(value = "/admin/dashboard", method = RequestMethod.GET)
    public ModelAndView dashboard(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/dashboard");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        SimpleDateFormat format_year = new SimpleDateFormat ( "yyyy");

        AdminDTO rtrnData = new AdminDTO();
        AdminDTO adminDTO = new AdminDTO();
        List<AdminDTO> rtrnGrpMonth = new ArrayList<AdminDTO>();
        List<Map<String, Object>> rtrnList = new ArrayList<Map<String, Object>>();
        Map<String, Object> monthMap = new HashMap<String, Object>();
        int[] price = null;
        String[] months = null;
        String flag = "default";

        Calendar cal = Calendar.getInstance();
        String thisYear = format_year.format(cal.getTime());

        adminDTO.setCurYear(Integer.parseInt(thisYear));

        try{
            rtrnData = adminService.getDashBoard();
            rtrnGrpMonth = adminService.getDashMonth(adminDTO);
            int j = 0;
            int k = 1;

            for(int i=0; i < rtrnGrpMonth.size(); i++){
                if(!flag.equals(rtrnGrpMonth.get(i).getSubNm())){
                    flag = rtrnGrpMonth.get(i).getSubNm();
                    price = new int[rtrnGrpMonth.get(i).getMonthCnt()];
                    months = new String[rtrnGrpMonth.get(i).getMonthCnt()];
                    monthMap = new HashMap<String, Object>();
                    monthMap.put("rentNm", rtrnGrpMonth.get(i).getSubNm());
                    j = 0;
                }

                price[j] = rtrnGrpMonth.get(i).getPrice();
                months[j] = rtrnGrpMonth.get(i).getMonths();

                j++;

                if(j == rtrnGrpMonth.get(i).getMonthCnt()){
                    System.out.println(" ---- if in ---- ");
                    monthMap.put("price", price);
                    monthMap.put("months", months);
                    rtrnList.add(monthMap);
                    System.out.println(rtrnList);
                }

            }

        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("rtrnData", rtrnData);
        modelview.addObject("rtrnGrpData", rtrnList);
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }

    @RequestMapping(value = "/admin/logout", method = RequestMethod.GET)
    public ModelAndView logout(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/logout");

        HttpSession session = request.getSession();

        session.removeAttribute("admUsrId");
        session.removeAttribute("admUsrNm");
        session.invalidate();

        return modelview;
    }

    @RequestMapping(value = "/admin/rsv/list", method = RequestMethod.GET)
    public ModelAndView rsvList(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum, RentDTO pagingDTO){
        ModelAndView  modelview = new ModelAndView("/admin/rsv/rsvList");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        List<RentDTO> list = null;
        String[] times = null;
        int[] timeInt = null;
        List<int[]> timeArr = new ArrayList<int[]>();
        Map<String, String> paramMap = new HashMap<String, String>();

        //pagingDTO.setPage(pageNum);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPaging(pagingDTO);

        String paramUsrNm = parameters.get("usrNm");
        String paramRentNm = parameters.get("rentNm");
        String paramDepoNm = parameters.get("depoNm");
        String paramPhone = parameters.get("phone");
        String paramRsvCd = parameters.get("rsvCd");
        String paramRegDate = parameters.get("reg_date");

        paramMap.put("usrNm", paramUsrNm);
        paramMap.put("rentNm", paramRentNm);
        paramMap.put("depoNm", paramDepoNm);
        paramMap.put("phone", paramPhone);
        paramMap.put("reg_date", paramRegDate);
        paramMap.put("rsvCd", paramRsvCd);

        pagingDTO.setUsrNm(paramUsrNm);
        pagingDTO.setRentNm(paramRentNm);
        pagingDTO.setDepoNm(paramDepoNm);
        pagingDTO.setPhoneNo(paramPhone);
        pagingDTO.setReg_date(paramRegDate);
        pagingDTO.setRsv_code(paramRsvCd);

        try{
            pageMaker.setTotalCount(adminService.admRsvListCnt(pagingDTO));
            list = adminService.admRsvList(pagingDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        for(int i=0; i < list.size(); i++){
            if(list.get(i).getRsv_time() != null){
                times = list.get(i).getRsv_time().split(",");
                timeInt = new int[times.length];

                for(int j=0; j < times.length; j++){
                    timeInt[j] = Integer.parseInt(times[j]);
                }

                Arrays.sort(timeInt);

                timeArr.add(timeInt);
            }
        }

        modelview.addObject("curPage", pageNum);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("param", paramMap);
        modelview.addObject("timeList", timeArr);
        modelview.addObject("rsvList", list);
        modelview.addObject("rsvListCnt", list.size());
        modelview.addObject("curUrl", curUrl);
        modelview.addObject("pageMaker", pageMaker);
        modelview.addObject("isMobile", commonUtils.isMobile(request));

        return modelview;
    }

    @RequestMapping(value = "/admin/rsv/exDown", method = RequestMethod.POST)
    public ModelAndView rsvExDown(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum, RentDTO pagingDTO){
        ModelAndView  modelview = new ModelAndView("/admin/rsv/rsvExDown");
        String curUrl = request.getServletPath();
        HttpSession session = request.getSession();
        List<RentDTO> list = null;
        String[] times = null;
        int[] timeInt = null;
        List<int[]> timeArr = new ArrayList<int[]>();
        Map<String, String> paramMap = new HashMap<String, String>();

        String paramUsrNm = parameters.get("usrNm");
        String paramRentNm = parameters.get("rentNm");
        String paramDepoNm = parameters.get("depoNm");
        String paramPhone = parameters.get("phone");
        String paramRegDate = parameters.get("reg_date");

        paramMap.put("usrNm", paramUsrNm);
        paramMap.put("rentNm", paramRentNm);
        paramMap.put("depoNm", paramDepoNm);
        paramMap.put("phone", paramPhone);
        paramMap.put("reg_date", paramRegDate);

        pagingDTO.setUsrNm(paramUsrNm);
        pagingDTO.setRentNm(paramRentNm);
        pagingDTO.setDepoNm(paramDepoNm);
        pagingDTO.setPhoneNo(paramPhone);
        pagingDTO.setReg_date(paramRegDate);

        try{
            list = adminService.admRsvExcelList(pagingDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        for(int i=0; i < list.size(); i++){
            if(list.get(i).getRsv_time() != null){
                times = list.get(i).getRsv_time().split(",");
                timeInt = new int[times.length];

                for(int j=0; j < times.length; j++){
                    timeInt[j] = Integer.parseInt(times[j]);
                }

                Arrays.sort(timeInt);

                timeArr.add(timeInt);
            }
        }
        modelview.addObject("param", paramMap);
        modelview.addObject("timeList", timeArr);
        modelview.addObject("rsvList", list);
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }

    @RequestMapping(value = "/admin/rsv/rsvInfo", method = RequestMethod.GET)
    public ModelAndView rsvInfo(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum, RentDTO rentDTO){
        ModelAndView  modelview = new ModelAndView("/admin/rsv/rsvInfo");

        SimpleDateFormat format_year = new SimpleDateFormat ( "yyyy");
        SimpleDateFormat format_month = new SimpleDateFormat ( "MM");

        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        RentDTO rsvInfo = null;
        String[] times = null;
        int[] timeInt = null;
        List<int[]> timeArr = new ArrayList<int[]>();
        List<RentDTO> rentInfo = new ArrayList<RentDTO>();
        List<RentDTO> timeInfo = new ArrayList<RentDTO>();
        List<EquipDTO> EqList = new ArrayList<EquipDTO>();
        Map<String, Object> dateInfo = new HashMap<String, Object>();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        EquipDTO eqInfo = new EquipDTO();
        String[] rsvEqList = null;

        int paramSeqNo = Integer.parseInt(parameters.get("seq"));
        String resultCode = (String)parameters.get("resultCode");
        String paramYear = parameters.get("year");
        String paramMonth = parameters.get("month");

        paramMap.put("seqNo", paramSeqNo);

        rentDTO.setSeqNo(paramSeqNo);
        eqInfo.setChecked(true);

        try{
            rsvInfo = adminService.getRsvInfo(rentDTO);
            rentInfo = rentService.rsvFacInfo();
            timeInfo = rentService.getRsvTimes();

            eqInfo.setRentNo(rsvInfo.getRentNo());
            EqList = rentService.rsvEquipPreInfo(eqInfo);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        /* 나중에 상황 봐서 아래 정렬 코드는 삭제해도 무방할 듯 */
        if(rsvInfo.getRsv_time() != null){

            times = rsvInfo.getRsv_time().split(",");
            timeInt = new int[times.length];

            for(int i=0; i < times.length; i++){
                timeInt[i] = Integer.parseInt(times[i]);
            }

            Arrays.sort(timeInt);

            modelview.addObject("rsv_times", timeInt);
        }

        if(rsvInfo.getRsv_date() != null){
            paramYear = format_year.format(rsvInfo.getRsv_date());
            paramMonth = String.valueOf(Integer.parseInt(format_month.format(rsvInfo.getRsv_date())) - 1);
        }

        dateInfo = commonUtils.calendar(paramYear, paramMonth);

        if(rsvInfo.getEqList() != null){
            String[] tempStr = rsvInfo.getEqList().split(",");
            String[] tempTimeStr = rsvInfo.getEqTime().split(",");
            rsvEqList = new String[tempStr.length];

            System.out.println(EqList.size());

            for(int i=0; i < tempStr.length; i++){
                //System.out.println(tempStr[i] + " : [tempStr]");
                for(int j=0; j < EqList.size(); j++){
                    if(tempStr[i].equals(String.valueOf(EqList.get(j).getCodeNo()))){
                        String codeNm = EqList.get(j).getCodeNm();

                        if(codeNm.contains("(")){
                            codeNm = codeNm.substring(0,codeNm.indexOf("("));
                        }

                        if(tempStr[i].equals("46") || tempStr[i].equals("47")){
                            rsvEqList[i] = "배경지 * " + tempTimeStr[i] + "개";
                        }else{
                            rsvEqList[i] = codeNm + "* " + tempTimeStr[i] + "시간";
                        }

                        System.out.println(rsvEqList[i]);
                    }
                }
            }
        }

        int t_day = Integer.parseInt(dateInfo.get("fullToday").toString().replace("-", ""));
        int r_day = Integer.parseInt(rsvInfo.getStr_date().replace("-",""));

        if(t_day < r_day){
            modelview.addObject("chgFlag", true);
        }else{
            modelview.addObject("chgFlag", false);
        }
        System.out.println("resultCode : " + resultCode);

        System.out.println(rsvInfo.getCmailyn() );

        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("param", paramMap);
        modelview.addObject("timeList", timeArr);
        modelview.addObject("dateInfo", dateInfo);
        modelview.addObject("rentInfo", rentInfo);
        modelview.addObject("timeInfo", timeInfo);
        modelview.addObject("rsvInfo", rsvInfo);
        modelview.addObject("rsvEqList", rsvEqList);
        modelview.addObject("resultCode", resultCode);
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }

    @RequestMapping(value = "/admin/rsv/rsvUpdate", method = RequestMethod.POST)
    public ModelAndView rsvUpdate(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/rsv/rsvUpdate");


        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        RentDTO rsvInfo = new RentDTO();
        List<RentDTO> rentInfo = new ArrayList<RentDTO>();
        Map<String, Object> paramMap = new HashMap<String, Object>();


        int paramSeqNo = Integer.parseInt(parameters.get("mstSeqNo"));
        int paramRentAmt = Integer.parseInt(parameters.get("rent_amount"));
        int paramOptAmt = Integer.parseInt(parameters.get("opt_price"));
        int paramUsrCnt = Integer.parseInt(parameters.get("usrCnt"));
        /*int paramCarCnt = Integer.parseInt(parameters.get("carCnt"));*/
        int paramRentNo = Integer.parseInt(parameters.get("rentNo"));
        int paramFrTime = Integer.parseInt(parameters.get("first_time"));
        int paramEtcAmt = 0;
        int paramDepoAmt = 0;
        int paramSaleAmt = 0;
        int paramEqAmt = 0;
        int paramAddAmt = 0;

        if(parameters.get("equipAmt") != null){
            paramEtcAmt = Integer.parseInt(parameters.get("equipAmt"));
        }

        if(parameters.get("depoAmt") != null){
            paramDepoAmt = Integer.parseInt(parameters.get("depoAmt"));
        }

        if(parameters.get("salesAmt") != null){
            paramSaleAmt = Integer.parseInt(parameters.get("salesAmt"));
        }

        if(parameters.get("addedAmt") != null){
            paramAddAmt = Integer.parseInt(parameters.get("addedAmt"));
        }

        if(parameters.get("sel_eq_amount") != null){
            paramEqAmt = Integer.parseInt(parameters.get("sel_eq_amount"));
        }

        String paramRsvDate = parameters.get("rsvDay");
        String paramTimes = parameters.get("times");
        String paramOption = parameters.get("rsvOption");                   // 예약 옵션
        String paramPreDeDate = parameters.get("preDepoDate");              // 선금 날짜
        String paramAllDeDate = parameters.get("allDepoDate");              // 선금 날짜
        String paramCancDeDate = parameters.get("cancDepoDate");            // 환급 날짜
        String paramRsvState = parameters.get("rsv_status");
        String paramEtcTxt = parameters.get("etcTxt");
        String paramRsvCont = parameters.get("rsvCont");
        String paramRsvNm = parameters.get("rsvNm");
        String paramDepoNm = parameters.get("depoNm");
        String paramCompNm = parameters.get("compNm");
        String paramPayType = parameters.get("payType");
        String paramEqList = parameters.get("sel_eq_list");
        String paramEqTime = parameters.get("sel_eq_time");
        String paramDepoYn = parameters.get("reDepoYn");
        String paramVatppYn = parameters.get("vatppYn");
        String paramVatDate = parameters.get("vatDate");



        int totalAmount = (paramRentAmt + paramOptAmt + paramEtcAmt + paramEqAmt + paramAddAmt) - paramSaleAmt;
        int totalvat = (int) (totalAmount * 0.10);
        // totalAmount = (int) (totalAmount + (totalAmount * 0.10));


        rsvInfo.setSeqNo(paramSeqNo);
        rsvInfo.setUsrNm(paramRsvNm);
        rsvInfo.setDepoNm(paramDepoNm);
        rsvInfo.setCompNm(paramCompNm);
        rsvInfo.setStr_date(paramRsvDate);
        rsvInfo.setRentAmt(paramRentAmt);
        rsvInfo.setUsrAmt(paramOptAmt);
        rsvInfo.setUsrcnt(paramUsrCnt);
        rsvInfo.setSaleAmt(paramSaleAmt);
        /*rsvInfo.setCarcnt(paramCarCnt);*/
        rsvInfo.setRentNo(paramRentNo);
        rsvInfo.setEtcAmt(paramEtcAmt);
        rsvInfo.setEqAmt(paramEqAmt);
        rsvInfo.setAddAmt(paramAddAmt);
        rsvInfo.setPredepo_amt(paramDepoAmt);
        rsvInfo.setTimes(paramTimes);
        rsvInfo.setRsv_opt(paramOption);
        rsvInfo.setPredepo_date(paramPreDeDate);
        rsvInfo.setPaymnt_date(paramAllDeDate);
        rsvInfo.setCancel_date(paramCancDeDate);
        rsvInfo.setStatus(paramRsvState);
        rsvInfo.setEtctxt(paramEtcTxt);
        rsvInfo.setRsv_cont(paramRsvCont);
        rsvInfo.setRsv_price(totalAmount);
        rsvInfo.setVat(totalvat);
        rsvInfo.setFrTime(paramFrTime);
        rsvInfo.setModeId(session.getAttribute("admUsrId").toString());
        rsvInfo.setPayType(paramPayType);
        rsvInfo.setEqList(paramEqList);
        rsvInfo.setEqTime(paramEqTime);
        rsvInfo.setReDepoYn(paramDepoYn);
        rsvInfo.setVatppYn(paramVatppYn);
        rsvInfo.setVatDate(paramVatDate);

        modelview.addObject("resultCode", "700");
        try{
            adminService.admRsvUpdate(rsvInfo);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
            modelview.addObject("resultCode", "000");
        }

        modelview.addObject("seq", paramSeqNo);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }


    @RequestMapping(value = "/admin/edit/rentEdit", method = RequestMethod.GET)
    public ModelAndView editRentA(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/edit/rentEdit");
        HttpSession session = request.getSession();
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        String mstSeqNo = parameters.get("seqNo");
        String[] img_path;
        String[] img_num;
        Map<String, Object> imgMap = new HashMap<String, Object>();
        List<Map<String, Object>> imgMapList = new ArrayList<Map<String, Object>>();
        List<RentDTO> optDTO = new ArrayList<RentDTO>();
        RentDTO rentDTO = new RentDTO();
        RentDTO results = new RentDTO();
        EquipDTO equipDTO = new EquipDTO();

        List<EquipDTO> equipDTOList = new ArrayList<EquipDTO>();

        if(mstSeqNo != null){
            rentDTO.setMstSeqNo(mstSeqNo);
            equipDTO.setRentNo(Integer.parseInt(mstSeqNo));

            try{

                results = adminService.getRentInfo(rentDTO);
                optDTO = adminService.admRentGetOpt(rentDTO);
                equipDTOList = adminService.getRentEquip(equipDTO);

                if(results.getOview_cont() != null){
                    results.setOview_cont(StringEscapeUtils.unescapeHtml3(results.getOview_cont()));
                }

                if(results.getPrice_cont() != null){
                    results.setPrice_cont(StringEscapeUtils.unescapeHtml3(results.getPrice_cont()));
                }

                if(results.getImages() != null){

                    if(results.getOview_img().indexOf(",") > 0){
                        img_path = results.getImages().split("\\^\\|\\|\\^");
                        img_num = results.getOview_img().split(",");

                        for(int i=0; i < img_num.length; i++){
                            imgMap = new HashMap<String, Object>();
                            imgMap.put("path", img_path[i]);
                            imgMap.put("num", img_num[i]);
                            logger.debug( i + " imgMap = " + imgMap);
                            imgMapList.add(imgMap);
                        }

                    }else{
                        imgMap.put("path", results.getImages());
                        imgMap.put("num", results.getOview_img());
                        imgMapList.add(imgMap);
                    }

                    modelview.addObject("imgMapList", imgMapList);
                }

                if(results.getEquip_images() != null){
                    img_path = results.getEquip_images().split("\\^\\|\\|\\^");
                    modelview.addObject("equipImages", img_path);
                }

                modelview.addObject("rentInfo", results);
            }catch (Exception e){
                System.out.println(e.getMessage().toString());
            }
        }

        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("equipInfo", equipDTOList);
        modelview.addObject("options", optDTO);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("curUrl", curUrl);
        modelview.addObject("curFullUrl", curUrl + "?" + curUrlParam);

        return modelview;
    }


    @RequestMapping(value = "/admin/edit/editNote", method = RequestMethod.GET)
    public ModelAndView editNote(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/edit/editNote");
        HttpSession session = request.getSession();

        String mstSeqNo = parameters.get("seqNo");
        String gubun = parameters.get("gubun");
        RentDTO rentDTO = new RentDTO();
        RentDTO results = new RentDTO();
        if(mstSeqNo != null){
            rentDTO.setMstSeqNo(mstSeqNo);
        }

        System.out.println("mstSeqNo : " + mstSeqNo);


        try{
            results = adminService.getRentInfo(rentDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        if("oview".equals(gubun)){
            modelview.addObject("rentCont", StringEscapeUtils.unescapeHtml3(results.getOview_cont()));
        }else if("rsv".equals(gubun)){
            modelview.addObject("rentCont", StringEscapeUtils.unescapeHtml3(results.getRsv_cont()));
        }else if("pri".equals(gubun)){
            modelview.addObject("rentCont", StringEscapeUtils.unescapeHtml3(results.getPrice_cont()));
        }else if("rule".equals(gubun)){
            modelview.addObject("rentCont", StringEscapeUtils.unescapeHtml3(results.getRules_cont()));
        }

        modelview.addObject("authCd", session.getAttribute("admAuthCd"));

        return modelview;
    }

    @RequestMapping(value = "/admin/edit/rentUpdate", method = RequestMethod.POST)
    public ModelAndView editRentA_Update(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam("fileUpload") List<MultipartFile> files,
                                         @RequestParam("floorUpload") MultipartFile floorFile){
        ModelAndView  modelview = new ModelAndView("/admin/edit/rentUpdate");
        HttpSession session = request.getSession();
        String curUrl = request.getServletPath();

        String oview_cont = String.valueOf(parameters.get("oview_cont"));
        String rsv_cont = String.valueOf(parameters.get("rsv_cont"));
        String price_cont = String.valueOf(parameters.get("price_cont"));
        String rules_cont = String.valueOf(parameters.get("rules_cont"));

        String mstSeqNo = parameters.get("mstSeqNo");
        String oview_img = String.valueOf(parameters.get("oview_img"));
        String floor_img = parameters.get("floor_img");
        String equip_img = String.valueOf(parameters.get("equip_img"));

        String vid_amount = parameters.get("vid_amount");
        String pic_amount = parameters.get("pic_amount");
        String def_usrCnt = parameters.get("def_usrCnt");
        String def_usrAmt = parameters.get("def_usrAmt");
        String def_times = parameters.get("def_times");
        String def_vid_usrCnt = parameters.get("def_usrCnt_video");
        String def_vid_price = parameters.get("def_usrAmt_video");


        String free_eq = String.valueOf(parameters.get("free_eq"));
        String pay_eq = String.valueOf(parameters.get("pay_eq"));

        if(free_eq != null && !"".equals(free_eq)){
            EquipDTO paramDTO = new EquipDTO();
            paramDTO.setType("FREE");
            paramDTO.setRentNo(Integer.parseInt(mstSeqNo));

            logger.debug("indexOf : " + free_eq.indexOf(","));
            logger.debug("free_eq : " + free_eq);
            if(free_eq.indexOf(",") > 0 ){
                String[] eq_01 ;
                List<EquipDTO> equipList = new ArrayList<EquipDTO>();
                EquipDTO equipDTO = new EquipDTO();
                eq_01 = free_eq.split(",");

                for(int i = 0; i < eq_01.length; i++){
                    logger.debug("eq_01[i] :::::::" + eq_01[i]);
                    equipDTO = new EquipDTO();
                    equipDTO.setEqNo(Integer.parseInt(eq_01[i]));
                    equipDTO.setRentNo(Integer.parseInt(mstSeqNo));
                    equipDTO.setType("FREE");
                    equipDTO.setRegId(String.valueOf(session.getAttribute("admUsrId")));
                    equipList.add(equipDTO);
                }

                try{
                    adminService.preDelEquipData(paramDTO);
                    adminService.setEquipDataList(equipList);
                }catch (Exception e){
                    logger.debug("equiptment Error " + e.getMessage().toString());
                }

            }else{
                EquipDTO equipDTO = new EquipDTO();
                equipDTO.setEqNo(Integer.parseInt(free_eq));
                equipDTO.setRentNo(Integer.parseInt(mstSeqNo));
                equipDTO.setType("FREE");
                equipDTO.setRegId(String.valueOf(session.getAttribute("admUsrId")));

                try{
                    adminService.preDelEquipData(paramDTO);
                    adminService.setEquipData(equipDTO);
                }catch (Exception e){
                    logger.debug("equiptment Error " + e.getMessage().toString());
                }
            }

        }

        if(pay_eq != null && !"".equals(pay_eq)){
            EquipDTO paramDTO = new EquipDTO();
            paramDTO.setType("PAY");
            paramDTO.setRentNo(Integer.parseInt(mstSeqNo));


            if(pay_eq.indexOf(",") > 0 ){
                String[] eq_02 ;
                List<EquipDTO> equipList = new ArrayList<EquipDTO>();
                eq_02 = pay_eq.split(",");
                EquipDTO equipDTO = new EquipDTO();


                for(int i = 0; i < eq_02.length; i++){
                    equipDTO = new EquipDTO();
                    equipDTO.setEqNo(Integer.parseInt(eq_02[i]));
                    equipDTO.setType("PAY");
                    equipDTO.setRentNo(Integer.parseInt(mstSeqNo));
                    equipDTO.setRegId(String.valueOf(session.getAttribute("admUsrId")));
                    equipList.add(equipDTO);
                }

                try{
                    adminService.preDelEquipData(paramDTO);
                    adminService.setEquipDataList(equipList);
                }catch (Exception e){
                    logger.debug("equiptment Error " + e.getMessage().toString());
                }

            }else{
                EquipDTO equipDTO = new EquipDTO();
                equipDTO.setEqNo(Integer.parseInt(pay_eq));
                equipDTO.setRentNo(Integer.parseInt(mstSeqNo));
                equipDTO.setType("PAY");
                equipDTO.setRegId(String.valueOf(session.getAttribute("admUsrId")));

                try{
                    adminService.preDelEquipData(paramDTO);
                    adminService.setEquipData(equipDTO);
                }catch (Exception e){
                    logger.debug("equiptment Error " + e.getMessage().toString());
                }
            }

        }

        String pre_img = "";

        RentDTO rentDTO = new RentDTO();
        Map<String, Object> results = new HashMap<String, Object>();

        rentDTO.setV_price(Integer.parseInt(vid_amount));
        rentDTO.setP_price(Integer.parseInt(pic_amount));
        rentDTO.setDefusrcnt(Integer.parseInt(def_usrCnt));
        rentDTO.setUsrAmt(Integer.parseInt(def_usrAmt));
        rentDTO.setDeftime(Integer.parseInt(def_times));

        rentDTO.setMstSeqNo(mstSeqNo);
        rentDTO.setOview_cont(oview_cont);
        rentDTO.setRsv_cont(rsv_cont);
        rentDTO.setPrice_cont(price_cont);
        rentDTO.setRules_cont(rules_cont);
        rentDTO.setEquip_img(equip_img);
        rentDTO.setVid_usrcnt(Integer.parseInt(def_vid_usrCnt));
        rentDTO.setVid_price(Integer.parseInt(def_vid_price));

        if(!floorFile.isEmpty()){
            rentDTO.setFloor_img(commonService.fileUpload(commonUtils.fileUpload(floorFile)));
        }else{
            rentDTO.setFloor_img(floor_img);
        }

        if(!files.get(0).isEmpty()) {
            if (files.size() == 1) {
                FileDTO fileDTO = new FileDTO();

                fileDTO = commonUtils.fileUpload(files.get(0));
                pre_img = commonService.fileUpload(fileDTO);

                if(oview_img != null){
                    rentDTO.setImages(oview_img + ',' + pre_img);
                }else{
                    rentDTO.setImages(pre_img);
                }

                //rentDTO.setPre_img(pre_img);

            } else if (files.size() > 1) {
                List<FileDTO> fileDTO = new ArrayList<FileDTO>();
                String[] img_arr;
                fileDTO = commonUtils.fileUpload(files);
                pre_img = commonService.fileUpload(fileDTO);

                img_arr = pre_img.split(",");

                if(oview_img != null){
                    rentDTO.setImages(oview_img + ',' + pre_img);
                }else{
                    rentDTO.setImages(pre_img);
                }
                // rentDTO.setPre_img(img_arr[0]);
            }
        }else{

            rentDTO.setImages(oview_img);
        }

        try{
            results = adminService.setRentUpdate(rentDTO);

        }catch (Exception e){
            logger.debug(e.getMessage().toString());
        }

        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("resultFlag", results.get("returnFlag"));
        modelview.addObject("resultMsg", results.get("returnMsg"));
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/edit/preImg", method = RequestMethod.POST)
    public Map<String, String> set_preImg(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        Map<String, String> rtrnMap = new HashMap<String, String>();

        RentDTO rentDTO = new RentDTO();
        String mstSeqNo = parameters.get("seq");
        String imgSeqNo = parameters.get("imgSeq");

        rentDTO.setMstSeqNo(mstSeqNo);
        rentDTO.setPre_img(imgSeqNo);

        try{
            adminService.setRentPreImg(rentDTO);
            rtrnMap.put("flag", "100");
        }catch (Exception e){
            logger.debug(e.getMessage().toString());
            rtrnMap.put("flag", "200");
        }
        return rtrnMap;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/edit/optAdd", method = RequestMethod.POST)
    public Map<String, String> optAdd(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        Map<String, String> rtrnMap = new HashMap<String, String>();
        RentDTO rentDTO = new RentDTO();

        String mstSeqNo = parameters.get("seq");
        String order = parameters.get("order");
        String opt_1 = parameters.get("opt1");
        String opt_2 = parameters.get("opt2");
        String opt_3 = parameters.get("opt3");

        int optno;

        rentDTO.setOp_order(Integer.parseInt(order));
        rentDTO.setOp_cont1(opt_1);
        rentDTO.setOp_cont2(opt_2);
        rentDTO.setOp_cont3(opt_3);
        rentDTO.setMstSeqNo(mstSeqNo);


        try{
            optno = adminService.admRentOptAdd(rentDTO);

            logger.debug("optno : " + optno);

            rtrnMap.put("flag", "100");
            rtrnMap.put("optno", String.valueOf(optno));
        }catch (Exception e){
            logger.debug(e.getMessage().toString());
            rtrnMap.put("flag", "200");
            rtrnMap.put("optno", null);
        }
        return rtrnMap;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/edit/optDel", method = RequestMethod.POST)
    public Map<String, String> optDel(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        Map<String, String> rtrnMap = new HashMap<String, String>();
        RentDTO rentDTO = new RentDTO();

        String mstSeqNo = parameters.get("seq");
        String optno = parameters.get("opt_seq");

        rentDTO.setOptno(Integer.parseInt(optno));
        rentDTO.setMstSeqNo(mstSeqNo);

        try{
            adminService.admRentOptDel(rentDTO);
            rtrnMap.put("flag", "100");
        }catch (Exception e){
            logger.debug(e.getMessage().toString());
            rtrnMap.put("flag", "200");
        }
        return rtrnMap;
    }


    @RequestMapping(value = "/admin/edit/test.jsp", method = RequestMethod.GET)
    public ModelAndView editTest(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/edit/test.jsp");
        HttpSession session = request.getSession();

        Map<String, Object> products = new HashMap<String, Object>();
        List<Map<String, Object>> prList = new ArrayList<Map<String,Object>>();

        products.put("prNm", "맥북");
        products.put("price", 1200000);
        products.put("seqNo", 1);

        prList.add(products);

        products = new HashMap<String, Object>();
        products.put("prNm", "윈도우");
        products.put("price", 1500000);
        products.put("seqNo", 2);

        prList.add(products);

        products = new HashMap<String, Object>();
        products.put("prNm", "데스크탑");
        products.put("price", 2500000);
        products.put("seqNo", 3);

        prList.add(products);

        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("prList", prList);

        return modelview;
    }

    @RequestMapping(value = "/admin/qnaList", method = RequestMethod.GET)
    public ModelAndView qnaList(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum, InquiryDTO inquiryDTO){
        ModelAndView  modelview = new ModelAndView("/admin/view/qnaList");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        List<InquiryDTO> list = null;
        String[] times = null;
        int[] timeInt = null;
        List<int[]> timeArr = new ArrayList<int[]>();
        Map<String, String> paramMap = new HashMap<String, String>();

        //pagingDTO.setPage(pageNum);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPaging(inquiryDTO);

        String paramUsrNm = parameters.get("name");
        String paramTitle = parameters.get("title");
        String paramPhone = parameters.get("phone");
        String paramEmail = parameters.get("email");
        String paramRegDate = parameters.get("regDate");

        paramMap.put("name", paramUsrNm);
        paramMap.put("title", paramTitle);
        paramMap.put("phone", paramPhone);
        paramMap.put("email", paramEmail);
        paramMap.put("regDate", paramRegDate);

        inquiryDTO.setName(paramUsrNm);
        inquiryDTO.setTitle(paramTitle);
        inquiryDTO.setEmail(paramEmail);
        inquiryDTO.setPhone(paramPhone);
        inquiryDTO.setRegDate(paramRegDate);

        try{
            pageMaker.setTotalCount(adminService.admQnaListCnt(inquiryDTO));
            list = adminService.admQnaList(inquiryDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("curPage", pageNum);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("param", paramMap);
        modelview.addObject("qnaList", list);
        modelview.addObject("qnaListCnt", list.size());
        modelview.addObject("curUrl", curUrl);
        modelview.addObject("pageMaker", pageMaker);

        return modelview;
    }


    @RequestMapping(value = "/admin/qnaInfo", method = RequestMethod.GET)
    public ModelAndView qnaInfo(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum, InquiryDTO inquiryDTO){
        ModelAndView  modelview = new ModelAndView("/admin/view/qnaInfo");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        InquiryDTO qnaInfo = null;
        List<int[]> timeArr = new ArrayList<int[]>();
        Map<String, Object> paramMap = new HashMap<String, Object>();

        String paramResultCd = (String) parameters.get("resultCode");
        int paramSeqNo = Integer.parseInt(parameters.get("seq"));

        paramMap.put("seqNo", paramSeqNo);

        inquiryDTO.setSeqNo(paramSeqNo);

        try{
            qnaInfo = adminService.admQnaInfo(inquiryDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("param", paramMap);
        modelview.addObject("timeList", timeArr);
        modelview.addObject("qnaInfo", qnaInfo);
        modelview.addObject("curUrl", curUrl);
        modelview.addObject("resultCode", paramResultCd);

        return modelview;
    }

    @RequestMapping(value = "/admin/qnaProc", method = RequestMethod.POST)
    public ModelAndView qnaProc(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum, InquiryDTO inquiryDTO){
        ModelAndView  modelview = new ModelAndView("redirect:/admin/qnaInfo");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        InquiryDTO qnaInfo = null;
        List<int[]> timeArr = new ArrayList<int[]>();
        Map<String, Object> paramMap = new HashMap<String, Object>();

        int paramSeqNo = Integer.parseInt(parameters.get("mstSeqNo"));
        String paramTitle = parameters.get("qnaTitle");
        String paramAnsTxt = parameters.get("ansTxt");
        String paramUsrNm = parameters.get("usrNm");
        String paramEmail = parameters.get("toEmail");

        paramMap.put("seqNo", paramSeqNo);
        paramMap.put("usrNm", paramUsrNm);
        paramMap.put("ansMsg", paramAnsTxt);
        paramMap.put("title", paramTitle);
        paramMap.put("toEmail", paramEmail);

        inquiryDTO.setSeqNo(paramSeqNo);
        inquiryDTO.setAnsMsg(paramAnsTxt);
        inquiryDTO.setAnsRegId(session.getAttribute("admUsrId").toString());

        try{
            adminService.admQnaAnswer(inquiryDTO);
            qnaInfo = adminService.admQnaInfo(inquiryDTO);

            paramMap.put("usrNm", qnaInfo.getName());
            paramMap.put("toEmail", qnaInfo.getEmail());

            commonUtils.sendMail("qna", paramMap);
            modelview.addObject("resultCode", "007"); // 답변 성공
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
            modelview.addObject("resultCode", "000"); // 답변 실패
        }

        modelview.addObject("seq", paramSeqNo);
        modelview.addObject("param", paramMap);

        return modelview;
    }

    @RequestMapping(value = "/qna/delete", method = RequestMethod.POST)
    public Map<String, String> qnaDelete(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/rental/qnaDelete");
        HttpSession session = request.getSession();
        Map<String, Object> dateInfo = new HashMap<String, Object>();
        String[] times = null;
        int[] timeInt = null;

        Map<String, String> resultMap = new HashMap<String, String>();
        InquiryDTO paramDTO = new InquiryDTO();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        String paramSeqNo = (String) parameters.get("seqNo");
        resultMap.put("resultCode", "100");

        paramDTO.setSeqNo(Integer.parseInt(paramSeqNo));

        try{
            adminService.admQnaDelete(paramDTO);
            resultMap.put("resultCode", "300");
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("isMobile", commonUtils.isMobile(request));
        modelview.addObject("reTimes", timeInt);

        return resultMap;
    }

    @RequestMapping(value = "/admin/mainManage", method = RequestMethod.GET)
    public ModelAndView mainManage(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/edit/mainManage");
        String curUrl = request.getServletPath();
        HttpSession session = request.getSession();
        RentDTO mainInfo = new RentDTO();
        String[] img_path;
        String[] img_num;
        Map<String, Object> imgMap = new HashMap<String, Object>();
        List<Map<String, Object>> imgMapList = new ArrayList<Map<String, Object>>();

        try{
            mainInfo = adminService.getMainImg();

            if(mainInfo.getImages() != null){

                if(mainInfo.getMainImg().indexOf(",") > 0){
                    img_path = mainInfo.getImages().split("\\^\\|\\|\\^");
                    img_num = mainInfo.getMainImg().split(",");

                    for(int i=0; i < img_num.length; i++){
                        imgMap = new HashMap<String, Object>();
                        imgMap.put("path", img_path[i]);
                        imgMap.put("num", img_num[i]);
                        logger.debug( i + " imgMap = " + imgMap);
                        imgMapList.add(imgMap);
                    }

                }else{
                    imgMap.put("path", mainInfo.getImages());
                    imgMap.put("num", mainInfo.getMainImg()) ;
                    imgMapList.add(imgMap);
                }

                modelview.addObject("imgMapList", imgMapList);
            }

        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("mainInfo", mainInfo);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }

    @RequestMapping(value = "/admin/edit/mainImgProc", method = RequestMethod.POST)
    public ModelAndView mainImgProc(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam("fileUpload") List<MultipartFile> files){
        ModelAndView  modelview = new ModelAndView("/admin/edit/rentUpdate");
        HttpSession session = request.getSession();
        String curUrl = request.getServletPath();

        String oview_img = String.valueOf(parameters.get("oview_img"));
        String pre_img = "";

        logger.debug("oview_img ::: " + oview_img);

        RentDTO rentDTO = new RentDTO();
        Map<String, String> results = new HashMap<String, String>();

        if(!files.get(0).isEmpty()) {
            if (files.size() == 1) {
                FileDTO fileDTO = new FileDTO();

                fileDTO = commonUtils.fileUpload(files.get(0));
                pre_img = commonService.fileUpload(fileDTO);

                if(oview_img != null){
                    rentDTO.setImages(oview_img + ',' + pre_img);
                }else{
                    rentDTO.setImages(pre_img);
                }

                //rentDTO.setPre_img(pre_img);

            } else if (files.size() > 1) {
                List<FileDTO> fileDTO = new ArrayList<FileDTO>();
                String[] img_arr;
                fileDTO = commonUtils.fileUpload(files);
                pre_img = commonService.fileUpload(fileDTO);

                img_arr = pre_img.split(",");

                if(oview_img != null){
                    rentDTO.setImages(oview_img + ',' + pre_img);
                }else{
                    rentDTO.setImages(pre_img);
                }
            }
        }else{
            rentDTO.setImages(oview_img);
        }

        try{
            adminService.setMainImg(rentDTO);
            modelview.addObject("resultFlag", "100");
            modelview.addObject("resultMsg", "이미지 수정이 완료되었습니다.");
        }catch (Exception e){
            logger.debug(e.getMessage().toString());
            modelview.addObject("resultFlag", "7");
            modelview.addObject("resultMsg", "오류가 발생하였습니다. 관리자에게 문의해주세요.");
        }

        modelview.addObject("results", results);

        return modelview;
    }


    @RequestMapping(value = "/admin/getEquipImg", method = RequestMethod.GET)
    public ModelAndView getEquipImg(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/edit/equipImg_Manage");
        String curUrl = request.getServletPath();
        HttpSession session = request.getSession();
        List<EquipDTO> equipDTO = new ArrayList<EquipDTO>();

        String images = String.valueOf(parameters.get("bef"));

        try{
            equipDTO = adminService.admRentGetOpt();

        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        if(images != null){
            modelview.addObject("bef", images);
            String[] befImg = images.split(",");

            for(int i=0; i < equipDTO.size(); i++){
                if(Arrays.asList(befImg).contains(String.valueOf(equipDTO.get(i).getAttachNo()))){
                    equipDTO.get(i).setChecked(true);
                }

                logger.debug("checked : " + equipDTO.get(i).isChecked() );
            }
        }

        modelview.addObject("equipInfo", equipDTO);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }


    @RequestMapping(value = "/admin/equipAdd", method = RequestMethod.POST)
    public Map<String, String> equipAdd(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam("fileUpload") List<MultipartFile> files){
        HttpSession session = request.getSession();
        String curUrl = request.getServletPath();

        String images = String.valueOf(parameters.get("bef"));
        String pre_img = "";

        logger.debug("images ::: " + images);

        Map<String, String> results = new HashMap<String, String>();

        if(!files.get(0).isEmpty()) {
            if (files.size() == 1) {
                FileDTO fileDTO = new FileDTO();
                EquipDTO equipDTO = new EquipDTO();

                fileDTO = commonUtils.fileUpload(files.get(0));
                pre_img = commonService.fileUpload(fileDTO);

                equipDTO.setAttachNo(Integer.parseInt(pre_img));
                equipDTO.setRegId(String.valueOf(session.getAttribute("admUsrId")));

                try{
                    adminService.addEquipImg(equipDTO);
                    results.put("flag", "100");
                    results.put("msg", "이미지 수정이 완료되었습니다.");
                }catch (Exception e){
                    logger.debug(e.getMessage().toString());
                    results.put("flag", "7");
                    results.put("msg", "오류가 발생하였습니다. 관리자에게 문의해주세요.");
                }

            } else if (files.size() > 1) {
                List<FileDTO> fileDTO = new ArrayList<FileDTO>();
                List<EquipDTO> equipList = new ArrayList<EquipDTO>();
                EquipDTO equipDTO;

                String[] img_arr;
                fileDTO = commonUtils.fileUpload(files);
                pre_img = commonService.fileUpload(fileDTO);

                img_arr = pre_img.split(",");

                for(int i=0; i < img_arr.length; i++){
                    equipDTO = new EquipDTO();
                    equipDTO.setAttachNo(Integer.parseInt(img_arr[i]));
                    equipDTO.setRegId(String.valueOf(session.getAttribute("admUsrId")));
                    equipList.add(equipDTO);
                }

                try{
                    adminService.addEquipImg(equipList);
                    results.put("flag", "100");
                    results.put("msg", "이미지 수정이 완료되었습니다.");
                }catch (Exception e){
                    logger.debug(e.getMessage().toString());
                    results.put("flag", "7");
                    results.put("msg", "오류가 발생하였습니다. 관리자에게 문의해주세요.");
                }

            }

        }

        return results;
    }


    @RequestMapping(value = "/admin/delEquipImg", method = RequestMethod.POST)
    public Map<String, String> delEquipImg(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        HttpSession session = request.getSession();
        String curUrl = request.getServletPath();
        Map<String, String> results = new HashMap<String, String>();

        if(parameters.get("imgNo") != null){
            EquipDTO equipDTO = new EquipDTO();
            equipDTO.setSeqNo(Integer.parseInt(parameters.get("imgNo")));

            try {
                adminService.delEquipImg(equipDTO);
                results.put("flag", "100");
            }catch (Exception e){
                logger.debug("delEquipImg Error ");
                logger.debug(e.getMessage().toString());
                results.put("flag", "200");
            }
        }


        return results;
    }


    @RequestMapping(value = "/admin/getEquipList", method = RequestMethod.GET)
    public ModelAndView getEquipList(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        ModelAndView  modelview = new ModelAndView("/admin/edit/equipList_Manage");
        String curUrl = request.getServletPath();
        HttpSession session = request.getSession();
        List<EquipDTO> equipDTO = new ArrayList<EquipDTO>();
        EquipDTO paramDTO = new EquipDTO();

        String images = String.valueOf(parameters.get("bef"));

        if(parameters.get("eqMode") != null){
            paramDTO.setType(String.valueOf(parameters.get("eqMode")));
            modelview.addObject("eqMode", String.valueOf(parameters.get("eqMode")));
        }

        try{
            equipDTO = adminService.getEquipList(paramDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("equipInfo", equipDTO);
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }


    @RequestMapping(value = "/admin/equipListAdd", method = RequestMethod.POST)
    public Map<String, String> equipListAdd(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        HttpSession session = request.getSession();
        String curUrl = request.getServletPath();
        Map<String, String> results = new HashMap<String, String>();

        if(parameters.get("eqNm") != null){
            EquipDTO equipDTO = new EquipDTO();
            equipDTO.setEqNm(String.valueOf(parameters.get("eqNm")));
            equipDTO.setType(String.valueOf(parameters.get("eqMode")));
            equipDTO.setRegId(String.valueOf(session.getAttribute("admUsrId")));

            try{
                adminService.addEquipList(equipDTO);
                results.put("flag", "100");
            }catch (Exception e){
                logger.debug("equipListAdd Error ");
                logger.debug(e.getMessage().toString());
                results.put("flag", "200");
            }

        }

        return results;
    }

    @RequestMapping(value = "/admin/equipListDel", method = RequestMethod.POST)
    public Map<String, String> equipListDel(@RequestParam Map<String, String> parameters, HttpServletRequest request){
        HttpSession session = request.getSession();
        String curUrl = request.getServletPath();
        Map<String, String> results = new HashMap<String, String>();

        if(parameters.get("eqNo") != null){
            EquipDTO equipDTO = new EquipDTO();
            equipDTO.setEqNo(Integer.parseInt(parameters.get("eqNo")));

            try{
                adminService.delEquipList(equipDTO);
                results.put("flag", "100");
            }catch (Exception e){
                logger.debug("equipListAdd Error ");
                logger.debug(e.getMessage().toString());
                results.put("flag", "200");
            }

        }

        return results;
    }


    @RequestMapping(value = "/admin/mngList", method = RequestMethod.GET)
    public ModelAndView mngList(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum, AdminDTO adminDTO){
        ModelAndView  modelview = new ModelAndView("/admin/view/mngList");
        String curUrl = request.getServletPath();
        String curUrlParam = request.getQueryString();
        HttpSession session = request.getSession();
        List<AdminDTO> list = null;
        String[] times = null;
        int[] timeInt = null;
        List<int[]> timeArr = new ArrayList<int[]>();
        Map<String, String> paramMap = new HashMap<String, String>();

        //pagingDTO.setPage(pageNum);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPaging(adminDTO);

        try{
            pageMaker.setTotalCount(adminService.admMngListCnt(adminDTO));
            list = adminService.admMngList(adminDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("curPage", pageNum);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("param", paramMap);
        modelview.addObject("mngList", list);
        modelview.addObject("mngListCnt", list.size());
        modelview.addObject("curUrl", curUrl);
        modelview.addObject("pageMaker", pageMaker);

        return modelview;
    }

    @RequestMapping(value = "/admin/admFailReset", method = RequestMethod.GET)
    public Map<String, Object> admFailReset(@RequestParam Map<String, String> parameters, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int pageNum){
        ModelAndView  modelview = new ModelAndView("/admin/view/mngList");
        String curUrl = request.getServletPath();
        HttpSession session = request.getSession();
        Map<String, String> paramMap = new HashMap<String, String>();
        AdminDTO adminDTO = new AdminDTO();
        Map<String, Object> retrnMap = new HashMap<String, Object>();

        String userId = parameters.get("target");

        adminDTO.setUsrId(userId);

        try{
            adminService.admFailReset(adminDTO);
            retrnMap.put("flag", "100");
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
            retrnMap.put("flag", "200");
        }

        modelview.addObject("curPage", pageNum);
        modelview.addObject("adminId", session.getAttribute("admUsrId"));
        modelview.addObject("authCd", session.getAttribute("admAuthCd"));
        modelview.addObject("param", paramMap);
        modelview.addObject("curUrl", curUrl);

        return retrnMap;
    }


    @RequestMapping(value = "/admin/rsv/grpExcelDown", method = RequestMethod.POST)
    public ModelAndView grpExcelDown(@RequestParam Map<String, String> parameters, HttpServletRequest request, RentDTO pagingDTO){
        ModelAndView  modelview = new ModelAndView("/admin/rsv/rsvDataExDown");
        String curUrl = request.getServletPath();
        HttpSession session = request.getSession();
        List<RentDTO> list = null;

        try{
            list = adminService.admRsvGrpExcelList(pagingDTO);
        }catch (Exception e){
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("rsvList", list);
        modelview.addObject("curUrl", curUrl);

        return modelview;
    }


}
