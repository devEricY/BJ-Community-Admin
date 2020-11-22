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
        <form id="qnaListForm" name="qnaListForm" method="get">

            <%@ include file="../common/admHeader.jsp" %>
            <div class="app-main">
                <%@ include file="../common/admLnb.jsp" %>
                    <div class="app-main__outer">
                        <div class="app-main__inner">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body ">
                                            <div class="row" style="padding-left:15px; padding-right:15px; height:40px;">
                                                <div class="col-md-2">
                                                    <input  placeholder="이름" type="text" name="name" class="form-control" value="${param.name}" >
                                                </div>
                                                <div class="col-md-2">
                                                    <input  placeholder="제목" type="text" name="title" class="form-control" value="${param.title}">
                                                </div>
                                                <div class="col-md-2">
                                                    <input  placeholder="이메일" type="text" name="email" class="form-control" value="${param.email}">
                                                </div>
                                                <div class="col-md-2">
                                                    <input  placeholder="연락처" type="text" name="phone" class="form-control" value="${param.phone}">
                                                </div>
                                                <div class="col-md-2">
                                                    <input  placeholder="문의날짜" type="text" name="regdate" class="form-control" value="${param.regDate}">
                                                </div>
                                                <div class="col-md-2">
                                                    <a class="mb-2 mr-2 btn btn-secondary text-white" style="width:100%; height:38px;" onClick="fn_search();">검색</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">문의정보</h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                <table class="mb-0 table table-hover">
                                                    <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>성함</th>
                                                        <th>제목</th>
                                                        <th>이메일</th>
                                                        <th>연락처</th>
                                                        <th>문의날짜</th>
                                                        <th>답변날짜</th>
                                                        <th>답변자</th>
                                                        <c:if test="${authCd eq 1}">
                                                            <th></th>
                                                        </c:if>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="option_cont">
                                                    <c:if test="${qnaListCnt <= 0}" >
                                                        <tr>
                                                            <c:if test="${authCd eq 1}">
                                                                <td colspan="9" style="text-align: center;">데이터가 존재하지 않습니다.</td>
                                                            </c:if>

                                                            <c:if test="${authCd ne 1}">
                                                                <td colspan="8" style="text-align: center;">데이터가 존재하지 않습니다.</td>
                                                            </c:if>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="qnaList" items="${qnaList}" varStatus="status">
                                                        <c:if test="${status.count > 0}" >
                                                            <tr>
                                                                <td scope="row" name="order_num">${qnaList.rownum}</td>
                                                                <td><a class="infoLike" href="/admin/qnaInfo?seq=${qnaList.seqNo}">${qnaList.name}</a></td>
                                                                <td><a class="infoLike" href="/admin/qnaInfo?seq=${qnaList.seqNo}">${qnaList.title}</a></td>
                                                                <td>${qnaList.email}</td>
                                                                <td>${qnaList.phone}</td>
                                                                <td>${qnaList.regDate}</td>
                                                                <td>${qnaList.ansRegDate}</td>
                                                                <td>${qnaList.ansRegId}</td>
                                                                <c:if test="${authCd eq 1}">
                                                                    <td><a class="btn btn-danger float-left text-white" style="margin-right:5px;" onclick="fn_delete('${qnaList.seqNo}');" >삭제</a></td>
                                                                </c:if>
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
                                                <a href='<c:url value="/admin/qnaList?page=${pageMaker.startPage-1 }"/>'><</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
                                            <c:if test="${curPage == pageNum}" >
                                                <li class="on">
                                                    <a href='<c:url value="/admin/qnaList?page=${pageNum}"/>'>${pageNum}</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${curPage != pageNum}" >
                                                <li>
                                                    <a href='<c:url value="/admin/qnaList?page=${pageNum}"/>'>${pageNum}</a>
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
    function fn_search(){
        var form = document.qnaListForm;
        form.target = "_self";
        form.action = "/admin/qnaList";
        form.submit();
    }

    function fn_delete(no){
        var result = confirm("정말로 삭제하시겠습니까? 이후에는 복구가 불가능합니다. ");
        if(result){
            $.ajax({
                url:'/qna/delete',
                type:'post',
                data: {"seqNo" : no},
                success:function(data){
                    if(data.resultCode == "300"){
                        alert("정상적으로 삭제 되었습니다.");
                        location.href="/admin/qnaList";
                    }
                }
            })
        }
    }

</script>
