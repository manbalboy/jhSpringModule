package com.demo1.biz.member.contoller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.demo1.biz.code.service.CommonDetailCodeService;
import com.demo1.biz.code.vo.CommonDetailCodeVO;
import com.demo1.biz.member.service.MemberManagementService;
import com.demo1.biz.member.vo.MemberManagementVO;

/**
 * 회원관리 컨트롤러
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : MemberManagementContoller.java
 * 2. 작성일 : 2020. 6. 12.
 * 3. 작성자 : 정훈
 * 4. 설명 : 회원관리 컨트롤러
 * </pre>
 */
@Controller
@RequestMapping("/member/management")
public class MemberManagementContoller {


    @Resource(name = "memberManagementServiceImpl")
    private MemberManagementService memberManagementService;


    @Resource(name = "commonDetailCodeServiceImpl")
    private CommonDetailCodeService commonDetailCodeService;

    /**
     * <pre>
     * 1. 메소드명 : viewMemberList
     * 2. 작성일 : 2020. 6. 13. 오전 12:51:50
     * 3. 작성자 : 정훈
     * 4. 설명 : 멤버리스트 조회
     * </pre>
     * @param memberManagementVO
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewMemberList")
    public String viewMemberList(@ModelAttribute MemberManagementVO memberManagementVO,BindingResult bindingResult ,Model model) throws Exception {
        if(bindingResult.hasErrors()) {
            System.out.println("<><<<<<<<<<<<<<<<<<<<>>>>>>>>>>");
        }

        List<MemberManagementVO> list =  memberManagementService.selectMemberList(memberManagementVO);
        model.addAttribute("memberList", list);

        /* 회원상태 코드 */
        CommonDetailCodeVO commonDetailCodeVO = new CommonDetailCodeVO();
        commonDetailCodeVO.setCodeId("MEM001");
        List<CommonDetailCodeVO> listMEM001 = commonDetailCodeService.selectCommonDetailCodeList(commonDetailCodeVO);
        model.addAttribute("listMEM001", listMEM001);

        model.addAttribute("searchInfo", memberManagementVO);
        return "demo1.biz.member.memberList";
    }

    /**
     * <pre>
     * 1. 메소드명 : viewMemberList
     * 2. 작성일 : 2020. 6. 13. 오전 12:51:50
     * 3. 작성자 : 정훈
     * 4. 설명 : 멤버리스트 조회
     * </pre>
     * @param memberManagementVO
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewMemberList2")
    @ResponseBody
    public Map viewMemberList2(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
        Map map = new HashMap();
        map.put("test", "test");

        List list = new ArrayList();


        list.add("test");
        list.add("test1");
        list.add("test12");

        map.put("list",list);




        return map;
    }

    /**
     * <pre>
     * 1. 메소드명 : deleteMemberList
     * 2. 작성일 : 2020. 6. 13. 오전 12:52:27
     * 3. 작성자 : 정훈
     * 4. 설명 : 멤버리스트 삭제
     * </pre>
     * @param checkedIdForDel
     * @param memberManagementVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteMemberList")
    public String deleteMemberList(@RequestParam("checkedIdForDel") String  checkedIdForDel, @ModelAttribute MemberManagementVO memberManagementVO,Model model) throws Exception {

        model.addAttribute("searchInfo", memberManagementVO);

        memberManagementService.deleteMemberList(checkedIdForDel);
        model.addAttribute("resultMsg", "삭제 성공");
        return "forward:/member/management/viewMemberList";
    }


    /**
     * <pre>
     * 1. 메소드명 : viewInsertMember
     * 2. 작성일 : 2020. 6. 13. 오전 1:49:42
     * 3. 작성자 : 정훈
     * 4. 설명 : 등록 뷰 호출
     * </pre>
     * @param checkedIdForDel
     * @param memberManagementVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewInsertMember")
    public String viewInsertMember(Model model) throws Exception {
        CommonDetailCodeVO commonDetailCodeVO = new CommonDetailCodeVO();
        /* 비밀번호 힌트 */
        commonDetailCodeVO.setCodeId("MEM002");
        List<CommonDetailCodeVO> listMEM002 = commonDetailCodeService.selectCommonDetailCodeList(commonDetailCodeVO);
        model.addAttribute("listMEM002", listMEM002);

        /* 회원상태 코드 */
        commonDetailCodeVO.setCodeId("MEM001");
        List<CommonDetailCodeVO> listMEM001 = commonDetailCodeService.selectCommonDetailCodeList(commonDetailCodeVO);
        model.addAttribute("listMEM001", listMEM001);

        /* 성별 코드 */
        commonDetailCodeVO.setCodeId("MEM003");
        List<CommonDetailCodeVO> listMEM003 = commonDetailCodeService.selectCommonDetailCodeList(commonDetailCodeVO);
        model.addAttribute("listMEM003", listMEM003);

        return "demo1.biz.member.insertMember";

    }
}
