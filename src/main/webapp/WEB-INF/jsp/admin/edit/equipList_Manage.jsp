<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<%@ include file="../common/admCommon.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>
<head>
    <style>
        .bgImg{display:none; position:absolute;}
        .contents{width:100%; position:absolute; padding-top:175px; padding-left:66%;}

        #id{width:300px;}
        #password{width:300px;}
        #login{width:300px; color:#fff;}
        .upload-img img{transition: all ease 0.2s;}
        .upload-img img:hover{transform: scale( 0.9 );}
        .upload-img i.pick_on{font-size:3.65rem; background-image:linear-gradient(180deg, #ffd400 0%, #009efd 100%) !important; margin-top:4%;}
        .pick_div {background-color:#00000099; width:92%; height:80%; position:absolute; z-index:999;}
        .up_div{height: 80px;}
        .upload-btn{cursor:pointer; border:1px solid #b2b2b2; padding:2px 5px 2px 5px; margin-left:5px; }
        .upload-btn:hover{background-color:#337ab7; color:#fff !important;}
        .upload-btn.on{background-color:#337ab7; color:#fff !important;}

        .close-btn{cursor:pointer; border:1px solid #b2b2b2; padding:2px 5px 2px 5px; margin-left:5px; }
        .close-btn:hover{background-color:#337ab7; color:#fff !important;}

        .opt-del{padding:3px 6px 3px 6px; border:1px solid #b2b2b2; color:#000 !important; font-size:14px; cursor:pointer;}
        .opt-del:hover{background-color: #1a7ab1; color:#fff !important;}
        .opt-del:active{background-color: #1a7ab1; color:#fff !important;}

        .img_areas{float: left; width: 32%; max-height: 170px; min-height: 200px; margin-left:5px;}
        .img_areas img{width:100%; min-height:140px; max-height:120px;}
        .btn_areas{padding-top:10px;text-align: center;}

    </style>
</head>
<body>
<form id="editForm" name="editForm" action="/admin/equipAdd" method="post" encType="multipart/form-data">
    <input type="hidden" id="oview_cont" name="oview_cont" value="" />
    <input type="hidden" id="eqMode" name="eqMode" value="${eqMode}" />

    <div style="display:none;" id="upload_area_hidd">
        <input type="file" id="fileUpload" name="fileUpload" style="display:none;" accept="image/*"  multiple />
    </div>

    <%@ include file="../common/admHeader.jsp" %>
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
                            <div>
                                <div class="page-title-subheading">장비 관리페이지 입니다.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="main-card mb-3 card">
                            <div class="card-body">
                                <h5 class="card-title"><c:if test="${eqMode == 'FREE' }">무료장비</c:if><c:if test="${eqMode == 'PAY' }">유료장비</c:if> </h5>
                                <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                    <table class="mb-0 table table-hover">
                                        <colgroup>
                                            <col width="60%" />
                                            <col width="20%" />
                                            <col width="20%" />
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>장비명</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody id="eq_List">
                                            <c:forEach var="equip" items="${equipInfo}" varStatus="status" >
                                                <tr id="opt_${equip.eqNo}">
                                                    <td name="eq_${equip.eqNo}" id="${equip.eqNo}" ><pre>${equip.eqNm}</pre></td>
                                                    <td><a class="upload-btn" onclick="fn_sel(${equip.eqNo}, this);" >선택</a></td>
                                                    <td><a class="opt-del" onclick="fn_del(${equip.eqNo});" >삭제</a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row" style="margin-bottom:30px;">
                                    <div class="col-md-2">
                                        <textarea id="eq-cont1" placeholder="옵션명을 입력해주세요." type="email" class="form-control" style="height:38px; overflow-y:hidden;"></textarea>
                                        <a class="mb-2 mr-2 btn btn-info text-white" style="width:100%; height:38px;" onClick="fn_eqAdd();">추가</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--<div class="row">
                    <div class="col-md-12">
                        <div class="main-card mb-3 card">
                            <div class="card-body">
                                <h5 class="card-title">선택한 장비</h5>
                                <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                    <table class="mb-0 table table-hover">
                                        <colgroup>
                                            <col width="75%" />
                                            <col width="10%" />
                                            <col width="15%" />
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>장비명</th>
                                            <th>순서</th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody id="selEq_area">
                                            <tr id="opt_${options.optno}">
                                                <td name="opCont1" id="opCont_3" ><pre>장비명</pre></td>
                                                <td><input type="text" value="" /> </td>
                                                <td><a class="opt-del" onclick="fn_opDel(${options.optno});" >제거</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>

                <div class="row">
                    <div style="width: 100%; padding-right: 5%;">
                        <a class="mb-4 mr-6 btn btn-secondary text-white float-right btn-shadow" id="update" onclick="fn_choice();">선택완료</a>
                    </div>
                </div>

            </div>
        </div>
    </div>

</form>
<div id="pick_onDiv" style="display:none;"><div class="pick_div" id="" onClick="fn_pickOff(this);" ><i class="pe-7s-check icon-gradient bg-happy-itmeo pick_on"> </i></div></div>
<iframe id="sbIframe" name="sbIframe" style="border:0px; width:0px; height:0px;"> </iframe>
</body>
</html>

<script type="text/javaScript">
    let imgArr = [];
    let imgStr = "${bef}";
    let imgArr_sel = [];
    let imgArr_del = [];
    let blurCnt = 0;
    let backup_Files;
    let currObj;

    $(document).ready(function(){

        if( imgStr.length > 0 && imgStr.indexOf(',') !== -1 ){
            imgArr = imgStr.split(',');

            for(let i=0; i < imgArr.length; i++){
                imgArr_sel.push(Number(imgArr[i]));
            }
        }

    });


    function fn_del(eqNo){
        var result = confirm("정말로 삭제 하시겠습니까?");
        if (result) {
            $.ajax({
                type: 'POST',
                url: '/admin/equipListDel',
                dataType: "JSON",
                data: {
                    "eqNo" : eqNo
                },
                success: function (data) {
                    location.reload();
                },
                error:function(request,status,error) {
                    alert("오류가 발생하였습니다. 관리자에게 문의해주세요.");
                }
            })
        }
    }

    function fn_choice(){
        if(imgArr_sel.length <= 0){
            alert("장비를 하나라도 선택해주셔야 합니다.");
            return false;
        }

        let equipList = [];

        for(let i=0; i < imgArr_sel.length; i++){
            equipList.push($("#" + imgArr_sel[i]).html());
        }

        window.opener.setEquipList(imgArr_sel, equipList, $("#eqMode").val());
        close();
    }

    function fn_eqAdd(){

        if($("#eq-cont1").val() == ""){
            alert("장비명을 입력해주세요.");
            return false;
        }

        let result = confirm("해당 장비를 추가 하시겠습니까?");
        if (result){
            $.ajax({
                type: 'POST',
                url: '/admin/equipListAdd',
                dataType: "JSON",
                data: {
                    "eqMode" : $("#eqMode").val(),
                    "eqNm" : $("#eq-cont1").val()
                },
                success: function (data) {
                    location.reload();
                }
            });
        }
    }

    function fn_sel(eqNo, obj){
        let html = "";

        if($(obj).hasClass("on")){
            $(obj).removeClass("on");

            const idx = imgArr_sel.findIndex(function(item) {
                return item === eqNo
            });
            if (idx > -1) imgArr_sel.splice(idx, 1)

        }else{
            $(obj).addClass("on");
            imgArr_sel.push(eqNo);
        }

        console.log(imgArr_sel);

    }

</script>