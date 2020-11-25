<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="../common/Common.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    <body>
        <form id="mbListForm" name="mbListForm" method="get">

            <%@ include file="../common/Header.jsp" %>
            <div class="app-main">
                <%@ include file="../common/Lnb.jsp" %>
                    <div class="app-main__outer">
                        <div class="app-main__inner">

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">Board Management</h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                <table class="mb-0 table table-hover">
                                                    <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>제목</th>
                                                        <th>등록아이디</th>
                                                        <th>닉네임</th>
                                                        <th>조회수</th>
                                                        <th>추천수</th>
                                                        <th>가입일</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="option_cont">
                                                    <c:if test="${mbListCnt <= 0}" >
                                                        <tr>
                                                            <td colspan="5" style="text-align: center;">데이터가 존재하지 않습니다.</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="bdList" items="${bdList}" varStatus="status">
                                                        <c:if test="${status.count > 0}" >
                                                            <tr>
                                                                <td scope="row" name="order_num">${bdList.rownum}</td>
                                                                <td><a class="infoLike" >${bdList.board_title}</a></td>
                                                                <td><a class="infoLike" >${bdList.member_id}</a></td>
                                                                <td><a class="infoLike" >${bdList.member_name}</a></td>
                                                                <td><a class="infoLike" >${bdList.board_view_cnt}</a></td>
                                                                <td><a class="infoLike" >${bdList.board_recomm_cnt}</a></td>
                                                                <td><a class="infoLike" >${bdList.reg_date}</a></td>
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
                                                <a href='<c:url value="/board/list?page=${pageMaker.startPage-1 }&class_seq=${class_seq}"/>'><</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="pageNum">
                                            <c:if test="${curPage == pageNum}" >
                                                <li class="on">
                                                    <a href='<c:url value="/board/list?page=${pageNum}"/>&class_seq=${class_seq}'>${pageNum}</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${curPage != pageNum}" >
                                                <li>
                                                    <a href='<c:url value="/board/list?page=${pageNum}"/>&class_seq=${class_seq}'>${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
                                            <li>
                                                <a href='<c:url value="/board/list?page=${pageMaker.endPage+1 }&class_seq=${class_seq}"/>'> > </a>
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
