<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="../common/admCommon.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>

<%
    String mstSeqNo = request.getParameter("seqNo");
%>

<c:if test="${resultCode == '700'}">
    <script type="text/javascript"> alert("정상적으로 수정이 완료되었습니다."); location.href="/admin/rsv/rsvInfo?seq=${seq}"</script>
</c:if>

<c:if test="${resultCode == '000'}">
    <script>alert('답변중 문제가 발생하였습니다. 관리자에게 문의해주세요.'); location.href="/admin/rsv/rsvInfo?seq=${seq}"</script>
</c:if>