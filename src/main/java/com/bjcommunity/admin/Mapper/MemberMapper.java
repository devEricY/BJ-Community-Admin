package com.bjcommunity.admin.Mapper;

import com.bjcommunity.admin.Dto.MemberDTO;
import com.bjcommunity.admin.utils.AES256Cipher;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberMapper {
    protected static final String NAMESPACE = "com.bjcommunity.admin.Mapper.";

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SqlSession sqlSession;

    AES256Cipher aes256Cipher = AES256Cipher.getInstance();

    public List<MemberDTO> get_member_list(MemberDTO memberDTO){

        List<MemberDTO> rtrnDTO = sqlSession.selectList(NAMESPACE + "get_member_list", memberDTO);

        try{
            for(int i=0; i < rtrnDTO.size(); i++){
                rtrnDTO.get(i).setMember_email(aes256Cipher.decoding(rtrnDTO.get(i).getMember_email()));
                rtrnDTO.get(i).setMember_phone(aes256Cipher.decoding(rtrnDTO.get(i).getMember_phone()));
            }
        }catch (Exception e){
            logger.debug(e.getMessage().toString());
        }

        return rtrnDTO;
    }

    public int get_member_listCnt(MemberDTO memberDTO){
        return sqlSession.selectOne(NAMESPACE + "get_member_listCnt", memberDTO);
    }

}
