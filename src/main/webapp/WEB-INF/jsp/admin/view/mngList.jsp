<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="../common/admCommon.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    <head>
      <style>
            .bgImg{display:none; position:absolute;}
            .contents{width:100%; position:absolute; padding-top:175px; padding-left:66%;}

            #id{width:300px;}
            #password{width:300px;}
            #login{width:300px; color:#fff;}
            .upload-img img{transition: all ease 0.2s;}
            .upload-img img:hover{transform: scale( 0.9 );}
            .upload-img i.pick_on{font-size:3.65rem; background-image:linear-gradient(180deg, #ffd400 0%, #009efd 100%) !important; margin-top:17%;}
            .pick_div {background-color:#00000099; width:84%; height:84%; position:absolute; z-index:999;}
            .paging-div li{float:left; padding:5px 10px; background-color:#fff; border:1px solid #dee2e6; line-height: 1.25; margin-left:5px; color:#007bff; font-size:16px;}
            .paging-div li:first-child{margin-left:0px;}
            .paging-div li.on{background-color:#3f6ad8; border-color:#007bff; }
            .paging-div li.on a{color: #fff; }
            a.infoLike{text-decoration:none; color:#000 !important;}

            @media all and (min-width:768px) and (max-width:1604px) {
                .upload-img i.pick_on{font-size:3.35rem;  margin-top:7%;}
                .pick_div{width:77%; height:80%;}
                .pe-7s-plus{margin-top:7%;}
            }

      </style>
    </head>
    <body>
        <form id="mngListForm" name="mngListForm" method="get">

            <%@ include file="../common/admHeader.jsp" %>
            <div class="app-main">
                <%@ include file="../common/admLnb.jsp" %>
                    <div class="app-main__outer">
                        <div class="app-main__inner">

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">ADMIN MANAGEMENT</h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                <table class="mb-0 table table-hover">
                                                    <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>아이디</th>
                                                        <th>이름</th>
                                                        <th>계정권한</th>
                                                        <th>PW실패 횟수</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="option_cont">
                                                    <c:if test="${mngListCnt <= 0}" >
                                                        <tr>
                                                            <td colspan="5" style="text-align: center;">데이터가 존재하지 않습니다.</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="mngList" items="${mngList}" varStatus="status">
                                                        <c:if test="${status.count > 0}" >
                                                            <tr>
                                                                <td scope="row" name="order_num">${mngList.rownum}</td>
                                                                <td><a class="infoLike" >${mngList.usrId}</a></td>
                                                                <td><a class="infoLike" >${mngList.usrNm}</a></td>
                                                                <c:if test="${mngList.auth eq 1}">
                                                                    <td>시스템 관리자</td>
                                                                </c:if>
                                                                <c:if test="${mngList.auth ne 1}">
                                                                    <td>시스템 매니저</td>
                                                                </c:if>
                                                                <td>${mngList.failCnt}<a class="btn btn-secondary text-white btn-shadow ml-3" onclick="fn_submit('${mngList.usrId}');">초기화</a></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <div class="paging-div" style="width: 100%;">
                                    <ul style="list-style: none;height: 30px;display: inline-block;padding-left: 0px;padding-right: 0px;margin-right: 0px;margin-left: 0px;">

                                        <c:if test="${pageMaker.prev}">
                                            <li>
                                                <a href='<c:url value="/admin/mngList?page=${pageMaker.startPage-1 }"/>'><</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
                                            <c:if test="${curPage == pageNum}" >
                                                <li class="on">
                                                    <a href='<c:url value="/admin/mngList?page=${pageNum}"/>'>${pageNum}</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${curPage != pageNum}" >
                                                <li>
                                                    <a href='<c:url value="/admin/mngList?page=${pageNum}"/>'>${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
                                            <li>
                                                <a href='<c:url value="/admin/qnaList?page=${pageMaker.endPage+1 }"/>'> > </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>


                        </div>
                    </div>
             </div>

        </form>
        <div id="pick_onDiv" style="display:none;"><div class="pick_div" onClick="fn_pickOff(this);" ><i class="pe-7s-check icon-gradient bg-happy-itmeo pick_on"> </i></div></div>
        <iframe id="sbIframe" name="sbIframe" style="border:0px; width:0px; height:0px;"> </iframe>
    </body>
</html>

<script type="text/javascript">
    function fn_submit(target){
        var result = confirm("정말로 초기화 하시겠습니까?");
        if(result){

            $.ajax({
                url:'/admin/admFailReset',
                type:'get',
                data: {"target" : target},
                success:function(data){
                    if(data.flag == "100"){
                        alert("초기화가 성공적으로 완료되었습니다.");
                        location.reload();
                    }else{
                        alert("초기화가 실패하였습니다. 관리자에게 문의해주세요.");
                    }
                }
            })

        }else{
            return false;
        }

    }

</script>
