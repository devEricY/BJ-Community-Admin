package com.bjcommunity.admin.Controller;

import com.bjcommunity.admin.Dto.AdminDTO;
import com.bjcommunity.admin.Dto.CommonDTO;
import com.bjcommunity.admin.Dto.MemberDTO;
import com.bjcommunity.admin.Service.AdminService;
import com.bjcommunity.admin.Service.CommonService;
import com.bjcommunity.admin.Service.MemberService;
import com.bjcommunity.admin.utils.CommonUtils;
import com.bjcommunity.admin.utils.PageMaker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value = "/member")
public class MemberController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    MemberService memberService;

    @Autowired
    CommonService commonService;

    @Autowired
    CommonUtils commonUtils;
    CommonDTO commonDTO;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView main(@RequestParam Map<String, String> parameters, HttpServletRequest request,
                             @RequestParam(value = "page", defaultValue = "1") int pageNum, MemberDTO pagingDTO){
        ModelAndView  modelview = new ModelAndView("/view/mbList");
        HttpSession session = request.getSession();

        List<MemberDTO> mbList = new ArrayList<MemberDTO>();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPaging(pagingDTO);

        try {
            pageMaker.setTotalCount(memberService.get_member_listCnt(pagingDTO));
            mbList = memberService.get_member_list(pagingDTO);
        } catch (Exception e) {
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("admin_auth", session.getAttribute("admin_auth"));
        modelview.addObject("admin_id", session.getAttribute("admin_id"));
        modelview.addObject("mbList", mbList);
        modelview.addObject("mbListCnt", pageMaker.getTotalCount());
        modelview.addObject("pageMaker", pageMaker);
        modelview.addObject("curPage", pageNum);
        modelview.addObject("path", commonUtils.serverPath(request));
        modelview.addObject("isMobile", commonUtils.isMobile(request));

        return modelview;
    }

}
