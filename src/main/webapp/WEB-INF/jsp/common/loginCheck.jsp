<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String usrId = (String) session.getAttribute("admUsrId");

    if(usrId == null){
%>
<script type="text/javaScript"> alert('로그인이 필요합니다'); location.href="/login"; </script>
<%
    }
%>