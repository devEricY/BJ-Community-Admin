<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="common/Common.jsp" %>
<%@ include file="common/loginCheck.jsp" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>AㆍdozStudio Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" />
    <meta name="description" content="This is an example dashboard created using build-in elements and components.">
    <meta name="msapplication-tap-highlight" content="no">
</head>
<body>
<%@ include file="common/Header.jsp" %>
<div class="app-main">
    <%@ include file="common/Lnb.jsp" %>
    <div class="app-main__outer">
    <div class="app-main__inner">
        <div class="row">
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content bg-premium-dark">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">올해 총 가입자</div>
                            <div class="widget-subheading">This year</div>
                        </div>
                        <div class="widget-content-right">
                            <div class="widget-numbers text-warning"><span id="peopleCnt">${rtrnData.memberCnt}</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content bg-premium-dark">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">올해 등록된 게시글</div>
                            <div class="widget-subheading">Board Count</div>
                        </div>
                        <div class="widget-content-right">
                            <%--<fmt:formatNumber type="number" maxFractionDigits="3" value="${rtrnData.totalRsvAmt}" var="totalRsvAmt"/>--%>
                            <div class="widget-numbers text-warning"><span id="boardCnt">${rtrnData.boardCnt}</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-lg-8">
                <div class="mb-3 card">
                    <div class="card-header-tab card-header-tab-animation card-header">
                        <div class="card-header-title">
                            <i class="header-icon lnr-apartment icon-gradient bg-love-kiss"> </i>
                            최근 10일 게시글 현황
                        </div>
                    </div>

                    <div class="card-body">
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="tabs-eg-77">
                                <div class="card mb-3 widget-chart widget-chart2 text-left w-100">
                                    <div class="widget-chat-wrapper-outer">
                                        <div class="widget-chart-wrapper widget-chart-wrapper-lg opacity-10 m-0">
                                            <div id="chartContainer" style="height: 400px; width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</body>
</html>
<script src="/static/js/canvasjs.min.js"></script>

<script type="text/javascript">
    window.onload = function () {
        var chart = new CanvasJS.Chart("chartContainer", {
            theme: "light2",
            data: [
                {
                    type: "column",
                    name: "게시글",
                    dataPoints: [
                        <c:forEach var="rtrnGrpData" items="${rtrnGrpData}" varStatus="rtrnStatus" >
                        { label: "${rtrnGrpData.reg_date}", y: ${rtrnGrpData.boardCnt} },
                        </c:forEach>
                    ]
                },

            ],
            /** Set axisY properties here*/
            axisY:{
                prefix: "+",
                includeZero: false
            },
            legend: {
                horizontalAlign: "center", // left, center ,right
                verticalAlign: "top",  // top, center, bottom
            }
        });

        chart.render();
    }
</script>


<script type="text/javascript">
    var memberCountConTxt= ${rtrnData.memberCnt};
    var boardCountConTxt= ${rtrnData.boardCnt};

    $({ val : 0 }).animate({ val : memberCountConTxt }, {
        duration: 1000,
        step: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#peopleCnt").text(num);
        },
        complete: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#peopleCnt").text(num);
        }
    });

    $({ val : 0 }).animate({ val : boardCountConTxt }, {
        duration: 1000,
        step: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#boardCnt").text(num);
        },
        complete: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#boardCnt").text(num);
        }
    });


    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
</script>