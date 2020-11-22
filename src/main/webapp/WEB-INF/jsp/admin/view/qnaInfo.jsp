<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%@ include file="../common/admCommon.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    String mstSeqNo = request.getParameter("seqNo");
%>
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
<c:if test="${resultCode == '007'}">
    <script>alert('정상적으로 답변이 완료 되었습니다')</script>
</c:if>

<c:if test="${resultCode == '000'}">
    <script>alert('답변중 문제가 발생하였습니다. 관리자에게 문의해주세요. ')</script>
</c:if>
    <body>
        <form id="qnaInfoForm" name="qnaInfoForm" method="POST">
            <input type="hidden" id="mstSeqNo" name="mstSeqNo" value="${qnaInfo.seqNo}" />

            <%@ include file="../common/admHeader.jsp" %>
            <div class="app-main">
                <%@ include file="../common/admLnb.jsp" %>
                    <div class="app-main__outer">
                        <div class="app-main__inner">
                            <div class="app-page-title">
                                <div class="page-title-wrapper">
                                    <div class="page-title-heading">
                                        <div class="page-title-icon">
                                            <i class="pe-7s-help1 text-success icon-gradient bg-happy-fisher">
                                            </i>
                                        </div>
                                        <div>${qnaInfo.name} 님의 문의정보 입니다.
                                            <div class="page-title-subheading">${qnaInfo.regDate}에 문의하셨습니다.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="main-card col-md-8 card " style="margin-right: 2%;">
                                    <div class="card-body">
                                        <h5 class="card-title">문의 정보</h5>
                                        <form class="needs-validation was-validated" novalidate="">
                                            <div class="form-row">
                                                <div class="col-md-4 mb-3">
                                                    <label for="usrNm">문의자 명</label>
                                                    <input type="text" class="form-control" id="usrNm" name="usrNm" placeholder="문의자 명" value="${qnaInfo.name}" required="" disabled>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="validationCustom03">전화번호</label>
                                                    <input type="text" class="form-control" id="validationCustom03" placeholder="전화번호" required="" value="${qnaInfo.phone}" disabled>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="toEmail">이메일</label>
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroupPrepend">@</span>
                                                        </div>
                                                        <input type="text" class="form-control" id="toEmail" name="toEmail" placeholder="Username" aria-describedby="inputGroupPrepend" required="" value="${qnaInfo.email}" disabled>
                                                    </div>
                                                </div>

                                                <div class="col-md-12 mb-3">
                                                    <label for="validationCustom03">제목</label>
                                                    <input type="text" class="form-control" name="qnaTitle" id="qnaTitle" placeholder="전화번호" required="" value="${qnaInfo.title}" disabled>
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="col-md-12 mb-3">
                                                    <label for="validationCustom03">문의내용</label>
                                                    <textarea name="text" id="exampleText" class="form-control mb-2" style="height: 150px; overflow-y: auto;" disabled>${qnaInfo.msg}</textarea>
                                                </div>

                                            </div>


                                            <c:if test="${qnaInfo.ansRegId != null}">

                                            <div class="form-row">
                                                <div class="col-md-4 mb-3">
                                                    <label for="ansId">답변자 명</label>
                                                    <input type="text" class="form-control" id="ansId" value="${qnaInfo.ansRegId}" required="" disabled>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="validationCustom03">답변날짜</label>
                                                    <input type="text" class="form-control" id="ansDate" required="" value="${qnaInfo.ansRegDate}" disabled>
                                                </div>
                                            </div>

                                            </c:if>
                                            <div class="form-row">
                                                <div class="col-md-12 mb-3">
                                                    <label for="validationCustom03">답변내용</label>
                                                    <textarea id="ansTxt" name="ansTxt" class="form-control mb-2" style="height: 150px; overflow-y: auto;">${qnaInfo.ansMsg}</textarea>
                                                </div>

                                            </div>

                                            <c:if test="${qnaInfo.ansRegId == null}">
                                            <div class="form-row">
                                                <div class="col-md-12">
                                                    <a class="mb-4 mr-6 btn btn-secondary text-white float-right btn-shadow" onclick="fn_submit();">답변하기</a>
                                                </div>
                                            </div>
                                            </c:if>

                                        </form>
                                    </div>
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

    function fn_submit(){

        if($("#ansTxt").val() == "" ){
            alert("답변 내용을 입력해주세요.");
            return false;
        }

        var result = confirm("이대로 답변을 하시겠습니까?");
        if(result){
            var form = document.qnaInfoForm;
            form.target = "_self";
            form.action = "/admin/qnaProc";
            form.submit();
        }else{
            return false;
        }

    }

</script>
