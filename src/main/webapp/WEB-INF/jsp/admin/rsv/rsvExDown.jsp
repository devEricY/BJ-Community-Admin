<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    response.setHeader("Content-Disposition","attachment;filename=rsvData.xls");
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<html lang="ko">
    <body>
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>성함(업체명)</th>
                    <th>장소</th>
                    <th>입금자명</th>
                    <th>연락처</th>
                    <th>예약일자</th>
                    <th>예약상태</th>
                    <th>촬영내용</th>
                    <th>이용날짜 및 시간</th>
                    <th>예약 인원 수</th>
                    <th>방문 차량 수</th>
                    <th>예약 옵션</th>
                    <th>렌트 예약 금액</th>
                    <th>추가 인원 금액</th>
                    <th>장비 사용 금액</th>
                    <th>vat</th>
                    <th>총 이용금액</th>
                    <th>예약금 입금날짜</th>
                    <th>예약금 입금금액</th>
                    <th>결제 완료 날짜</th>
                    <th>예약금 환급 날짜</th>
                    <th>비고 사항</th>
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
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.rentAmt}" var="rentAmt"/>
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.usrAmt}" var="usrAmt"/>
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.etcAmt}" var="etcAmt"/>
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.predepo_amt}" var="predepo_amt"/>
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.vat}" var="vat"/>
                    <tr>
                        <th scope="row" name="order_num">${rsvList.rownum}</th>
                        <td>${rsvList.usrNm} (${rsvList.compNm})</td>
                        <td>${rsvList.subNm}</td>
                        <td>${rsvList.depoNm}</td>
                        <td>${rsvList.phoneNo}</td>
                        <td>${rsvList.reg_date}</td>
                        <td>
                            <c:choose>
                                <c:when test="${rsvList.status eq 'R'}">예약완료</c:when>
                                <c:when test="${rsvList.status == 'W'}">입금대기</c:when>
                                <c:when test="${rsvList.status eq 'C'}">예약취소</c:when>
                            </c:choose>
                        </td>
                        <td>${rsvList.rsv_cont}</td>
                        <td>${rsvList.str_date}
                            <c:if test="${timeList[status.count-1][0] < 10}">
                                0${timeList[status.count-1][0]}
                            </c:if>
                            <c:if test="${timeList[status.count-1][0] >= 10}">
                                ${timeList[status.count-1][0]}
                            </c:if>
                            ~
                            <c:if test="${timeList[status.count-1][fn:length(timeList[status.count-1])-1] < 10}">
                                0${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1}
                            </c:if>
                            <c:if test="${timeList[status.count-1][fn:length(timeList[status.count-1])-1] >= 10}">
                                ${timeList[status.count-1][fn:length(timeList[status.count-1])-1] + 1}
                            </c:if>
                            (${fn:length(timeList[status.count-1])})</td>
                        <td>${rsvList.usrcnt}</td>
                        <td>${rsvList.carcnt}</td>
                        <td style="text-align: center">
                            <c:choose>
                                <c:when test="${rsvList.rsv_opt == 'video'}">사진</c:when>
                                <c:when test="${rsvList.rsv_opt == 'photo'}">영상</c:when>
                            </c:choose>
                        </td>
                        <td>${rentAmt}</td>
                        <td>${usrAmt}</td>
                        <td>${etcAmt}</td>
                        <td>${vat}</td>
                        <td>${rsv_price}</td>
                        <td>${rsvList.predepo_date}</td>
                        <td>${predepo_amt}</td>
                        <td>${rsvList.paymnt_date}</td>
                        <td>${rsvList.cancel_date}</td>
                        <td>${rsvList.etctxt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>