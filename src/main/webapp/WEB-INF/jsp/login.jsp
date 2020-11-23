<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="common/Common.jsp" %>
    <body>
    <div class="app-container app-theme-white body-tabs-shadow">
        <form id="loginForm" name="loginForm" action="/login" method="post">
        <div class="app-main" style="margin:auto;">
            <div class="app-main__outer">
                <div class="app-main__inner">
                    <div class="row">
                        <div class="col-md-12 mt-5">
                            <div class="col-md-6">
                                <div class="position-relative form-group">
                                    <label for="id" class="" style="font-weight:bold; font-size:28px;">KOREA ADMINISTRATOR</label>
                                </div>
                            </div>
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
                                    <a class="mt-2 btn " id="login" style="width:100%; color:#fff; background-color: #0c0b0f;">Login</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
    </body>
</html>

<script type="text/javaScript">
    $(document).ready(function(){
        $(".bgImg").fadeIn("7000");

        $("#login").click(function(){

            console.log("wwww?");
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
                    console.log(data);
                    alert(data.message);
                }
            })
        })

    });

</script>