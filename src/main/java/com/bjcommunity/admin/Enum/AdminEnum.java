package com.bjcommunity.admin.Enum;

import lombok.Getter;

@Getter
public enum AdminEnum {

    LOGIN_FAIL("아이디나 비밀번호가 잘못되었습니다")
    ,LOGIN_FIVE_FAIL("비밃번호를 5회이상 틀리셨습니다. 관리자에게 문의해주세요.")
    ,LOGIN_SUCCESS("로그인 되었습니다.")
    ;

    private String value;

    AdminEnum(String value) {
        this.value = value;
    }


}
