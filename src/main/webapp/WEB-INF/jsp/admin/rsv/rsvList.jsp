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
            .paging-div li a{cursor:pointer; }
            .paging-div li.on{background-color:#3f6ad8; border-color:#007bff; color: #fff; }
            .paging-div li.on a{color: #fff;}
            a.infoLike{text-decoration:none; color:#000 !important;}

            @media all and (min-width:768px) and (max-width:1604px) {
                .upload-img i.pick_on{font-size:3.35rem;  margin-top:7%;}
                .pick_div{width:77%; height:80%;}
                .pe-7s-plus{margin-top:7%;}
            }

      </style>
    </head>
    <body>
        <form id="rsvListForm" name="rsvListForm" method="get">
            <c:if test="${pageNum == null}">
                <c:set var="pageNum" value="1" />
            </c:if>
            <input type="hidden" id="mstSeqNo" name="mstSeqNo" value="<%=mstSeqNo%>" />
            <input type="hidden" id="page" name="page" value="${pageNum}" />

            <%@ include file="../common/admHeader.jsp" %>
            <div class="app-main">
                <%@ include file="../common/admLnb.jsp" %>
                    <div class="app-main__outer">
                        <div class="app-main__inner">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body ">
                                            <div class="row" style="padding-left:15px; padding-right:15px; height:40px;">
                                                <div class="col-md-1">
                                                    <input  placeholder="예약자명" type="text" name="usrNm" class="form-control" value="${param.usrNm}"  >
                                                </div>
                                                <div class="col-md-1">
                                                    <input  placeholder="입금자명" type="text" name="depoNm" class="form-control" value="${param.depoNm}">
                                                </div>
                                                <div class="col-md-1">
                                                    <input  placeholder="예약번호" type="text" name="rsvCd" class="form-control" value="${param.rsvCd}">
                                                </div>
                                                <div class="col-md-1">
                                                    <input  placeholder="장소" type="text" name="rentNm" class="form-control" value="${param.rentNm}">
                                                </div>
                                                <div class="col-md-2">
                                                    <input  placeholder="연락처" type="text" name="phone" class="form-control" value="${param.phone}">
                                                </div>
                                                <div class="col-md-1">
                                                    <input  placeholder="예약일" type="text" name="reg_date" class="form-control" value="${param.reg_date}">
                                                </div>
                                                <div class="col-md-1">
                                                    <a class="mb-2 mr-2 btn btn-secondary text-white" style="width:100%; height:38px; font-size:15px;" onClick="fn_search();">검색</a>
                                                </div>
                                                <div class="col-md-1">
                                                    <a class="mb-2 mr-1 btn btn-success text-white btn-shadow" style="font-size:15px;" onClick="fn_exDown();">예약자료</a>
                                                </div>
                                                <div class="col-md-1">
                                                    <a class="mb-2 mr-1 btn btn-success text-white btn-shadow" style="font-size:15px;" onClick="fn_exGrpDown();">방문자료</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${isMobile}">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">예약정보</h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                <table class="mb-0 table table-hover">
                                                    <thead>
                                                    <tr style="text-align: center">
                                                        <th>No</th>
                                                        <th>성함</th>
                                                        <th>장소</th>
                                                        <th>결제방식</th>
                                                        <th>예약번호</th>
                                                        <th>예약상태</th>
                                                        <th>예약옵션</th>
                                                        <th>이용날짜 및 시간</th>
                                                        <%--<th>예약금 입금날짜</th>
                                                        <th>결제 완료 날짜</th>--%>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="option_cont">
                                                    <c:if test="${rsvListCnt <= 0}" >
                                                        <tr>
                                                            <td colspan="12" style="text-align: center;">데이터가 존재하지 않습니다.</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="rsvList" items="${rsvList}" varStatus="status">
                                                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.rsv_price}" var="rsv_price"/>
                                                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.vat}" var="vat"/>
                                                        <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.rsv_price + rsvList.vat}" var="rsv_totals"/>
                                                        <tr>
                                                            <th scope="row" name="order_num">${rsvList.rownum}</th>
                                                            <td><a class="infoLike" href="/admin/rsv/rsvInfo?seq=${rsvList.seqNo}">${rsvList.usrNm} <%--(${rsvList.compNm})--%></a></td>
                                                            <td><a class="infoLike" href="/admin/rsv/rsvInfo?seq=${rsvList.seqNo}">${rsvList.subNm}</a></td>
                                                            <td>${rsvList.payType}</td>
                                                            <td style="text-align: center">${rsvList.rsv_code}</td>
                                                            <td style="text-align: center">
                                                                <c:choose>
                                                                    <c:when test="${rsvList.status == 'R'}">예약완료</c:when>
                                                                    <c:when test="${rsvList.status == 'W'}">입금대기</c:when>
                                                                    <c:when test="${rsvList.status == 'C'}">예약취소</c:when>
                                                                    <c:when test="${rsvList.status == 'D'}">예약종료</c:when>
                                                                </c:choose>
                                                            </td>
                                                            <td style="text-align: center">
                                                                <c:choose>
                                                                    <c:when test="${rsvList.rsv_opt == 'video'}">영상</c:when>
                                                                    <c:when test="${rsvList.rsv_opt == 'photo'}">사진</c:when>
                                                                </c:choose>
                                                            </td>
                                                            <td>${rsvList.str_date}
                                                                    <c:if test="${timeList[status.count-1][0] < 10}">
                                                                    0${timeList[status.count-1][0]}
                                                                    </c:if>
                                                                    <c:if test="${timeList[status.count-1][0] >= 10}">
                                                                        ${timeList[status.count-1][0]}
                                                                    </c:if>
                                                                ~
                                                                    <c:if test="${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1 < 10}">
                                                                        0${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1}
                                                                    </c:if>
                                                                    <c:if test="${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1 >= 10}">
                                                                        ${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1}
                                                                    </c:if>
                                                                (${fn:length(timeList[status.count-1])})</td>
                                                            <%--<td style="text-align: center">${rsvList.predepo_date}</td>
                                                            <td style="text-align: center">${rsvList.paymnt_date}</td>--%>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            </c:if>

                            <c:if test="${!isMobile}">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="main-card mb-3 card">
                                            <div class="card-body">
                                                <h5 class="card-title">예약정보</h5>
                                                <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                    <table class="mb-0 table table-hover">
                                                        <thead>
                                                        <tr style="text-align: center">
                                                            <th>No</th>
                                                            <th>성함</th>
                                                            <th>장소</th>
                                                            <th>입금자</th>
                                                            <th>연락처</th>
                                                            <th>결제방식</th>
                                                            <th>예약번호</th>
                                                            <th>예약일자</th>
                                                            <th>예약상태</th>
                                                            <th>예약옵션</th>
                                                            <th>이용날짜 및 시간</th>
                                                            <th>총 이용금액</th>
                                                                <%--<th>예약금 입금날짜</th>
                                                                <th>결제 완료 날짜</th>--%>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="option_cont">
                                                        <c:if test="${rsvListCnt <= 0}" >
                                                            <tr>
                                                                <td colspan="12" style="text-align: center;">데이터가 존재하지 않습니다.</td>
                                                            </tr>
                                                        </c:if>
                                                        <c:forEach var="rsvList" items="${rsvList}" varStatus="status">
                                                            <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.rsv_price}" var="rsv_price"/>
                                                            <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.vat}" var="vat"/>
                                                            <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.rsv_price + rsvList.vat}" var="rsv_totals"/>
                                                            <tr>
                                                                <th scope="row" name="order_num">${rsvList.rownum}</th>
                                                                <td><a class="infoLike" href="/admin/rsv/rsvInfo?seq=${rsvList.seqNo}">${rsvList.usrNm} <%--(${rsvList.compNm})--%></a></td>
                                                                <td><a class="infoLike" href="/admin/rsv/rsvInfo?seq=${rsvList.seqNo}">${rsvList.subNm}</a></td>
                                                                <td><a class="infoLike" href="/admin/rsv/rsvInfo?seq=${rsvList.seqNo}">${rsvList.depoNm}</a></td>
                                                                <td>${rsvList.phoneNo}</td>
                                                                <td>${rsvList.payType}</td>
                                                                <td style="text-align: center">${rsvList.rsv_code}</td>
                                                                <td style="text-align: center">${rsvList.reg_date}</td>
                                                                <td style="text-align: center">
                                                                    <c:choose>
                                                                        <c:when test="${rsvList.status == 'R'}">예약완료</c:when>
                                                                        <c:when test="${rsvList.status == 'W'}">입금대기</c:when>
                                                                        <c:when test="${rsvList.status == 'C'}">예약취소</c:when>
                                                                        <c:when test="${rsvList.status == 'D'}">예약종료</c:when>
                                                                    </c:choose>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <c:choose>
                                                                        <c:when test="${rsvList.rsv_opt == 'video'}">영상</c:when>
                                                                        <c:when test="${rsvList.rsv_opt == 'photo'}">사진</c:when>
                                                                    </c:choose>
                                                                </td>
                                                                <td>${rsvList.str_date}
                                                                    <c:if test="${timeList[status.count-1][0] < 10}">
                                                                        0${timeList[status.count-1][0]}
                                                                    </c:if>
                                                                    <c:if test="${timeList[status.count-1][0] >= 10}">
                                                                        ${timeList[status.count-1][0]}
                                                                    </c:if>
                                                                    ~
                                                                    <c:if test="${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1 < 10}">
                                                                        0${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1}
                                                                    </c:if>
                                                                    <c:if test="${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1 >= 10}">
                                                                        ${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1}
                                                                    </c:if>
                                                                    (${fn:length(timeList[status.count-1])})</td>
                                                                <c:if test="${ rsvList.payType eq '일반 계좌이체'}">
                                                                    <td style="text-align: center">${rsv_price}</td>
                                                                </c:if>
                                                                <c:if test="${ rsvList.payType ne '일반 계좌이체'}">
                                                                    <td style="text-align: center">${rsv_totals}</td>
                                                                </c:if>
                                                                    <%--<td style="text-align: center">${rsvList.predepo_date}</td>
                                                                    <td style="text-align: center">${rsvList.paymnt_date}</td>--%>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${rsvListCnt > 0}" >

                            <div class="text-center">
                                <div class="paging-div" style="width: 100%;">
                                    <ul style="list-style: none;height: 30px;display: inline-block;padding-left: 0px;padding-right: 0px;margin-right: 0px;margin-left: 0px;">

                                        <c:if test="${pageMaker.prev}">
                                            <li>
                                                <a onclick="fn_pg_search(${pageMaker.startPage-1})" ><</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
                                            <c:if test="${curPage == pageNum}" >
                                                <li class="on">
                                                    <a onclick="fn_pg_search(${pageNum})" >${pageNum}</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${curPage != pageNum}" >
                                                <li>
                                                    <a onclick="fn_pg_search(${pageNum})">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
                                            <li>
                                                <a onclick="fn_pg_search(${pageMaker.endPage+1})" > > </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>

                            </c:if>


                        </div>
                    </div>
             </div>

        </form>
        <div id="pick_onDiv" style="display:none;"><div class="pick_div" onClick="fn_pickOff(this);" ><i class="pe-7s-check icon-gradient bg-happy-itmeo pick_on"> </i></div></div>
        <iframe id="sbIframe" name="sbIframe" style="border:0px; width:0px; height:0px;"> </iframe>
    </body>
</html>

<script type="text/javascript">
    function fn_search(){
        $("#page").val(1);

        var form = document.rsvListForm;
        form.target = "_self";
        form.method = "get";
        form.action = "/admin/rsv/list";
        form.submit();
    }

    function fn_pg_search(no){
        $("#page").val(no);
        var form = document.rsvListForm;
        form.target = "_self";
        form.method = "get";
        form.action = "/admin/rsv/list";
        form.submit();
    }

    function fn_submit(){
        alert("곧 업데이트될 기능입니다.");
    }

    function fn_exDown(){
        var form = document.rsvListForm;
        form.target = "_blank";
        form.method = "POST";
        form.action = "/admin/rsv/exDown";
        form.submit();
    }

    function fn_exGrpDown(){
        var form = document.rsvListForm;
        form.target = "_blank";
        form.method = "POST";
        form.action = "/admin/rsv/grpExcelDown";
        form.submit();
    }

</script>
