package com.bjcommunity.admin.Controller;

import com.bjcommunity.admin.Dto.BoardDTO;
import com.bjcommunity.admin.Dto.CommonDTO;
import com.bjcommunity.admin.Dto.MemberDTO;
import com.bjcommunity.admin.Service.AdminService;
import com.bjcommunity.admin.Service.BoardService;
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
public class BoardController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    CommonService commonService;

    @Autowired
    BoardService boardService;

    @Autowired
    CommonUtils commonUtils;
    CommonDTO commonDTO;


    @RequestMapping(value = "/board/list", method = RequestMethod.GET)
    public ModelAndView boardList(@RequestParam Map<String, String> parameters, HttpServletRequest request,
                             @RequestParam(value = "page", defaultValue = "1") int pageNum, @RequestParam(value = "class_seq", defaultValue = "1") int class_seq, BoardDTO pagingDTO){
        ModelAndView  modelview = new ModelAndView("/view/bdList");
        HttpSession session = request.getSession();

        List<BoardDTO> bdList = new ArrayList<BoardDTO>();
        pagingDTO.setBoard_class_seq(class_seq);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPaging(pagingDTO);

        try {
            pageMaker.setTotalCount(boardService.get_board_listCnt(pagingDTO));
            bdList = boardService.get_board_list(pagingDTO);
        } catch (Exception e) {
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("admin_auth", session.getAttribute("admin_auth"));
        modelview.addObject("admin_id", session.getAttribute("admin_id"));
        modelview.addObject("bdList", bdList);
        modelview.addObject("bdListCnt", pageMaker.getTotalCount());
        modelview.addObject("pageMaker", pageMaker);
        modelview.addObject("curPage", pageNum);
        modelview.addObject("class_seq", class_seq);
        modelview.addObject("path", commonUtils.serverPath(request));
        modelview.addObject("isMobile", commonUtils.isMobile(request));

        return modelview;
    }


    @RequestMapping(value = "/inquiry/list", method = RequestMethod.GET)
    public ModelAndView inquryList(@RequestParam Map<String, String> parameters, HttpServletRequest request,
                             @RequestParam(value = "page", defaultValue = "1") int pageNum, @RequestParam(value = "class_seq", defaultValue = "1") int class_seq, BoardDTO pagingDTO){
        ModelAndView  modelview = new ModelAndView("/view/bdList");
        HttpSession session = request.getSession();

        List<BoardDTO> bdList = new ArrayList<BoardDTO>();
        pagingDTO.setBoard_class_seq(class_seq);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPaging(pagingDTO);

        try {
            pageMaker.setTotalCount(boardService.get_board_listCnt(pagingDTO));
            bdList = boardService.get_board_list(pagingDTO);
        } catch (Exception e) {
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("admin_auth", session.getAttribute("admin_auth"));
        modelview.addObject("admin_id", session.getAttribute("admin_id"));
        modelview.addObject("bdList", bdList);
        modelview.addObject("bdListCnt", pageMaker.getTotalCount());
        modelview.addObject("pageMaker", pageMaker);
        modelview.addObject("curPage", pageNum);
        modelview.addObject("class_seq", class_seq);
        modelview.addObject("path", commonUtils.serverPath(request));
        modelview.addObject("isMobile", commonUtils.isMobile(request));

        return modelview;
    }

    @RequestMapping(value = "/notice/list", method = RequestMethod.GET)
    public ModelAndView noticeList(@RequestParam Map<String, String> parameters, HttpServletRequest request,
                                   @RequestParam(value = "page", defaultValue = "1") int pageNum, @RequestParam(value = "class_seq", defaultValue = "1") int class_seq, BoardDTO pagingDTO){
        ModelAndView  modelview = new ModelAndView("/view/bdList");
        HttpSession session = request.getSession();

        List<BoardDTO> bdList = new ArrayList<BoardDTO>();
        pagingDTO.setBoard_class_seq(class_seq);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPaging(pagingDTO);

        try {
            pageMaker.setTotalCount(boardService.get_board_listCnt(pagingDTO));
            bdList = boardService.get_board_list(pagingDTO);
        } catch (Exception e) {
            System.out.println(e.getMessage().toString());
        }

        modelview.addObject("admin_auth", session.getAttribute("admin_auth"));
        modelview.addObject("admin_id", session.getAttribute("admin_id"));
        modelview.addObject("bdList", bdList);
        modelview.addObject("bdListCnt", pageMaker.getTotalCount());
        modelview.addObject("pageMaker", pageMaker);
        modelview.addObject("curPage", pageNum);
        modelview.addObject("class_seq", class_seq);
        modelview.addObject("path", commonUtils.serverPath(request));
        modelview.addObject("isMobile", commonUtils.isMobile(request));

        return modelview;
    }
}
