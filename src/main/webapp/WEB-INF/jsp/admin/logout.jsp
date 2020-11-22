<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
 session.removeAttribute("admUsrId");
 session.removeAttribute("admUsrNm");
 session.invalidate();
%>


<script type="text/javaScript"> alert('로그아웃 되었습니다.'); location.href="/admin/login"; </script>