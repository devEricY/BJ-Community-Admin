<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<%@ include file="../common/admCommon.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>

<c:if test="${resultFlag != 7}">
        <script type="text/javaScript">alert("${resultMsg}")</script>
</c:if>
<c:if test="${resultFlag == 7}">
        <script type="text/javaScript">alert("${resultMsg}"); location.href="/admin/dashboard"</script>
</c:if>

</html>

