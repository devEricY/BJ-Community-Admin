package com.bjcommunity.admin.Mapper;

import com.bjcommunity.admin.Dto.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminMapper {
    protected static final String NAMESPACE = "com.bjcommunity.admin.Mapper.";

    @Autowired
    private SqlSession sqlSession;

    public int chkAdmInfo(AdminDTO adminDTO){
        return sqlSession.selectOne(NAMESPACE + "chkAdmInfo", adminDTO);
    }

    public AdminDTO getAdmInfo(AdminDTO adminDTO){
        return sqlSession.selectOne(NAMESPACE + "getAdmInfo", adminDTO);
    }

    public void setAdmLog(AdminDTO adminDTO){
        sqlSession.insert(NAMESPACE + "setAdmLog", adminDTO);
    }

    public void setCntReset(AdminDTO adminDTO){
        sqlSession.update(NAMESPACE + "setCntReset", adminDTO);
    }

    public void setFailedLogin(AdminDTO adminDTO){
        sqlSession.insert(NAMESPACE + "setFailedLogin", adminDTO);
    }

    public void setRentUpdate(RentDTO rentDTO){ sqlSession.update(NAMESPACE + "setRentupdate", rentDTO); }

    public void setRentPreImg(RentDTO rentDTO){ sqlSession.update(NAMESPACE + "setRentPreImg", rentDTO); }

    public RentDTO getRentInfo(RentDTO rentDTO){ return sqlSession.selectOne(NAMESPACE + "getRentData", rentDTO); }

    public void reSetOption(RentDTO rentDTO){ sqlSession.delete(NAMESPACE + "resetOption", rentDTO); }

    public void setOption(RentDTO rentDTO){ sqlSession.delete(NAMESPACE + "resetOption", rentDTO); }

    public List<RentDTO> admRsvList(PagingDTO pagingDTO){ return sqlSession.selectList(NAMESPACE + "admRsvList", pagingDTO); }

    public List<RentDTO> admRsvExcelList(RentDTO rentDTO){ return sqlSession.selectList(NAMESPACE + "admRsvExcelList", rentDTO); }

    public List<RentDTO> admRsvGrpExcelList(RentDTO rentDTO){ return sqlSession.selectList(NAMESPACE + "admRsvGrpExcelList", rentDTO); }

    public int admRsvListCnt(PagingDTO pagingDTO){ return sqlSession.selectOne(NAMESPACE + "admRsvListCnt", pagingDTO); }

    public AdminDTO getDashBoard(){ return sqlSession.selectOne(NAMESPACE + "getDashBoard", null); }

    public List<InquiryDTO> admQnaList(InquiryDTO inquiryDTO){ return sqlSession.selectList(NAMESPACE + "admQnaList", inquiryDTO); }

    public int admQnaListCnt(InquiryDTO inquiryDTO){ return sqlSession.selectOne(NAMESPACE + "admQnaListCnt", inquiryDTO); }

    public RentDTO getRsvInfo(RentDTO rentDTO){ return sqlSession.selectOne(NAMESPACE + "admRsvInfo", rentDTO); }

    public InquiryDTO admQnaInfo(InquiryDTO inquiryDTO){ return sqlSession.selectOne(NAMESPACE + "admQnaInfo", inquiryDTO); }

    public void admQnaAnswer(InquiryDTO inquiryDTO){ sqlSession.update(NAMESPACE + "admQnaAnswer", inquiryDTO); }

    public void admQnaDelete(InquiryDTO inquiryDTO){ sqlSession.update(NAMESPACE + "admQnaDelete", inquiryDTO); }

    public List<AdminDTO> getDashMonth(AdminDTO adminDTO){ return sqlSession.selectList(NAMESPACE + "getDashMonth", adminDTO); }

    public void admRsvUpdate(RentDTO rentDTO){ sqlSession.update(NAMESPACE + "admRsvUpdate", rentDTO); }

    public int admRentOptAdd(RentDTO rentDTO){ sqlSession.insert(NAMESPACE + "admRentOptAdd", rentDTO); System.out.println("rentDTO.getOptno() ::::::::::::: " + rentDTO.getOptno()); return rentDTO.getOptno(); }

    public void admRentOptDel(RentDTO rentDTO){ sqlSession.delete(NAMESPACE + "admRentOptDel", rentDTO); }

    public List<RentDTO> admRentGetOpt(RentDTO rentDTO){ return sqlSession.selectList(NAMESPACE + "admRentGetOpt", rentDTO); }

    public void rentMstUpdate(RentDTO rentDTO){ sqlSession.update(NAMESPACE + "setRentMstUpdate", rentDTO); }

    public RentDTO getMainImg(){ return sqlSession.selectOne(NAMESPACE + "getMainImg", null); }

    public void setMainImg(RentDTO rentDTO){ sqlSession.selectOne(NAMESPACE + "setMainImg", rentDTO); }

    public void addEquipImg(EquipDTO equipDTO){ sqlSession.insert(NAMESPACE + "addEquipImg", equipDTO); }

    public void addEquipImg(List<EquipDTO> equipDTO){ sqlSession.insert(NAMESPACE + "addEquipImgList", equipDTO); }

    public List<EquipDTO> getEquipImg(){ return sqlSession.selectList(NAMESPACE + "getEquipImgList", null); }

    public void delEquipImg(EquipDTO equipDTO){
        sqlSession.update(NAMESPACE + "delEquipImg", equipDTO);
    }

    public void addEquipList(EquipDTO equipDTO){
        sqlSession.insert(NAMESPACE + "addEquipList", equipDTO);
    }

    public List<EquipDTO> getEquipList(EquipDTO equipDTO){
        return sqlSession.selectList(NAMESPACE + "getEquipList", equipDTO);
    }

    public void delEquipList(EquipDTO equipDTO){
        sqlSession.update(NAMESPACE + "delEquipList", equipDTO);
    }

    public void setEquipData(EquipDTO equipDTO) {
        sqlSession.insert(NAMESPACE + "setEquipData", equipDTO);
    }

    public void setEquipDataList(List<EquipDTO> equipDTO) {
        sqlSession.insert(NAMESPACE + "setEquipDataList", equipDTO);
    }

    public void preDelEquipData(EquipDTO equipDTO){
        sqlSession.delete(NAMESPACE + "preDelEquipData", equipDTO);
    }

    public List<EquipDTO> getRentEquip(EquipDTO equipDTO){
        return sqlSession.selectList(NAMESPACE + "getRentEquip", equipDTO);
    }

    public List<AdminDTO> admMngList(AdminDTO adminDTO){ return sqlSession.selectList(NAMESPACE + "admMngList", adminDTO); }

    public int admMngListCnt(AdminDTO adminDTO){ return sqlSession.selectOne(NAMESPACE + "admMngListCnt", adminDTO); }

    public void admFailReset(AdminDTO adminDTO){
        sqlSession.update(NAMESPACE + "admFailReset", adminDTO);
    }

}
