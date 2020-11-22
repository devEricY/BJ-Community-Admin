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

    public Map<String, Object> setRentUpdate(RentDTO rentDTO){
        Map<String, Object> results = new HashMap<String, Object>();

        try{
            adminMapper.setRentUpdate(rentDTO);
            adminMapper.rentMstUpdate(rentDTO);

            /*adminMapper.reSetOption(rentDTO);
            adminMapper.setOption(rentDTO);*/

            results.put("returnFlag", 7);
            results.put("returnMsg", "수정이 완료되었습니다.");

        }catch (Exception e){
            System.out.println(e.getMessage().toString());
            results.put("returnFlag", 1);
            results.put("returnMsg", "업데이트 중 오류가 발생하였습니다. 관리자에게 문의해주세요");
        }

        return results;

    }

    public void setRentPreImg(RentDTO rentDTO){ adminMapper.setRentPreImg(rentDTO); }

    public RentDTO getRentInfo(RentDTO rentDTO){
        return adminMapper.getRentInfo(rentDTO);
    }

    public List<RentDTO> admRsvList(PagingDTO pagingDTO){ return adminMapper.admRsvList(pagingDTO); }

    public List<RentDTO> admRsvExcelList(RentDTO rentDTO){ return adminMapper.admRsvExcelList(rentDTO); }

    public List<RentDTO> admRsvGrpExcelList(RentDTO rentDTO){ return adminMapper.admRsvGrpExcelList(rentDTO); }

    public int admRsvListCnt(PagingDTO pagingDTO){ return adminMapper.admRsvListCnt(pagingDTO); }

    public List<InquiryDTO> admQnaList(InquiryDTO inquiryDTO){ return adminMapper.admQnaList(inquiryDTO); }

    public int admQnaListCnt(InquiryDTO inquiryDTO){ return adminMapper.admQnaListCnt(inquiryDTO); }

    public AdminDTO getDashBoard(){
        return adminMapper.getDashBoard();
    }

    public RentDTO getRsvInfo(RentDTO rentDTO){
        return adminMapper.getRsvInfo(rentDTO);
    }

    public InquiryDTO admQnaInfo(InquiryDTO inquiryDTO){ return adminMapper.admQnaInfo(inquiryDTO); }

    public void admQnaAnswer(InquiryDTO inquiryDTO){ adminMapper.admQnaAnswer(inquiryDTO); }

    public void admQnaDelete(InquiryDTO inquiryDTO){ adminMapper.admQnaDelete(inquiryDTO); }

    public List<AdminDTO> getDashMonth(AdminDTO adminDTO){
        return adminMapper.getDashMonth(adminDTO);
    }

    public void admRsvUpdate(RentDTO rentDTO){
        adminMapper.admRsvUpdate(rentDTO);
    }

    public int admRentOptAdd(RentDTO rentDTO){
        return adminMapper.admRentOptAdd(rentDTO);
    }

    public void admRentOptDel(RentDTO rentDTO){
        adminMapper.admRentOptDel(rentDTO);
    }

    public List<RentDTO> admRentGetOpt(RentDTO rentDTO){
        return adminMapper.admRentGetOpt(rentDTO);
    }

    public RentDTO getMainImg(){
        return adminMapper.getMainImg();
    }

    public void setMainImg(RentDTO rentDTO){
        adminMapper.setMainImg(rentDTO);
    }

    public void addEquipImg(EquipDTO equipDTO){
        adminMapper.addEquipImg(equipDTO);
    };

    public void addEquipImg(List<EquipDTO> equipDTO){
        adminMapper.addEquipImg(equipDTO);
    };

    public List<EquipDTO> admRentGetOpt(){
        return adminMapper.getEquipImg();
    }

    public void delEquipImg(EquipDTO equipDTO){
        adminMapper.delEquipImg(equipDTO);
    }

    public void addEquipList(EquipDTO equipDTO){
        adminMapper.addEquipList(equipDTO);
    }

    public List<EquipDTO> getEquipList(EquipDTO equipDTO){
        return adminMapper.getEquipList(equipDTO);
    }

    public void delEquipList(EquipDTO equipDTO){
        adminMapper.delEquipList(equipDTO);
    }

    public void setEquipData(EquipDTO equipDTO){
        adminMapper.setEquipData(equipDTO);
    }

    public void setEquipDataList(List<EquipDTO> equipDTO){
        adminMapper.setEquipDataList(equipDTO);
    }

    public void preDelEquipData(EquipDTO equipDTO){
        adminMapper.preDelEquipData(equipDTO);
    }

    public List<EquipDTO> getRentEquip(EquipDTO equipDTO){
        return adminMapper.getRentEquip(equipDTO);
    }

    public List<AdminDTO> admMngList(AdminDTO adminDTO){ return adminMapper.admMngList(adminDTO); }

    public int admMngListCnt(AdminDTO adminDTO){ return adminMapper.admMngListCnt(adminDTO); }

    public void admFailReset(AdminDTO adminDTO){
        adminMapper.admFailReset(adminDTO);
    }
}
