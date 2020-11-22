$(document).ready(function(){
    $(".dg-hd-mo-menu-btn, .dg-hd-mo-menu-panel-overlay, .close-menu-btn").click( function() {
        $(".dg-hd-mo-menu-btn, .dg-hd-mo-menu-panel-overlay, .dg-hd-mo-menu-panel").toggleClass("mo-menu-active");
        /* dg-hd-mo-menu-panel-overlay 활성화 체크 */
        if ($(".dg-hd-mo-menu-panel-overlay").hasClass("mo-menu-active")) {
            $(".dg-hd-mo-menu-panel-overlay").fadeIn();
        } else {
            $(".dg-hd-mo-menu-panel-overlay").fadeOut();
        }
    });

    //메뉴의 + 클릭시 닫히고, 열림
    $('.dg-hd-mo-menu-arrow').click(function(){

        $(".dg-hd-mo-menu-arrow").each(function(){
            $(this).next('ul').removeClass('sub-menu-on');
            $(this).parents('li').removeClass('menu-arrow-active-li');
            $(this).removeClass('menu-arrow-active');
            $(this).prev('a').removeClass('dg-point');
            $(this).parents('li').next('li').removeClass('menu-arrow-active-li-next-li');
        });

        $(this).next('ul').toggleClass('sub-menu-on');
        var $curruntArrow = $(this).toggleClass('menu-arrow-active');
        $(this).parents('li').toggleClass('menu-arrow-active-li');
        $(this).prev('a').toggleClass('dg-point');
        $(this).parents('li').next('li').toggleClass('menu-arrow-active-li-next-li');
    });


})

function fn_wait(){
    alert("아직 미완성된 메뉴 입니다.");
};

//포스코사이언스펠로쉽 FAQ 메뉴
$(function(){
    $('.tab_menu_btn').on('click', function(){
        $('.faq_content').hide();//다른메뉴 선택시 기존에 보여진 내용 숨기기
        $('.tab_menu_btn').removeClass('on');
        $(this).addClass('on');
        var idx = $('.tab_menu_btn').index(this);
        $('.tab_box').hide();
        $('.tab_box').eq(idx).show();
    });

    $('.faq_title').on('click', function(){
        let cName1 = $(this).attr('class');//클릭 된 객체의 class명
        $('.faq_title').removeClass('on');//faq_title on 인경우 -> faq_title로 되돌린다.
        $(this).addClass('on');//클릭된 객체의 class명에 on을 추가한다.
        let cName2 = $(this).attr('class');//현 객체의 클래스이름에 on이 추가된것
        if(cName1 == cName2) {//on을 지우기 전 객체명 == on을 지운 후 추가한 객체명
            $('.faq_title').removeClass('on');//on이 추가된 모든부분을 지운다.
            $(this).next('div').hide();//자신의 하위 faq_content를 숨긴다.
        }else {
            $('.faq_content').hide();
            $(this).next('div').fadeIn();
        }
    });
});
