<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="common/Common.jsp" %>
    <body style="background-image: linear-gradient(to right, #434343 50%, black 100%) !important">
    <form id="loginForm" name="loginForm" action="/login" method="post">
        <div style="width: 30%; margin:auto; padding-top:150px;">
            <div class="col-md-12 mt-5">
                <div>
                    <div class="position-relative form-group text-warning">
                        <label for="id" class="" style="font-weight:bold; font-size:28px;">KOREA ADMINISTRATOR</label>
                    </div>
                </div>
                <div style="width: 100%;">
                    <div class="position-relative form-group text-white">
                        <label for="id" class="" style="font-weight:bold;">ID</label>
                        <input name="id" id="id" placeholder="Enter your id" type="id" class="form-control">
                    </div>
                </div>
                <div style="width: 100%;">
                    <div class="position-relative form-group text-white">
                        <label for="password" class="" style="font-weight:bold;">Password</label>
                        <input name="password" id="password" placeholder="Enter your password" type="password" class="form-control">
                    </div>
                </div>
                <div style="width: 100%;">
                    <div class="position-relative form-group">
                        <a class="mt-2 btn " id="login" style="width:100%; color:#fff; background-color: #e2a40c; font-weight: bold;">Login</a>
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

            var formData = $("form[name=loginForm]").serialize() ;

            $.ajax({
                url:'/Login',
                type:'POST',
                data: formData,
                success:function(data){
                    if(data.code == "200"){
                        location.href="/";
                    }else{
                        alert(data.message);
                    }
                }
            })
        })

    });

</script>