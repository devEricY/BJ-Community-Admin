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
                                <div class="page-title-subheading">장비 이미지 관리페이지 입니다.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12" id="img_areas">
                            <c:forEach var="imgMap" items="${equipInfo}" varStatus="status" >
                                <div class="img_areas">
                                <img src="<c:out value="${imgMap.imgUrl}" />" id="<c:out value="${imgMap.attachNo}" />" />

                                    <div class="btn_areas">
                                        <a class="upload-btn <c:if test="${imgMap.checked}">on</c:if>" onclick="fn_sel(${imgMap.attachNo}, this);">선택 <i class="pe-7s-plus" style="margin-top:0%;"></i></a>
                                        <a class="upload-btn" onclick="fn_del(${imgMap.seqNo});">삭제 <i class="pe-7s-plus" style="margin-top:0%;"></i></a>
                                    </div>

                                </div>
                            </c:forEach>
                    </div>
                </div>

                <div class="row">
                    <div style="width: 100%; padding-right: 5%;">
                        <a class="mb-4 mr-6 btn btn-secondary text-white float-right btn-shadow" id="update" onclick="fn_choice();">선택완료</a>
                        <a class="mb-4 mr-6 btn btn-secondary text-white float-right btn-shadow" id="addEquip" onclick="fn_addEquip();" style="margin-right:10px;">장비추가</a>
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

        console.log(imgArr_sel);

        $("#fileUpload").on('change', function(){
            let addhtmls = "";
            let tempCnt = 0;
            currObj = $(this);
            blurCnt = 0;

            //let params = $('#editForm').serialize();

            var form = $('#editForm')[0];
            var params = new FormData(form);

            $.ajax({
                type: 'POST',
                url: '/admin/equipAdd',
                enctype: 'multipart/form-data',
                dataType: "JSON",
                data: params,
                processData: false,
                contentType: false,
                success: function (data) {
                    location.reload();
                }
            });


        });

    });

    function readURL(input, cnt, point) {
        if (input.files) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah_' + cnt).attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[point]);
        }
    }


    function fn_addEquip(){
        var result = confirm("최대 30개까지 한번에 업로드가 가능하며, 이미지 선택완료 시 바로 장비가 추가가 됩니다. 진행하시겠습니까?");
        if (result) {
            $("#fileUpload").trigger("click");
        }
    }

    function fn_del(imgNo){
        var result = confirm("정말로 삭제 하시겠습니까?");
        if (result) {
            $.ajax({
                type: 'POST',
                url: '/admin/delEquipImg',
                dataType: "JSON",
                data: {
                    "imgNo" : imgNo
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

    function fn_sel(imgNo, obj){
        if($(obj).hasClass("on")){
            $(obj).removeClass("on");

            const idx = imgArr_sel.findIndex(function(item) {
                return item === imgNo
            });
            if (idx > -1) imgArr_sel.splice(idx, 1)

        }else{
            $(obj).addClass("on");
            imgArr_sel.push(imgNo);
        }

        console.log(imgArr_sel);
    }

    function fn_choice(){
        if(imgArr_sel.length <= 0){
            alert("이미지를 하나라도 선택해주셔야 합니다.");
            return false;
        }

        let imgUrl = [];

        for(let i=0; i < imgArr_sel.length; i++){
            imgUrl.push($("#" + imgArr_sel[i]).attr("src"));
        }

        window.opener.setEquipImg(imgArr_sel, imgUrl);
        close();
    }

</script>