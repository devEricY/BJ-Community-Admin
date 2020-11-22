<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="common/common.jsp" %>
<head>
    <link href="/static/css/jquery.bxslider.css" rel="stylesheet" />
    <script src="/static/js/jquery.bxslider.js"></script>
    <style>
        .contents{padding-top:30px;}
        .main-slide{text-align: center; }
        .bx-wrapper{-webkit-box-shadow:0 0 0px #fff;}
        .bx-pager.bx-default-pager{bottom:55px; margin-top:-60px; padding-top:0px;}
        /*.bx-wrapper .bx-pager.bx-default-pager a{background: #fff;}*/

        <c:if test="${!isMobile}" >
            .contents{width: 100%; margin-bottom:130px;}
            .bxslider img{min-height: 941px; height: 1080px; width: 100%;}

        </c:if>

        @media all and (min-width:1620px) and (max-width:1800px) {
            .bxslider img{ min-height: auto; height: 1080px; width: 100%;}
        }

        @media all and (min-width:1435px) and (max-width:1619px) {
            .bxslider img{ min-height: auto; height: auto; width: 100%;}
        }

        @media all and (min-width:1200px) and (max-width:1434px) {
            .bxslider img{ min-height: auto; height: auto; width: 100%;}
        }

        @media all and (min-width:1100px) and (max-width:1200px) {
            .bxslider img{ min-height: auto; height: auto; width: 100%;}
        }

        @media all and (max-width:1100px) {
            .bxslider img{ min-height: auto; height: auto; width: 100%;}
        }

        <c:if test="${isMobile}" >
        .contents{width: 100%; }
        .bxslider img{min-height: 250px; height: 250px;}
        .bx-pager.bx-default-pager{bottom:20px; padding-top:0px;}
        footer div{padding-top:0px !important;}
        </c:if>



    </style>
</head>

<body>
    <%@ include file="common/header.jsp" %>
    <div class="contents">
        <div class="main-slide">
            <ul class="bxslider">
                <c:forEach var="images" items="${images}" varStatus="status" >
                    <li><img src="${images}" /></li>
                </c:forEach>
            </ul>
        </div>
        <!-- <div class="main-slide">
            <video width="100%" controls muted autoplay>
                <source src="/static/video/freakme.mp4" type="video/mp4" >
            </video>
        </div>
        <div class="main-slide">
            <video width="100%" controls muted autoplay>
                <source src="/static/video/knowi6.mp4" type="video/mp4" >
            </video>
        </div> -->
    </div>


</body>
<%@ include file="common/footer.jsp" %>
</html>

<script type="text/javascript">
    $(document).ready(function(){
        $('.bxslider').bxSlider(
            {
                auto: true, speed: 1000, pause: 8000, mode:'fade', autoControls: false, pager:true
            }
        );
    });
</script>