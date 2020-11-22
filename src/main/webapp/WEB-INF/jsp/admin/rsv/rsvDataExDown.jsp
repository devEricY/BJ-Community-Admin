<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    response.setHeader("Content-Disposition","attachment;filename=rsvGrpData.xls");
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<html lang="ko">
    <body>
        <table>
            <thead>
                <tr>
                    <th>성함</th>
                    <th>연락처</th>
                    <th>이메일</th>
                    <th>마지막 방문 날짜</th>
                    <th>사진</th>
                    <th>영상</th>
                    <th>취소</th>
                    <th>총 방문 횟수</th>
                    <th>총 이용금액</th>
                </tr>
            </thead>
            <tbody id="option_cont">
                <c:forEach var="rsvList" items="${rsvList}" varStatus="status">
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${rsvList.rentAmt}" var="rentAmt"/>
                    <tr>
                        <td>${rsvList.usrNm}</td>
                        <td>${rsvList.phoneNo}</td>
                        <td>${rsvList.email}</td>
                        <td>${rsvList.rsv_day}</td>
                        <td>${rsvList.v_cnt}</td>
                        <td>${rsvList.p_cnt}</td>
                        <td>${rsvList.c_cnt}</td>
                        <td>${rsvList.t_cnt}</td>
                        <td>${rentAmt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>