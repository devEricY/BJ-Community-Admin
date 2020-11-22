<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="../common/admCommon.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    String mstSeqNo = request.getParameter("seqNo");
%>
<head>
    <link rel="stylesheet" type="text/css" href="/static/admin/css/jquery-ui.css">
    <script src="/static/admin/js/jquery-ui.js"></script>
    <style>
        .bgImg{display:none; position:absolute;}
        .contents{width:100%; position:absolute; padding-top:175px; padding-left:66%;}

        #id{width:300px;}
        #password{width:300px;}
        #login{width:300px; color:#fff;}
        .upload-img img{transition: all ease 0.2s;}
        .upload-img img:hover{transform: scale( 0.9 );}
        .upload-img i.pick_on{font-size:3.65rem; background-image:linear-gradient(180deg, #ffd400 0%, #009efd 100%) !important; margin-top:17%;}
        .pick_div {background-color:#00000099; width:84%; height:84%; position:absolute; z-index:999;}
        .paging-div li{float:left; padding:5px 10px; background-color:#fff; border:1px solid #dee2e6; line-height: 1.25; margin-left:5px; color:#007bff; font-size:16px;}
        .paging-div li:first-child{margin-left:0px;}
        .paging-div li.on{background-color:#3f6ad8; border-color:#007bff; }
        .paging-div li.on a{color: #fff; }
        a.infoLike{text-decoration:none; color:#000 !important;}
        a.inBtn{height: 37px; margin-top:5px; padding-top:7px;}

        .tb-time{border:1px solid #b2b2b2; width:100%; margin-top:5px;}
        .tb-time th{border-right:1px solid #b2b2b2; background-color: #797979; color:#fff;}
        .tb-time th:last-child{border-right:0px solid #b2b2b2;}
        .tb-time td{border-right:1px solid #b2b2b2; width:200px;}
        .tb-time td:last-child{border-right:1px solid #b2b2b2;}
        .tb-time td{border-bottom:1px solid #b2b2b2; cursor: pointer; height: 35px;}
        .tb-time td:hover{background-color:#ec1e58; color: #fff;}
        .tb-time td.active{background-color:#ec1e58; color: #fff;}
        .tb-time td.closed{background-color:#a2a2a2; color: #fff; cursor:default;}

        .calender{width:386px; text-align:center; display:inline-block; border:1px solid #d6d6d6; padding-top:30px; padding-bottom:40px;}
        .calender .cal_dayArea{text-align: center; margin-bottom: 30px; width:100%; display:inline-block;}
        .calender table{border-spacing:0px 0px; width:100%; height: 260px; margin-right: 0px;}
        .calender .bd{font-weight:bold;}
        .calender thead{font-size:16px;}
        .calender th{border-collapse:collapse; padding:10px; font-size:14px; color:#737373; background-color:#8686861c; font-weight:400;}
        .calender td{text-align: center; border-collapse:collapse; width:30px; padding:5px; font-size:14px; padding-bottom:5px; color:#585858; cursor: pointer;}
        .calender .td-t{border-top:1px solid #939393;}
        .calender .td-l{border-left:1px solid #939393;}
        .calender .td-la{border-right:1px solid #939393;}
        .calender .td-close{ padding-top:5px; padding-bottom:5px; color:#c3c3c3;}
        .calender .td-close div{text-align: center; font-weight: 500; color:#949494;}
        .calender .td-none{background-color:#dadada6e;}
        .calender .red{color:#f36b6b;}
        .calender .blue{color:#00acff;}
        .calender .td-close.red{color:#f9b4b4;}
        .calender .td-close.blue{color:#9fe0ff;}
        .calender td span{padding:5px 11px;}
        .calender td span.sm{padding:5px 8px;}
        .calender td span.dday{background-color:#efc324; border-radius:50%; color: #fff;}
        /*.calender td span.dday::before{color:#8f8f8f; content:"today"; top:-3px; position: absolute; }*/
        .calender td span.active{background: #868686; border-radius: 50%; color: #ffffff;}

        .cal_strong{font-size:14px; color:#929292;}
        .cal_before{font-size:14px; margin-right: 20px; color:#929292; cursor:pointer; text-decoration:none;}
        .cal_after{font-size: 14px; margin-left:20px; color:#929292; cursor:pointer; text-decoration:none;}

        .eq_select{ width:33%; height: 30px; text-align: center; text-align: center; text-align-last: center; -moz-text-align-last: center; }
        .eq_select option{text-align: center;}
        .eq_bt{margin-bottom:5px; padding-bottom: 20px;}

        img.eq_on{width: 15px; position: absolute; margin-left: -3.5%; margin-top: 7px; display:none;}
        a:hover.eq{color:#b2b2b2; cursor:pointer;}

        @media all and (min-width:768px) and (max-width:1604px) {
            .upload-img i.pick_on{font-size:3.35rem;  margin-top:7%;}
            .pick_div{width:77%; height:80%;}
            .pe-7s-plus{margin-top:7%;}
        }

    </style>
</head>
<body>
<form id="rsvForm" name="rsvForm" method="POST">
    <input type="hidden" id="mstSeqNo" name="mstSeqNo" value="${rsvInfo.rsvNo}" />
    <input type="hidden" value="${dateInfo.year}" id="curYear" name="curYear" />
    <input type="hidden" value="${dateInfo.month}" id="curMonth" name="curMonth" />
    <input type="hidden" value="${rsvInfo.str_date}" id="origin_rsvDay" name="origin_rsvDay" />
    <input type="hidden" value="${rsvInfo.str_date}" id="rsvDay" name="rsvDay" />
    <input type="hidden" value="${rsvInfo.rsv_time}" id="times" name="times" />
    <input type="hidden" value="${rsvInfo.rentNo}" id="rentNo" name="rentNo"  />

    <%-- Reserv Price info --%>
    <input type="hidden" value="${rsvInfo.p_price}" id="pic_price" name="pic_price" />
    <input type="hidden" value="${rsvInfo.v_price}" id="vid_price" name="vid_proce" />
    <input type="hidden" value="${rsvInfo.rsv_price}" id="tot_amount" name="tot_amount" />
    <input type="hidden" value="${rsvInfo.rentAmt}" id="rent_amount" name="rent_amount" />
    <input type="hidden" value="${rsvInfo.deftime}" id="def_time" name="def_time" />
    <input type="hidden" value="${rsvInfo.defprice}" id="def_price" name="def_price" />
    <input type="hidden" value="0" id="vat_amount" name="vat_amount" />
    <input type="hidden" value="${rsvInfo.usrAmt}" id="opt_price" name="opt_price" />
    <input type="hidden" value="" id="rsv_opt" name="rsv_opt" />

    <c:if test="${rsvInfo.rsv_opt == 'photo'}">
    <input type="hidden" value="${rsvInfo.defusrcnt}" id="rentCnt" name="rentCnt" />
    </c:if>

    <c:if test="${rsvInfo.rsv_opt == 'video'}">
    <input type="hidden" value="${rsvInfo.vid_usrcnt}" id="rentCnt" name="rentCnt" />
    </c:if>
    <input type="hidden" value="${rsvInfo.status}" id="rsv_status" name="rsv_status" />
    <input type="hidden" value="${rsvInfo.etctxt}" id="etcTxt" name="etcTxt" />
    <input type="hidden" value="${rsvInfo.frTime}" id="first_time" name="first_time" />
    <input type="hidden" value="${rsvInfo.saleAmt}" id="salesAmt" name="salesAmt" />
    <input type="hidden" value="${rsvInfo.addAmt}" id="addedAmt" name="addedAmt" />

    <input type="hidden" value="${rsvInfo.defprice}" id="origin_price" name="origin_price" />
    <input type="hidden" value="${rsvInfo.defusrcnt}" id="origin_usrcnt" name="origin_usrcnt" />
    <input type="hidden" value="${rsvInfo.vid_price}" id="origin_vid_price" name="origin_vid_price" />
    <input type="hidden" value="${rsvInfo.vid_usrcnt}" id="origin_vid_usrcnt" name="origin_vid_usrcnt" />

    <input type="hidden" value="${rsvInfo.etcAmt}" id="equipAmt" name="equipAmt"/> <%-- 기존 장비 금액--%>
    <input type="hidden" value="${rsvInfo.eqAmt}" id="eq_price" name="eq_price" /> <%-- 신규 장비 금액--%>
    <input type="hidden" value="0" id="eq_times" name="eq_times" />
    <input type="hidden" value="" id="sel_eqNm_list" name="sel_eqNm_list" />
    <input type="hidden" value="${rsvInfo.eqList}" id="sel_eq_list" name="sel_eq_list" />  <%-- 장비 선택 목록 --%>
    <input type="hidden" value="${rsvInfo.eqTime}" id="sel_eq_time" name="sel_eq_time" />  <%-- 장비 선택 시간 --%>
    <input type="hidden" value="${rsvInfo.eqAmt}" id="sel_eq_amount" name="sel_eq_amount" />  <%-- 장비 선택 금액 --%>

    <%-- Reserv Price Change info --%>
    <input type="hidden" id="chgTimes" name="chgTimes" value="" />
    <input type="hidden" id="chgDate" name="chgDate" value="" />
    <input type="hidden" id="chgRent" name="chgRent" value="${rsvInfo.rentNo}" />

    <%@ include file="../common/admHeader.jsp" %>
    <div class="app-main">
        <%@ include file="../common/admLnb.jsp" %>
        <div class="app-main__outer">
            <div class="app-main__inner">
                <div class="app-page-title">
                    <div class="page-title-wrapper">
                        <div class="page-title-heading">
                            <div class="page-title-icon">
                                <i class="pe-7s-video text-success icon-gradient bg-happy-fisher">
                                </i>
                            </div>
                            <div>${rsvInfo.usrNm} 님의 예약정보 입니다.
                                <div class="page-title-subheading">${rsvInfo.reg_date}에 예약하셨습니다.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="main-card col-md-3 card" style="margin-right: 1%;  ">
                        <div class="card-body">
                            <div class="form-row mb-3">
                                <i class="pe-7s-user text-success icon-gradient bg-ripe-malin mr-2" style="font-size:1.7em;"></i>
                                <h5 class="card-title fsize-1" style="line-height: 1.6;">
                                    회원 정보
                                </h5>
                            </div>

                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label>예약자 명</label>
                                    <input type="text" class="form-control" id="rsvNm" name="rsvNm" placeholder="예약자 명" value="${rsvInfo.usrNm}">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label>입금자 명</label>
                                    <input type="text" class="form-control" id="depoNm" name="depoNm" placeholder="입금자 명" value="${rsvInfo.depoNm}">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label>결제 방식</label>
                                    <select class="form-control" id="payType" name="payType">
                                        <option value="basic" <c:if test="${rsvInfo.payType eq 'basic'}"> selected </c:if> >일반 계좌이체</option>
                                        <option value="company" <c:if test="${rsvInfo.payType eq 'company'}"> selected </c:if>>세금계산서 계좌이체</option>
                                        <option value="credit" <c:if test="${rsvInfo.payType eq 'credit'}"> selected </c:if>>카드결제</option>
                                    </select>
                                </div>
                            </div>

                            <c:if test="${rsvInfo.payType eq 'company'}">
                                <div class="form-row" id="compImg_area">
                                    <div class="col-md-12 mb-3">
                                        <label>사업자 등록증</label>
                                        <a href="${rsvInfo.comp_img}" target="_blank">다운로드</a>
                                    </div>
                                </div>
                            </c:if>

                            <div class="form-row">
                                <div class="col-md-5 mb-3">
                                    <label for="vatppYn">세금계산서 여부</label>
                                    <select class="form-control" style="width: 120px;" id="vatppYn" name="vatppYn">
                                        <option value="N" <c:if test="${rsvInfo.vatppYn eq 'N'}"> selected </c:if>>N</option>
                                        <option value="Y" <c:if test="${rsvInfo.vatppYn eq 'Y'}"> selected </c:if>>Y</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label >세금계산서 발급 날짜</label>
                                    <input type="text" class="form-control" id="vatDate" name="vatDate" value="${rsvInfo.vatDate}">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label for="validationCustom03">전화번호</label>
                                    <input type="text" class="form-control" id="validationCustom03" placeholder="전화번호" required="" value="${rsvInfo.phoneNo}" disabled>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label for="validationCustomUsername">이메일</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="inputGroupPrepend">@</span>
                                        </div>
                                        <input type="text" class="form-control" id="usrMail" name="usrMail" placeholder="Username" aria-describedby="inputGroupPrepend" required="" value="${rsvInfo.email}" disabled>
                                    </div>
                                </div>
                            </div>

                            <%--<div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label>촬영내용</label>
                                    <textarea id="rsvCont" name="rsvCont" class="form-control mb-12" style="height: 150px; overflow-y: auto;">${rsvInfo.rsv_cont}</textarea>
                                </div>
                            </div>--%>
                        </div>
                    </div>


                    <div class="main-card col-md-4 card " style="margin-right: 1%;">
                        <div class="card-body">
                            <div class="form-row mb-3">
                                <i class="pe-7s-note2 text-success icon-gradient bg-plum-plate mr-2" style="font-size:1.7em;"></i>
                                <h5 class="card-title fsize-1" style="line-height: 1.6;">
                                    예약 정보
                                </h5>
                            </div>

                            <form class="needs-validation" novalidate="">
                                <div class="form-row">
                                    <div class="col-md-9 mb-3">
                                        <label for="rsvPlace">예약 장소</label>
                                        <input type="text" class="form-control" id="rsvPlace" placeholder="렌트명" value="${rsvInfo.rentNm}" required="" disabled>
                                    </div>
                                    <div class="col-md-3 mt-4">
                                        <c:if test="${chgFlag}">
                                            <a class="btn btn-secondary text-white btn-shadow inBtn" data-toggle="modal" data-target=".bd-example-modal-lg" onclick="rsv_change('ALL');">변경</a>
                                        </c:if>
                                        <c:if test="${!chgFlag}">
                                            <a class="btn btn-secondary text-white btn-shadow inBtn" onClick="fn_alert('dateOver')">만료</a>
                                        </c:if>

                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-9 mb-3">
                                        <label for="validationCustom03">렌트 예약 날짜</label>
                                        <input type="text" class="form-control" id="rsvDate" name="rsvDate" placeholder="예약 날짜" required="" value="${rsvInfo.str_date}" disabled>
                                    </div>
                                    <div class="col-md-3 mt-4">
                                        <c:if test="${chgFlag}">
                                            <a class="btn btn-secondary text-white btn-shadow inBtn" data-toggle="modal" data-target=".bd-example-modal-lg" onclick="rsv_change('DATE');">변경</a>
                                        </c:if>
                                        <c:if test="${!chgFlag}">
                                            <a class="btn btn-secondary text-white btn-shadow inBtn" onClick="fn_alert('dateOver')">만료</a>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-9 mb-3">
                                        <label for="validationCustom04">렌트 예약 시간</label>
                                        <input type="text" class="form-control" id="rsvTime" placeholder="추가 인원 금액" required="" value="${rsv_times[0]}:00 ~ ${rsv_times[fn:length(rsv_times)-1] + 1}:00" disabled>
                                    </div>
                                    <div class="col-md-3 mt-4">
                                        <c:if test="${chgFlag}">
                                            <a class="btn btn-secondary text-white btn-shadow inBtn" data-toggle="modal" data-target=".bd-example-modal-lg" onclick="rsv_change('TIME');">변경</a>
                                        </c:if>
                                        <c:if test="${!chgFlag}">
                                            <a class="btn btn-secondary text-white btn-shadow inBtn" onClick="fn_alert('dateOver')">만료</a>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-12 mb-3">
                                        <label for="usrCnt">예약 인원 수 </label>
                                        <input type="text" class="form-control" id="usrCnt" name="usrCnt" placeholder="예약 인원 수" value="${rsvInfo.usrcnt}" required="" >
                                    </div>
                                    <%--<div class="col-md-6 mb-3">
                                        <label for="carCnt">방문 차량 수 </label>
                                        <input type="text" class="form-control" id="carCnt" name="carCnt" placeholder="방문 차량 수" value="${rsvInfo.carcnt}" required="" >
                                    </div>--%>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-12 mb-3">
                                        <label for="rsvOption">예약 옵션 </label>
                                        <select class="form-control" id="rsvOption" name="rsvOption">
                                            <option id="radio_photo" name="options" value="photo" <c:if test="${rsvInfo.rsv_opt == 'photo'}"> selected </c:if>>사진</option>
                                            <option id="radio_video" name="options" value="video" <c:if test="${rsvInfo.rsv_opt == 'video'}"> selected </c:if>>영상</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-6 mb-3">
                                        <label for="preDepoDate">예약금 입금 날짜</label>
                                        <input type="text" class="form-control" id="preDepoDate" name="preDepoDate" value="${rsvInfo.predepo_date}">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="preDepoDate">예약금 입금 금액</label>
                                        <input type="text" class="form-control" id="depoAmt" name="depoAmt" placeholder="선금 입금 금액" value="${rsvInfo.predepo_amt}">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-12 mb-3">
                                        <label for="allDepoDate">잔금 결제 날짜</label>
                                        <input type="text" class="form-control" id="allDepoDate" name="allDepoDate" value="${rsvInfo.paymnt_date}">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-5 mb-3">
                                        <label for="reDepoYn">예약금 환급 여부</label>
                                        <select class="form-control" style="width: 120px;" id="reDepoYn" name="reDepoYn">
                                            <option value="N" <c:if test="${rsvInfo.reDepoYn eq 'N'}"> selected </c:if>>N</option>
                                            <option value="Y" <c:if test="${rsvInfo.reDepoYn eq 'Y'}"> selected </c:if>>Y</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label >환급 날짜</label>
                                        <input type="text" class="form-control" id="cancDepoDate" name="cancDepoDate" value="${rsvInfo.cancel_date}">
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>


                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.rentAmt}" var="rentAmt"/>
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.usrAmt}" var="usrAmt"/>
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.etcAmt}" var="etcAmt"/>
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.rsv_price}" var="rsv_price"/>

                    <div class="main-card col-md-4 card">
                        <div class="card-body">
                            <div class="form-row mb-3">
                                <i class="pe-7s-cash text-success icon-gradient bg-plum-plate mr-2" style="font-size:1.7em;"></i>
                                <h5 class="card-title fsize-1" style="line-height: 1.6;">
                                    금액 정보
                                </h5>
                            </div>
                            <form class="needs-validation" novalidate="">

                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.rentAmt}" var="rentAmt"/>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.usrAmt}" var="usrAmt"/>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.etcAmt}" var="etcAmt"/>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.eqAmt}" var="eqAmt"/>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.saleAmt}" var="saleAmt"/>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.addAmt}" var="addAmt"/>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.rsv_price}" var="rsv_price"/>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.predepo_amt}" var="preDepoAmt"/>

                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvInfo.rsv_price}" var="total_price"/>

                                <div class="form-row">
                                    <div class="col-md-6 mb-3">
                                        렌트 예약 금액
                                    </div>
                                    <div class="col-md-6 mb-3 fsize-1">
                                        KRW <span id="rentAmt">${rentAmt}</span>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-6 mb-3">
                                        추가 인원 금액
                                    </div>
                                    <div class="col-md-6 mb-3 fsize-1">
                                        KRW <span id="usrAmt">${usrAmt}</span>
                                    </div>
                                </div>

                                <c:if test="${etcAmt != null}">
                                    <div class="form-row" style="margin-bottom: 10px; color: #b2b2b2;">
                                        <div class="col-md-6 mb-1" style="line-height: 1.5;">
                                            기존 장비 사용 금액
                                        </div>
                                        <div class="col-md-6 mb-1 fsize-1">
                                            KRW <span id="etcAmt" name="etcAmt" >${etcAmt}</span>
                                                <%--<input type="text" class="form-control" id="etcAmt" name="etcAmt" placeholder="장비 입금 금액" value="${etcAmt}" />--%>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${rsvEqList != null}">
                                    <div class="form-row">
                                        <div class="col-md-6 mb-1" style="line-height: 1.5;">
                                            장비 사용 금액
                                        </div>
                                        <div class="col-md-6 mb-1 fsize-1">
                                            KRW <span id="eqAmt" name="eqAmt" >${eqAmt}</span>
                                            <%--<input type="text" class="form-control" id="etcAmt" name="etcAmt" placeholder="장비 입금 금액" value="${eqAmt}" />--%>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="form-row" style="margin-top:2px; padding-top:5px;">
                                    <div class="col-md-6 mb-1" style="line-height: 2.5;">
                                        장비 신청 내역
                                    </div>
                                    <div class="col-md-6 mb-1" style="font-size:13px;" id="eq_list_div">
                                        <c:forEach var="eqList" items="${rsvEqList}" varStatus="eqStatus">
                                            <span><c:out value="${eqList}" /></span><br/>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="form-row" style="margin-top:10px;">
                                    <div class="col-md-6 mb-1" style="line-height: 2.5;">
                                        할인 금액
                                    </div>
                                    <div class="col-md-6 mb-1 fsize-1">
                                        <input type="text" class="form-control" id="saleAmt" name="saleAmt" placeholder="할인 금액" value="${saleAmt}" />
                                    </div>
                                </div>

                                <div class="form-row" style="margin-top:10px;">
                                    <div class="col-md-6 mb-1" style="line-height: 2.5;">
                                        추가 금액
                                    </div>
                                    <div class="col-md-6 mb-1 fsize-1">
                                        <input type="text" class="form-control" id="addAmt" name="addAmt" placeholder="추가 금액" value="${addAmt}" />
                                    </div>
                                </div>

                                <div class="divider"></div>

                                <div class="form-row" id="ts_sale_area">
                                    <div class="col-md-6 mb-3" style="line-height: 1.5; font-weight: bold;">
                                        할인 금액
                                    </div>
                                    <div class="col-md-6 mb-3 fsize-1" style="font-weight: bold;">
                                        KRW <span id="ts_sale_price">${saleAmt}</span>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-6 mb-3" style="line-height: 1.5; font-weight: bold;">
                                        총 예약 금액
                                    </div>
                                    <div class="col-md-6 mb-3 fsize-1" style="font-weight: bold;">
                                        KRW <span id="ts_price">${rsv_price}</span>
                                    </div>
                                </div>
                                <div class="form-row" style="display: none;" id="vat_area">
                                    <div class="col-md-6 mb-1" style="line-height: 1.5; font-weight: bold;">
                                        VAT (10%)
                                    </div>
                                    <div class="col-md-6 mb-1 fsize-1" style="font-weight: bold;">
                                        KRW <span id="rsvVat">${vat}</span>
                                    </div>
                                </div>

                                <div class="divider"></div>
                                <div class="form-row">
                                    <div class="col-md-6 mb-2" style="line-height: 1.5; font-weight: bold;">
                                        총 결제 금액
                                    </div>
                                    <div class="col-md-6 mb-2 fsize-1" style="font-weight: bold;">
                                        KRW <span id="amount">${total_price}</span>
                                    </div>
                                </div>

                                <div class="form-row" style="margin-top:20px;">
                                    <div class="col-md-12 mb-2" style="line-height: 1.5;">
                                        비고사항
                                    </div>
                                    <textarea id="bigoText" name="bigoText" class="form-control col-md-12 mb-2 fsize-1" style="height: 80px;">${rsvInfo.etctxt}</textarea>
                                </div>
                                <div class="form-row float-right">
                                    <div class="col-md-12 mb-3">
                                        <label>예약 상태</label>
                                        <select id="rsvState" name="rsvState">
                                            <option value="W" <c:if test="${rsvInfo.status == 'W'}"> selected </c:if> >예약 대기</option>
                                            <option value="C" <c:if test="${rsvInfo.status == 'C'}"> selected </c:if> >예약 취소</option>
                                            <option value="R" <c:if test="${rsvInfo.status == 'R'}"> selected </c:if> >예약 완료</option>
                                            <option value="D" <c:if test="${rsvInfo.status == 'D'}"> selected </c:if> >예약 종료</option>
                                        </select>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="row">
                            <div class="col-md-12 mt-5">
                                <a class="mb-4 mr-6 btn btn-secondary text-white float-right btn-shadow" onclick="fn_submit();">저장</a>
                                <c:if test="${chgFlag}">
                                <a class="mb-4 mr-6 btn btn-secondary text-white float-right btn-shadow" data-toggle="modal" data-target=".bd-example-modal-lg" onclick="rsv_change('TIME');" style="margin-right:5px;">장비변경</a>
                                </c:if>
                                <c:if test="${!chgFlag}">
                                <a class="mb-4 mr-6 btn btn-secondary text-grey float-right btn-light" style="margin-right: 5px; color: #b2b2b2;" onClick="fn_alert('dateOver')">장비 변경 만료</a>
                                </c:if>
                                <a class="mb-4 mr-6 btn btn-secondary float-right btn-light <c:if test="${rsvInfo.cmailyn eq 'Y'}"> disabled </c:if>" style="margin-right:5px;" onclick="fn_confirm();" <c:if test="${rsvInfo.cmailyn eq 'Y'}"> disabled </c:if> >예약 메일 확정</a>
                                <c:if test="${authCd eq 1}">
                                <a class="mb-4 mr-6 btn btn-danger float-left text-white" style="margin-right:5px;" onclick="fn_delete();" >예약 삭제</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-modal="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modal_title">예약 변경</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="rsv_place">
                        <div class="fsize-1 font-weight-bold mb-1">예약 장소</div>
                        <select class="form-control-sm form-control" id="rentP">
                            <c:forEach var="rentInfo" items="${rentInfo}" varStatus="rentStatus">
                                <c:if test="${rsvInfo.rentNo == rentInfo.seqNo}">
                                    <option value="${rentInfo.seqNo}" data-picpr="${rentInfo.p_price}" data-vidpr="${rentInfo.v_price}" data-usrcnt="${rentInfo.usrcnt}" data-deftime="${rentInfo.deftime}" data-defprice="${rentInfo.defprice}" data-vid_usrcnt="${rentInfo.vid_usrcnt}" data-vid_price="${rentInfo.vid_price}" selected>${rentInfo.subNm}</option>
                                </c:if>
                                <c:if test="${rsvInfo.rentNo != rentInfo.seqNo}">
                                    <option value="${rentInfo.seqNo}" data-picpr="${rentInfo.p_price}" data-vidpr="${rentInfo.v_price}" data-usrcnt="${rentInfo.usrcnt}" data-deftime="${rentInfo.deftime}" data-defprice="${rentInfo.defprice}" data-vid_usrcnt="${rentInfo.vid_usrcnt}" data-vid_price="${rentInfo.vid_price}" >${rentInfo.subNm}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mt-3" id="rsv_date">
                        <div class="fsize-1 font-weight-bold mb-1">예약 날짜</div>
                        <div class="calender">
                            <div class="cal_dayArea">
                                <a class="cal_before" onClick="change_month('${dateInfo.beforeYear}', '${dateInfo.beforeMonth}')" ><</a>
                                <Strong class="cal_strong">${dateInfo.year}. ${dateInfo.month}</Strong>
                                <a class="cal_after" onClick="change_month('${dateInfo.afterYear}', '${dateInfo.afterMonth}')">></a>
                            </div>
                            <table>
                                <thead>
                                <tr>
                                    <th class="red">일</th>
                                    <th>월</th>
                                    <th>화</th>
                                    <th>수</th>
                                    <th>목</th>
                                    <th>금</th>
                                    <th class="blue">토</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set var="cellCount" value="1" />
                                <c:forEach var="a" begin="1" end="${dateInfo.lastDay}" step="1">
                                    <c:if test="${cellCount == 1}" >
                                        <tr>
                                    </c:if>
                                    <c:if test="${a == 1}" >
                                        <c:forEach var="b" begin="1" end="${dateInfo.firstDay - 1}" step="1">
                                            <c:if test="${b == 1}" >
                                                <td></td>
                                                <c:set var="cellCount" value="${cellCount + 1}" />
                                            </c:if>
                                            <c:if test="${b != 1}" >
                                                <c:set var="cellCount" value="${cellCount + 1}" />
                                                <td></td>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${dateInfo.dday > a}">
                                        <c:if test="${cellCount == 1}" >
                                            <td class="td-close red"><span><c:out value="${a}" /></span></td>
                                        </c:if>
                                        <c:if test="${cellCount > 1 && cellCount != 7}">
                                            <td class="td-close"><span><c:out value="${a}"/></span></td>
                                        </c:if>
                                        <c:if test="${cellCount == 7}">
                                            <td class="td-close blue"><span><c:out value="${a}"/></span></td>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${dateInfo.dday <= a}">
                                        <c:if test="${cellCount == 1}" >
                                            <c:if test="${dateInfo.dday == a}" >
                                                <td class="red" style="background-color:#efc324;"><span><c:out value="${a}"/></span>
                                                </td>
                                            </c:if>
                                            <c:if test="${dateInfo.dday != a}" >
                                                <td class="red"><span><c:out value="${a}"/></span>
                                                </td>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${cellCount > 1 && cellCount != 7}">
                                            <c:if test="${dateInfo.dday == a}" >
                                                <td ><span class="dday"><c:out value="${a}"/></span>
                                                </td>
                                            </c:if>
                                            <c:if test="${dateInfo.dday != a}" >
                                                <td><span><c:out value="${a}"/></span></td>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${cellCount == 7}">
                                            <td class="blue"><span><c:out value="${a}"/></span></td>
                                        </c:if>
                                    </c:if>


                                    <c:set var="cellCount" value="${cellCount + 1}" />

                                    <c:if test="${a == dateInfo.lastDay && cellCount <= 7}" >
                                        <c:forEach var="c" begin="${cellCount}" end="7" step="1">
                                            <c:if test="${c == 1}" >
                                                <td></td>
                                                <c:set var="cellCount" value="${cellCount + 1}" />
                                            </c:if>
                                            <c:if test="${c != 1}" >
                                                <c:set var="cellCount" value="${cellCount + 1}" />
                                                <td></td>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${cellCount > 7}">
                                        </tr>
                                        <c:set var="cellCount" value="1" />
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="mt-3" id="rsv_time">
                        <div class="fsize-1 font-weight-bold mb-1">예약 시간</div>
                        <table class="tb-time">
                            <tbody style="text-align: center;">
                            <c:set var="infoCnt" value="0" />
                            <c:forEach var="timeInfo" items="${timeInfo}" varStatus="timeStatus" >
                                <c:if test="${infoCnt == 0 }">
                                    <tr>
                                </c:if>
                                <td id="${timeInfo.tno}"><c:out value="${timeInfo.times}" /></td>
                                <c:set var="infoCnt" value="${infoCnt + 1}" />
                                <c:if test="${infoCnt > 12}">
                                    </tr>
                                    <c:set var="infoCnt" value="0" />
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-3" id="rsv_eq">
                        <div class="fsize-1 font-weight-bold mb-1">장비 대여</div>
                        <div id="eq_select_div" class="eq_bt" style="width:100%; text-align: left; margin-bottom:5px; height: 30px; padding-top:3px;">
                            <div style="float: left; width:99%; padding-left:5px; text-align: center;">
                                <select class="eq_select" id="eq_lv_1">
                                    <option>장비 분류</option>
                                </select>
                                <select class="eq_select" id="eq_lv_2">
                                    <option>품목 선택</option>
                                </select>
                                <select class="eq_select" id="eq_lv_3">
                                    <option>장비 대여 시간</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="mt-3" style="display:none; " id="eq_sel_div">
                        <div class="fsize-1 font-weight-bold mb-1">유료 장비 선택 목록</div>
                        <div style="width:100%; text-align: left; margin-bottom:5px; padding-top:10px; padding-bottom: 20px;">
                            <div style="width:95%; margin:auto; border:1px solid #b2b2b2; padding-left:10px; line-height: 2.7; " id="eq-div">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <a class="btn btn-primary text-white" onclick="fn_rsvChg();" data-dismiss="modal">변경내용 저장</a>
                </div>
            </div>
        </div>
    </div>

</form>
<div id="pick_onDiv" style="display:none;"><div class="pick_div" onClick="fn_pickOff(this);" ><i class="pe-7s-check icon-gradient bg-happy-itmeo pick_on"> </i></div></div>
<iframe id="sbIframe" name="sbIframe" style="border:0px; width:0px; height:0px;"> </iframe>
</body>
</html>

<script type="text/javascript">
    let arr = [];
    let beforeFlag = "";
    let changeFlag = false;
    var eqArr = [];
    var eqPrArr = [];
    var eqSelArr = [];
    var eqSelTimArr = [];
    var eqSelNmArr = [];

    $(document).ready(function(){

        getEquip(${rsvInfo.rentNo}, '', 1);

        $( function() {
            $( "#preDepoDate" ).datepicker();
            $( "#allDepoDate" ).datepicker();
            $( "#cancDepoDate" ).datepicker();
            $("#vatDate").datepicker();
        } );

        $("#preDepoDate").change(function(){
            if($(this).val() != null){
                $(this).val(dateFormat($(this).val()));
            }
        });

        $("#allDepoDate").change(function(){
            if($(this).val() != null){
                $(this).val(dateFormat($(this).val()));
            }
        });

        $("#cancDepoDate").change(function(){
            if($(this).val() != null){
                $(this).val(dateFormat($(this).val()));
            }
        });

        $("#vatDate").change(function(){
            if($(this).val() != null){
                $(this).val(dateFormat($(this).val()));
            }
        });

        /* 예약 ( 사진 or 영상 ) */
        $("#rsvOption").change(function(){
            let str_opt = $(this).children("option:selected").attr("id");
            $("#rsv_opt").val(str_opt.replace("radio_", ""));

            console.log($(this).children("option:selected").val());

            if($(this).children("option:selected").val() == "video"){
                $("#rentCnt").val($("#origin_vid_usrcnt").val());
                $("#def_price").val($("#origin_vid_price").val());
            }else{
                $("#rentCnt").val($("#origin_usrcnt").val());
                $("#def_price").val($("#origin_price").val());
            }

            console.log("rentCnt : " + $("#rentCnt").val());
            console.log("def_price : " + $("#def_price").val());

            if(Number($("#tot_amount").val()) > 0){
                chgUsrCnt();
                setAmount('opt');
            }else{
                chgUsrCnt();
                setAmount('opt');
            }

        });

        /* 예약 유저 인원 수  */
        $("#usrCnt").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,''));

            chgUsrCnt();
        });

        $("#etcAmt").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,''));
            $("#equipAmt").val($(this).val());
            setAmount('opt');
        });

        $("#depoAmt").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,''));
            setAmount('opt');
        });

        $("#saleAmt").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,''));
            $("#salesAmt").val($(this).val());
            setAmount('opt');
        });

        $("#addAmt").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,''));
            $("#addedAmt").val($(this).val());
            setAmount('opt');
        });


        setAmount('opt');
    });

    function chgUsrCnt(){
        let usrCnt = Number($("#usrCnt").val());
        let rentCnt = Number($("#rentCnt").val());
        let defprice = Number($("#def_price").val());
        let amount = Number($("#rent_amount").val());

        if(usrCnt > rentCnt){
            $("#usrAmt").html("");
            $("#opt_price").val(Number(((usrCnt-rentCnt) * (defprice * arr.length))));
            $("#usrAmt").html(setComma(Number($("#opt_price").val())));
        }else{
            if(amount <= 0){
                $("#usrAmt").html(0);
            }
            $("#opt_price").val(0);
            $("#usrAmt").html(0);
        }

        setAmount('opt');

    }

    function dateFormat(val){
        const valArr = val.split("/");
        return valArr[2] + "-" + valArr[0] + "-" + valArr[1];
    }

    function fn_search(){
        var form = document.rsvForm;
        form.target = "_self";
        form.action = "/admin/rsv/list";
        form.submit();
    }

    function fn_submit(){

        var result = confirm("이대로 예약을 변경하시겠습니까?");
        if(result){
            if(arr.length > 0){
                $("#times").val(arr);
                $("#first_time").val(arr[0]);
            }
            $("#etcTxt").val($("#bigoText").val());

            var form = document.rsvForm;
            form.target = "_self";
            form.action = "/admin/rsv/rsvUpdate";
            form.submit();
        }
    }

    function rsv_change(gubun){

        if(beforeFlag != gubun){
            clearTime();
            change_month(${dateInfo.year}, ${dateInfo.month-1});
            setTimeout(function() { curDate() }, 500);
            setTimeout(function() { curTime() }, 700);
        }
        beforeFlag = gubun;
        if(gubun == "ALL"){
            $("#rsv_place").show();
            $("#rsv_date").show();
            $("#rsv_time").show();
            $("#rsv_eq").show();
        }else if(gubun == "DATE"){
            $("#rsv_place").hide();
            $("#rsv_date").show();
            $("#rsv_time").show();
            $("#rsv_eq").show();
        }else if(gubun == "TIME"){
            $("#rsv_place").hide();
            $("#rsv_date").hide();
            $("#rsv_time").show();
            $("#rsv_eq").show();
        }
    }

    function change_month(year, month){
        $.ajax({
            url:'/rsv/getMonth',
            type:'post',
            data: {"year" : year, "month" : month, "gubun" : "Y"},
            success:function(data){
                $(".calender").html();
                $(".calender").html(data);
            }
        })
    }

    function clearTime(){
        arr = [];
        $(".tb-time").find("td").each(function(){
            $(this).removeClass("active");
            $(this).removeClass("closed");
        });
    }

    function getTimes(){
        $.ajax({
            url:'/rsv/getTimes',
            type:'post',
            data: {"rentNo" : $("#chgRent").val(), "rsvDate" : $("#rsvDay").val()},
            success:function(data){
                let b_days;

                $(".tb-time").find("td").each(function(){
                    $(this).removeClass("active");
                });

                $(".tb-time").find("td").each(function(){
                    $(this).removeClass("closed");
                });

                arr = [];

                for(let j=0; j < data.length; j++){
                    b_days = data[j].split(",");

                    for(let i=0; i < b_days.length; i++){
                        $(".tb-time").find("td").each(function(){
                            if(b_days[i] == $(this).attr("id")){
                                //console.log("$(this).attr(id) : " + $(this).attr("id"));
                                $(this).addClass("closed");
                            }
                        });
                    }
                }

                //console.log('rsvDay : ' + $("#rsvDay").val());
                //console.log('origin_rsvDay : ' + $("#origin_rsvDay").val());

                if($("#rsvDay").val() == $("#origin_rsvDay").val()){
                    console.log("in");
                    curTime();
                }

            }
        })
    }


    $(".calender").find("td").click(function(){
        if(!$(this).hasClass("td-close")){
            $(".calender").find("td").each(function () {
                if($(this).find("span").hasClass("active")){
                    $(this).find("span").removeClass("active");
                    $(this).find("span").removeClass("sm");
                }
            });

            if($(this).find("span").html().length > 1){
                $(this).find("span").addClass("sm");
            }

            $(this).find("span").addClass("active");
            $("#dday").html("");
            $("#rsvDay").val($("#curYear").val() + "-" + $("#curMonth").val() + "-" + $(this).find("span").html());

            getTimes();

        }else{
            alert("예약종료된 날짜는 선택이 불가능 합니다.")
        }

    });

    $(".tb-time").find("td").click(function(){
        let max = 0;
        let min = 0;
        let flag = false;
        let flagStr = "";
        let opt = "";
        let amount = 0;
        let cur = Number($(this).attr("id"));
        let tempArr = [];

        if($(this).hasClass("closed")){
            alert("이미 예약완료된 시간은 선택할 수 없습니다.");
            return false;
        }

        if($("#rentNo").val() == 0 || $("#rentNo").val() == ""){
            alert("스튜디오 먼저 선택해주세요.");
            return false;
        }

        $("option[name=options]").each(function(){
            if($(this).is(":checked") == true){
                opt = $(this).attr("id");

                opt = opt.replace("radio_", "");


                if(opt == "photo"){
                    amount = Number($("#pic_price").val());
                }else if(opt == "video"){
                    amount = Number($("#vid_price").val());
                }
            }
        });

        for(var i=0; i < arr.length; i++){
            arr[i] = parseInt(arr[i]);
        }

        arr.sort(function(a, b) { // 오름차순
            return a - b;
            // 1, 2, 3, 4, 10, 11
        });


        if(arr.length > 0){
            max = Math.max.apply(null, arr);
            min = Math.min.apply(null, arr);
        }

        if((max+1) === cur){
            flag = true;
        }else if((min-1) === cur){
            flag = true;
        }else if(arr.length === 0){
            flag = true;
        }else if(arr.length > 0 && (cur === max || cur === min)){
            for(let i=0; i < arr.length; i++){
                if(Number(arr[i]) === max || Number(arr[i]) === min){
                    flagStr = "del";
                    flag = true;
                }
            }
        }

        if(flag){
            if(flagStr == "del"){
                const idx = arr.findIndex(function(item) {
                    return item === cur
                });
                if (idx > -1) arr.splice(idx, 1)
            }else{
                arr.push(cur);
            }

            arr.sort(function(a, b) { // 오름차순
                return a - b;
                // 1, 2, 3, 4, 10, 11
            });

            console.log(arr);


            //$("#tot_amount").val(Number(amount * arr.length));

            if($(this).hasClass("active")){
                $(this).removeClass("active");
            }else{
                $(this).addClass("active");
            }
        }else{
            alert("시간은 연속해서 선택하셔야 합니다");
        }
    });

    /*$("#reDepoYn").change(function(){
        if($(this).val() == "Y"){
            var result = confirm("환급이 Y인경우 자동으로 예약이 취소상태가 됩니다. 그래도 변경하시겠습니까?");
            if(result){
                $("#rsvState").find("option").each(function(){
                    if($(this).val() == "C"){
                        $(this).attr("selected", true);
                    }else{
                        $(this).attr("selected", false);
                    }
                })
            }else{
                $("#reDepoYn").find("option").each(function(){
                    if($(this).val() == "Y"){
                        $(this).attr("selected", false);
                    }else{
                        $(this).attr("selected", true);
                    }
                })
            }
        }
    });*/

    $("#payType").change(function(){
        setAmount('opt');
    });

    $("#rentP").change(function(){
        $("#chgRent").val($(this).children("option:selected").val());

        $("#rentNo").val($(this).children("option:selected").val());
        $("#pic_price").val($(this).children("option:selected").attr("data-picpr"));
        $("#vid_price").val($(this).children("option:selected").attr("data-vidpr"));
        $("#rentCnt").val($(this).children("option:selected").attr("data-usrcnt"));

        if($("input[name=rsvOption]:selected").val() == "video"){
            $("#def_time").val($(this).children("option:selected").attr("data-vid_usrcnt"));
            $("#def_price").val($(this).children("option:selected").attr("data-vid_price"));
        }else{
            $("#def_time").val($(this).children("option:selected").attr("data-deftime"));
            $("#def_price").val($(this).children("option:selected").attr("data-defprice"));
        }

        getTimes();
    });

    $("#rsvState").change(function(){
        $("#rsv_status").val($(this).children("option:selected").val());
    });

    function curDate(){
        let dateArr;

        if($("#rsvDay").val() != null){
            dateArr = $("#rsvDay").val().split("-");
        }

        if(dateArr.length > 0 ){
            $(".calender").find("td").each(function () {
                if(Number(dateArr[2]) == Number($(this).find("span").html())){
                    $(this).find("span").trigger("click");
                }

                // $(this).find("span").hasClass("active")
            });
        }
    }

    function curTime(){
        let i = 0, k = 0;

        if(arr.length <= 0){
            arr = $("#times").val().split(',');
        }

        $(".tb-time").find("td").each(function(){
            if(i == arr[k]){
                $(this).removeClass("closed");
                $(this).addClass("active");

                if(arr.length > k) k++;
            }
            i++;
        });
    }

    function fn_rsvChg(){ // 예약 변경 버튼 클릭 시
        let amount = 0;
        $("#rsvPlace").val($("#rentP :selected").html());
        $("#rsvDate").val($("#rsvDay").val());
        let usrCnt = Number($("#usrCnt").val());
        let rentCnt = Number($("#rentCnt").val());
        let defprice = Number($("#def_price").val());

        if(eqSelArr.length > 0) {
            var result = confirm(" 기존의 장비 사용금액이 0원으로 초기화 되며, 현재 선택된 장비로 교체 됩니다. 그래도 진행하시겠습니까? ");
            if (!result) {
                return false;
            }
        }

        arr.sort(function(a, b){ // 오름차순
            return a - b;
        });

        $("[name=options]").each(function(){
            if($(this).is(":selected")){
                opt = $(this).attr("id");
                opt = opt.replace("radio_", "");

                console.log('opt [' + opt + ']');

                if(opt == "photo"){
                    amount = Number($("#pic_price").val());
                }else if(opt == "video"){
                    amount = Number($("#vid_price").val());
                }
            }
        });

        if(eqSelArr.length > 0){
            $("#sel_eq_list").val(eqSelArr);
            $("#sel_eq_time").val(eqSelTimArr);
            $("#sel_eq_amount").val($("#eq_price").val());

            let eqNmArr = [];
            let eqNm = "";
            $("#eq-div").find("a").each(function(){
                eqNm = $(this).html();
                eqNmArr[eqNmArr.length] = eqNm.substring(0, eqNm.indexOf(',<'));
            });

            $("#eqAmt").html("0");
            $("#etcAmt").html("0");
            $("#eq_list_div").html("");
            $("#equipAmt").val(0);
            $("#eqAmt").html(setComma($("#eq_price").val()));

            for(var i=0; i < eqSelNmArr.length; i++){
                $("#eq_list_div").append("<span>"+ eqSelNmArr[i]+"</span><br/>")
            }

            $("#sel_eqNm_list").val(eqNmArr);
        }else{
            $("#eq_list_div").html("");
            $("#eq_price").val(0);
            $("#eqAmt").html("0");
        }

        console.log('usrCnt ['+usrCnt+']');
        console.log('rentCnt ['+rentCnt+']');

        if(usrCnt > rentCnt){
            $("#usrAmt").html("");
            $("#opt_price").val(Number(((usrCnt-rentCnt) * (defprice * arr.length))));
            $("#usrAmt").html(setComma(Number($("#opt_price").val())));
        }else{
            if(amount <= 0){
                $("#usrAmt").html(0);
            }
            $("#opt_price").val(0);
            $("#usrAmt").html(0);
        }

        $("#rsvTime").val(arr[0] + ":00 ~ " + Number(Number(arr[arr.length-1])+1) + ":00");
        $("#times").val(arr);
        $("#rent_amount").val(Number(amount * arr.length));

        console.log($("#def_time").val());

        // $("#opt_price").val(Number(amount * arr.length) * Number($("#def_price").val()));

        /*$("#rentAmt").html("");
        $("#rentAmt").html(setComma(Number($("#rent_amount").val())));

        $("#amount").html("");
        $("#amount").html(setComma(Number($("#opt_price").val()) + Number(amount * arr.length)));*/

        setAmount('opt');
    }

    function setComma(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function setAmount(gubun){
        let opt = "";
        let amount = 0;
        let total = 0;
        let etcAmt = $("#equipAmt").val();
        let eqAmt = $("#eq_price").val();
        let usrAmt = $("#opt_price").val();
        let preDepoAmt = $("#depoAmt").val();
        let saleAmt = $("#salesAmt").val();
        let addAmt = $("#addedAmt").val();
        let vat = 0;
        let payType = $("#payType :selected").val();

        console.log("etcAmt [" + etcAmt + "]");
        console.log("eqAmt [" + eqAmt + "]");
        console.log("usrAmt [" + usrAmt + "]");
        console.log("saleAmt [" + saleAmt + "]");

        if(gubun == 'opt'){

            $("[name=options]").each(function(){
                if($(this).is(":selected")){
                    opt = $(this).attr("id");
                    opt = opt.replace("radio_", "");

                    if(opt == "photo"){
                        amount = Number($("#pic_price").val());
                    }else if(opt == "video"){
                        amount = Number($("#vid_price").val());
                    }
                }
            });

            arr = $("#times").val().split(',');
            total = Number(amount * arr.length);

            $("#rentAmt").html("");
            $("#rentAmt").html(setComma(total));
            $("#rent_amount").val(total);

            if( usrAmt > 0 ){
                total += Number(usrAmt);
            }

            if( etcAmt > 0 ){
                total += Number(etcAmt);
            }

            if( eqAmt > 0 ){
                total += Number(eqAmt);
            }

            if(saleAmt > 0){
                total -= Number(saleAmt);
                $("#ts_sale_area").show();
                $("#ts_sale_price").html("");
                $("#ts_sale_price").html("-"+setComma(saleAmt));
            }else{
                $("#ts_sale_area").hide();
                $("#ts_sale_price").html("");
            }

            if(addAmt > 0){
                total += Number(addAmt);
            }

            //total -= preDepoAmt;

            $("#tot_amount").val(total);

            $("#ts_price").html("");
            $("#ts_price").html(setComma(total));

            if(payType != "basic"){
                vat = total * 0.10;
                total = total + vat;

                $("#rsvVat").html("");
                $("#rsvVat").html(setComma(vat));
                $("#vat_area").show();
                $("#vat_amount").val(vat);

                if(payType == 'company'){
                    $("#compImg_area").show();
                }else{
                    $("#compImg_area").hide();
                }
            }else{
                $("#compImg_area").hide();
                $("#vat_area").hide();
            }

            $("#amount").html("");
            $("#amount").html(setComma(total));

        }
    }

    function fn_alert(gubun){
        if(gubun == "dateOver"){
            alert('변경 가능 일자가 지났습니다.');
        }
    }

    function isEmpty(str){
        if(typeof str == "undefined" || str == null || str == "")
            return true;
        else
            return false ;
    }


    function fn_confirm(){
        var result = confirm("메일을 발송하시겠습니까? 자동으로 예약 완료처리가 됩니다. 이후에는 다시 재발송이 불가능합니다. ");
        if(result){
            $.ajax({
                url:'/rsv/rsvConfirm',
                type:'post',
                data: {"seqNo" : $("#mstSeqNo").val(), "mailAddr" : $("#usrMail").val()},
                success:function(data){
                    if(data.resultCode == "300"){
                        alert("메일이 발송되었습니다.");
                        location.reload();
                    }
                }
            })


        }
    }

    function fn_delete(){
        var result = confirm("정말로 삭제하시겠습니까? 이후에는 복구가 불가능합니다. ");
        if(result){
            $.ajax({
                url:'/rsv/rsvDelete',
                type:'post',
                data: {"seqNo" : $("#mstSeqNo").val()},
                success:function(data){
                    if(data.resultCode == "300"){
                        alert("정상적으로 삭제 되었습니다.");
                        location.href="/admin/rsv/list";
                    }
                }
            })
        }
    }

    function getEquip(no, pcode, lv){
        $.ajax({
            url:'/rsv/eqInfo',
            type:'post',
            data: {"rentNo" : no, "pcode" : pcode},
            success:function(data){
                if(lv == 1){
                    let htmls = "";

                    htmls = "<option value=''>장비 분류</option>";
                    for(var i = 0; i < data.length; i++){
                        //console.log(data[i].codeNo);
                        htmls += "<option value='"+ data[i].codeNo +"' >"+ data[i].codeNm +"</option>";
                    }

                    $.ajax({
                        url: '/rsv/eqPreInfo',
                        type: 'post',
                        data: {"rentNo": no},
                        success: function (data) {
                            eqArr = [];
                            eqPrArr = [];

                            for(var i=0; i < data.length; i++){
                                eqArr[i] = data[i].codeNo;
                                eqPrArr[i] = data[i].amount;
                            }
                        }
                    });

                    $("#eq_lv_1").html("");
                    $("#eq_lv_1").append(htmls);

                }else if(lv == 2){
                    let htmls = "";

                    htmls = "<option value=''>품목 선택</option>";
                    for(var i = 0; i < data.length; i++){
                        htmls += "<option id='"+ data[i].codeNo +"' value='"+ data[i].amount +"' >"+ data[i].codeNm +"</option>";
                    }


                    $("#eq_lv_2").html("");
                    $("#eq_lv_2").append(htmls);
                }
            }
        })
    }


    $("#eq_lv_1").change(function(){

        if(isEmpty($("#rentNo").val())){
            alert("스튜디오를 먼저 선택해주세요.");
            return false;
        }else if(arr.length <= 0){
            alert("시간을 먼저 선택해주세요.");

            $("#eq_lv_1 option:first").attr("selected", "true");

            return false;
        }

        getEquip($("#rentNo").val(), $(this).val(), 2);
    });

    $("#eq_lv_2").change(function(){
        if($(this).val() != "" && $(this).val() != undefined){
            let htmls = "";

            console.log('---- eqLv2 [' + $("#eq_lv_1 :selected").val() + "]");
            console.log($("#eq_lv_1 :selected").val())
            console.log('---------------------')
            if($("#eq_lv_1 :selected").val() != 5 && $("#eq_lv_1 :selected").val() != 11){
                htmls = "<option value=''>대여 시간 선택</option>";
                for(var i = 0; i < 12; i++){
                    htmls += "<option id='"+ Number(i+1) +"' >"+ Number(i+1) + "시간</option>";
                }
            }else{
                htmls = "<option value=''>대여 수량 선택</option>";
                for(var i = 0; i < 20; i++){
                    htmls += "<option id='"+ Number(i+1) +"' >"+ Number(i+1) + "개</option>";
                }
            }


            $("#eq_lv_3").html("");
            $("#eq_lv_3").append(htmls);
        }
    });

    $("#eq_lv_3").change(function(){
        if($(this).val() != "" && $(this).val() != undefined){

            if($("#eq_lv_1 :selected").val() == "" || $("#eq_lv_1 :selected").val() == undefined){
                alert('장비 분류를 선택해야 합니다.');
                return false;
            }else if($("#eq_lv_2 :selected").val() == "" || $("#eq_lv_2 :selected").val() == undefined){
                alert('품목을 선택해야 합니다.');
                return false;
            }

            let selNo = $("#eq_lv_2 :selected").attr('id');

            const idx = eqSelArr.findIndex(function(item) {
                return Number(item) === Number(selNo)
            });

            if (idx > -1) eqSelArr.splice(idx, 1);
            if (idx > -1) eqSelTimArr.splice(idx, 1);
            if (idx > -1) eqSelNmArr.splice(idx, 1);
            $("#eq_a_" + selNo).remove();

            let htmls = "";
            let eqNm = $("#eq_lv_2 :selected").html();

            eqSelArr[eqSelArr.length] = $("#eq_lv_2 :selected").attr('id');
            eqSelTimArr[eqSelTimArr.length] = $("#eq_lv_3 :selected").attr('id');
            setEqPrice();

            $("#eq_sel_div").show();
            $("#eq_select_div").removeClass("eq_bt");
            $("#eq_select_div").css("padding-bottom", "0px");

            if($("#eq_lv_1 :selected").val() != 5 && $("#eq_lv_1 :selected").val() != 11) {
                htmls = "<a class='eq' id='eq_a_" + $("#eq_lv_2 :selected").attr('id') + "' onmouseover='addEqImg(" + $("#eq_lv_2 :selected").attr('id') + ")' onmouseout='rmEqImg(" + $("#eq_lv_2 :selected").attr('id') + ")' onclick='deleteEq(" + $("#eq_lv_2 :selected").attr('id') + ");'  style='font-size:12px; margin-right:10px;' id='" + $("#eq_lv_2 :selected").attr('id') + "' '>" + eqNm.substring(0, eqNm.indexOf('(')) + "* " + $(this).val() + ",<img class='eq_on eqNo_" + $("#eq_lv_2 :selected").attr('id') + "' src='http://adozstudio.com/static/upload/common/close.png' /></a>";
                eqSelNmArr[eqSelNmArr.length] = eqNm.substring(0, eqNm.indexOf('(')) + "* " + $(this).val();
            }else{
                htmls = "<a class='eq' id='eq_a_" + $("#eq_lv_2 :selected").attr('id') + "' onmouseover='addEqImg(" + $("#eq_lv_2 :selected").attr('id') + ")' onmouseout='rmEqImg(" + $("#eq_lv_2 :selected").attr('id') + ")' onclick='deleteEq(" + $("#eq_lv_2 :selected").attr('id') + ");'  style='font-size:12px; margin-right:10px;' id='" + $("#eq_lv_2 :selected").attr('id') + "' '>" + "배경지 * " + $(this).val() + ",<img class='eq_on eqNo_" + $("#eq_lv_2 :selected").attr('id') + "' src='http://adozstudio.com/static/upload/common/close.png' /></a>";
                eqSelNmArr[eqSelNmArr.length] = "배경지" + " * " + $(this).val() ;
            }
            $("#eq-div").append(htmls);

            console.log(eqSelNmArr)

            $("#eq_lv_1 option:first").attr("selected", "true");
            $("#eq_lv_2 option:first").attr("selected", "true");
            $("#eq_lv_3 option:first").attr("selected", "true");
        }
    });

    function setEqPrice(){
        var amount = 0;

        for(var k=0; k < eqArr.length; k++){
            for(var i=0; i < eqSelArr.length; i++){
                /*console.log(eqArr[k]);
                console.log(eqSelArr[i]);*/
                if(eqSelArr[i] == eqArr[k]){
                    amount = Number(amount + Number(eqSelTimArr[i]) * Number(eqPrArr[k]));
                }
            }
        }

        $("#eq_price").val(amount);
    };

    function addEqImg(no){
        console.log($("#eq_a_" + no).width());
        var wd = Number($("#eq_a_" + no).width() / 2) + 10;
        $(".eqNo_" + no).css("margin-left", wd * -1);
        $(".eqNo_" + no).show();
    }

    function rmEqImg(no){
        $(".eqNo_" + no).hide();
    }

    function deleteEq(no){
        const idx = eqSelArr.findIndex(function(item) {
            return Number(item) === no
        });

        console.log('---- find idx [' + idx +']');
        if (idx > -1) eqSelArr.splice(idx, 1);
        if (idx > -1) eqSelTimArr.splice(idx, 1);
        if (idx > -1) eqSelNmArr.splice(idx, 1);

        $("#eq_a_" + no).remove();
        setEqPrice();

        if(arr.length > 0){
            setAmount('opt');
        }else{
            setAmount();
        }

        if(eqSelArr <= 0){
            $("#eq_sel_div").hide();
            $("#eq_select_div").addClass("eq_bt");
            $("#eq_select_div").css("padding-bottom", "20px");
        }

    }



</script>
