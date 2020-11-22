<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="common/admCommon.jsp" %>
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
<%@ include file="common/admHeader.jsp" %>
<div class="app-main">
    <%@ include file="common/admLnb.jsp" %>
    <div class="app-main__outer">
    <div class="app-main__inner">
        <div class="row">
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content bg-midnight-bloom">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">Total Reservation</div>
                            <div class="widget-subheading">This year</div>
                        </div>
                        <div class="widget-content-right">
                            <div class="widget-numbers text-white"><span>${rtrnData.totalRsvCnt}</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content bg-arielle-smile">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">Total Reservation Revenue</div>
                            <div class="widget-subheading">Reservation Fixed or wait</div>
                        </div>
                        <div class="widget-content-right">
                            <fmt:formatNumber type="number" maxFractionDigits="3" value="${rtrnData.totalRsvAmt}" var="totalRsvAmt"/>
                            <div class="widget-numbers text-white"><span>₩ ${totalRsvAmt}</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content bg-grow-early">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">Increase in sales %</div>
                            <div class="widget-subheading">Only This years</div>
                        </div>
                        <div class="widget-content-right">
                            <div class="widget-numbers text-white"><span>0%</span></div>
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
                            월별 예약 통계
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
<script src="/static/admin/js/canvasjs.min.js"></script>
<script type="text/javascript">
    <c:forEach var="grpData" items="${rtrnGrpData}" varStatus="grpStatus">
        console.log('<c:out value="${grpData.rentNm}" />');
    </c:forEach>
    window.onload = function () {
        var chart = new CanvasJS.Chart("chartContainer", {
            theme: "light2",
            data: [
                <c:forEach var="grpData" items="${rtrnGrpData}" varStatus="status">
                {
                    type: "column",
                    name: "${grpData.rentNm}",
                    showInLegend: true,
                    dataPoints: [
                        <c:forEach var="grpPrice" items="${grpData.price}" varStatus="prStatus">
                        { label: "${grpData.months[prStatus.count - 1]} 월", y: ${grpPrice} },
                        </c:forEach>
                    ]
                },
                </c:forEach>

            ],
            /** Set axisY properties here*/
            axisY:{
                prefix: "₩",
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