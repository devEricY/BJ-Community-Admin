package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.*;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface AdminService {
    public Map<String, Object> loginProcess(AdminDTO adminDTO) throws Exception;

    public Map<String, Object> setRentUpdate(RentDTO rentDTO) throws Exception;

    public void setRentPreImg(RentDTO rentDTO) throws Exception;

    public RentDTO getRentInfo(RentDTO rentDTO) throws Exception;

    public List<RentDTO> admRsvList(PagingDTO pagingDTO) throws Exception;

    public List<RentDTO> admRsvExcelList(RentDTO rentDTO) throws Exception;

    public List<RentDTO> admRsvGrpExcelList(RentDTO rentDTO) throws Exception;

    public int admRsvListCnt(PagingDTO pagingDTO) throws Exception;

    public AdminDTO getDashBoard() throws Exception;

    public List<InquiryDTO> admQnaList(InquiryDTO inquiryDTO) throws Exception;

    public int admQnaListCnt(InquiryDTO inquiryDTO) throws Exception;

    public RentDTO getRsvInfo(RentDTO rentDTO) throws Exception;

    public InquiryDTO admQnaInfo(InquiryDTO inquiryDTO) throws Exception;

    public void admQnaAnswer(InquiryDTO inquiryDTO) throws Exception;

    public void admQnaDelete(InquiryDTO inquiryDTO) throws Exception;

    public List<AdminDTO> getDashMonth(AdminDTO adminDTO) throws Exception;

    public void admRsvUpdate(RentDTO rentDTO) throws Exception;

    public int admRentOptAdd(RentDTO rentDTO) throws Exception;

    public void admRentOptDel(RentDTO rentDTO) throws Exception;

    public List<RentDTO> admRentGetOpt(RentDTO rentDTO) throws Exception;

    public RentDTO getMainImg() throws Exception;

    public void setMainImg(RentDTO rentDTO) throws Exception;

    public void addEquipImg(EquipDTO equipDTO) throws Exception;

    public void addEquipImg(List<EquipDTO> equipDTO) throws Exception;

    public List<EquipDTO> admRentGetOpt() throws Exception;

    public void delEquipImg(EquipDTO equipDTO) throws Exception;

    public void addEquipList(EquipDTO equipDTO) throws Exception;

    public List<EquipDTO> getEquipList(EquipDTO equipDTO) throws Exception;

    public void delEquipList(EquipDTO equipDTO) throws Exception;

    public void setEquipData(EquipDTO equipDTO) throws Exception;

    public void setEquipDataList(List<EquipDTO> equipDTO) throws Exception;

    public void preDelEquipData(EquipDTO equipDTO) throws Exception;

    public List<EquipDTO> getRentEquip(EquipDTO equipDTO) throws Exception;

    public List<AdminDTO> admMngList(AdminDTO adminDTO) throws Exception;

    public int admMngListCnt(AdminDTO adminDTO) throws Exception;

    public void admFailReset(AdminDTO adminDTO) throws Exception;

}
