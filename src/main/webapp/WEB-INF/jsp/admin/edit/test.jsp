<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/admCommon.jsp" %>
<head>
    <style>
        .container {
            display: block;
            position: relative;
            padding-left: 35px;
            margin-bottom: 12px;
            cursor: pointer;
            font-size: 22px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        /* Hide the browser's default checkbox */
        .container input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
            height: 0;
            width: 0;
        }

        /* Create a custom checkbox */
        .checkmark {
            position: absolute;
            top: 0;
            left: 0;
            height: 25px;
            width: 25px;
            background-color: #eee;
        }

        /* On mouse-over, add a grey background color */
        .container:hover input ~ .checkmark {
            background-color: #ccc;
        }

        /* When the checkbox is checked, add a blue background */
        .container input:checked ~ .checkmark {
            background-color: #2196F3;
        }

        /* Create the checkmark/indicator (hidden when not checked) */
        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }

        /* Show the checkmark when checked */
        .container input:checked ~ .checkmark:after {
            display: block;
        }

        /* Style the checkmark/indicator */
        .container .checkmark:after {
            left: 9px;
            top: 5px;
            width: 5px;
            height: 10px;
            border: solid white;
            border-width: 0 3px 3px 0;
            -webkit-transform: rotate(45deg);
            -ms-transform: rotate(45deg);
            transform: rotate(45deg);
        }
    </style>

</head>
<body>
<div class="app-main">
    <div class="app-main__outer">
        <div class="app-main__inner">
            <div class="app-page-title">
                <div class="page-title-wrapper">
                    <div class="page-title-heading">
                        <div class="page-title-icon">
                            <i class="pe-7s-video text-success icon-gradient bg-happy-fisher">
                            </i>
                        </div>
                        <div>현봉 테스트
                            <div class="page-title-subheading">Input에 대한 Check 값을 가져오는 시간
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="main-card mb-3 card">
                        <div class="card-body">
                            <h5 class="card-title">Input box List</h5>
                            <c:forEach var="item" items="${prList}">
                                <label class="container">${item.prNm}
                                    <input type="checkbox" name="checkbox" value="${item.price}" data-seqNo="${item.seqNo}" data-prNm="${item.prNm}">
                                    <span class="checkmark"></span>
                                </label>
                            </c:forEach>

                            <a class="btn btn-secondary text-white float-left btn-shadow" onclick="fn_getBucket();">장바구니 확인</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

<script type="text/javaScript">
    function fn_getBucket(){
        console.clear();
        $("input[name=checkbox]").each(function(){
            if($(this).prop("checked")){
                console.log(" 선택 항목 상품 명 : " + $(this).attr("data-prNm"));
                console.log(" 선택 항목 seqNo : " +$(this).attr("data-seqNo"));
            }
        });

    }
</script>