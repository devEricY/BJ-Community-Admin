<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="common/admCommon.jsp" %>
    <head>
       <style>
            .bgImg{display:none; position:absolute;}
            .contents{width:100%; position:absolute; padding-top:175px; padding-left:66%;}
            .card-body{width:370px; height:270px; background-color:#fff0;}

            #id{width:300px;}
            #password{width:300px;}
            #login{width:300px; color:#fff;}
       </style>
    </head>
    <body>
        <form id="loginForm" name="loginForm" action="/admin/S_login" method="post">
        <div calss="login-area">
            <img class="bgImg" src="/static/admin/img/login_bg.png" />
            <div class="contents">
                <label style="font-weight:bold; font-size:30px;">AdozStudio Administrator</label>
                 <div class="card card-body">
                   <div>
                       <div class="col-md-6">
                           <div class="position-relative form-group">
                               <label for="id" class="" style="font-weight:bold;">ID</label>
                               <input name="id" id="id" placeholder="Enter your id" type="id" class="form-control">
                           </div>
                       </div>
                       <div class="col-md-6">
                           <div class="position-relative form-group">
                               <label for="password" class="" style="font-weight:bold;">Password</label>
                               <input name="password" id="password" placeholder="Enter your password" type="password" class="form-control">
                           </div>
                       </div>
                       <div class="col-md-6">
                          <div class="position-relative form-group">
                             <a class="mt-2 btn btn-primary" id="login">Login</a>
                          </div>
                        </div>
                   </div>
                </div>
            </div>
        </div>
        </form>
    </body>
</html>

<script type="text/javaScript">
    $(document).ready(function(){
        $(".bgImg").fadeIn("7000");

        $("#login").click(function(){
            if($("#id").val() == "" || $("#id").val() == null){
                alert("please Enter your Id");
                return;
            }else if($("#password").val() == "" || $("#password").val() == null){
                alert("please Enter your password");
                return;
            }

            $("#loginForm").method = "post";
            $("#loginForm").action = "/admin/S_login";
            $("#loginForm").submit();
        })

    });

</script>

<c:if test="${flag ne 0}">
    <script type="text/javaScript">
        var mgs = "${msg}";
        alert(mgs);
    </script>
</c:if>