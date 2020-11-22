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
            .upload-img i.pick_on{font-size:3.65rem; background-image:linear-gradient(180deg, #ffd400 0%, #009efd 100%) !important; margin-top:17%;}
            .pick_div {background-color:#00000099; width:84%; height:84%; position:absolute; z-index:999;}
            .up_div{height: 80px;}
            .upload-btn{cursor:pointer; border:1px solid #b2b2b2; padding:2px 5px 2px 5px; margin-left:5px; }
            .upload-btn:hover{background-color:#337ab7; color:#fff !important;}

            .close-btn{cursor:pointer; border:1px solid #b2b2b2; padding:2px 5px 2px 5px; margin-left:5px; }
            .close-btn:hover{background-color:#337ab7; color:#fff !important;}

            .opt-del{padding:3px 6px 3px 6px; border:1px solid #b2b2b2; color:#000 !important; font-size:14px; cursor:pointer;}
            .opt-del:hover{background-color: #1a7ab1; color:#fff !important;}
            .opt-del:active{background-color: #1a7ab1; color:#fff !important;}

            @media all and (min-width:768px) and (max-width:1280px) {
                .upload-img i.pick_on{font-size:3.35rem;  margin-top:7%;}
                .pick_div{width:77%; height:80%;}
                .pe-7s-plus{margin-top:7%;}
            }

            @media all and (min-width:1280px) and (max-width:1604px) {
                .upload-img i.pick_on{font-size:3.35rem;  margin-top:7%;}
                .pick_div{width:77%; height:80%;}
                .pe-7s-plus{margin-top:16%;}
                .pe-7s-close{margin-top:12%;}
                .up_div{height: 120px;}
            }
            @media all and (min-width:1604px) {
                .upload-img i.pick_on{font-size:3.35rem;  margin-top:17%;}
                .pick_div{width:83%; }
                .pe-7s-plus{margin-top:16%;}
                .pe-7s-close{margin-top:16%;}
                .up_div{height: 140px;}
            }

      </style>
    </head>
    <body>
        <form id="editForm" name="editForm" action="/admin/edit/mainImgProc" method="post" encType="multipart/form-data">
            <input type="hidden" id="oview_cont" name="oview_cont" value="" />
            <input type="hidden" id="oview_img" name="oview_img" value="${mainInfo.mainImg}" />

            <div style="display:none;" id="upload_area_hidd">
                <input type="file" id="fileUpload" name="fileUpload" style="display:none;" maxlength="${10-fn:length(imgMapList)}" accept="image/*"  multiple />
            </div>

            <%@ include file="../common/admHeader.jsp" %>
            <div class="app-main">
                <%@ include file="../common/admLnb.jsp" %>
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
                                            <div class="page-title-subheading">메인 이미지 관리페이지 입니다.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">ADOZ STUDIO MAIN <span style="font-size:12px;">( <span style="color:#0072ffb3">최대 30개</span> 까지 등록가능 )</span> <a class="upload-btn" onclick="fn_upload_set();">추가 <i class="pe-7s-plus" style="margin-top:0%;"></i></a> <a class="close-btn" onclick="fn_image_del();">삭제 <i class="pe-7s-close" style="margin-top:0%;"></i></a></a> </h5>
                                            <div class="row" id="img_area">
                                                <c:forEach var="imgMap" items="${imgMapList}" varStatus="status" >
                                                <div class="col-md-2" name="img_<c:out value="${imgMapList[status.index].num}" />">
                                                    <div class="font-icon-wrapper upload-img font-weight-bold">
                                                        <img src="<c:out value="${imgMapList[status.index].path}" />" id="<c:out value="${imgMapList[status.index].num}" />" style="width:100%;" onClick="fn_pick(this);" />
                                                    </div>
                                                </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <a class="mb-4 mr-6 btn btn-secondary text-white float-right btn-shadow" id="update">수정하기</a>
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
    let imgStr = "${mainInfo.mainImg}";
    let imgArr_sel = [];
    let imgArr_del = [];
    let blurCnt = 0;
    let backup_Files;

    $(document).ready(function(){

        if( imgStr.length > 0 && imgStr.indexOf(',') !== -1 ){
            imgArr = imgStr.split(',');
        }

        for(let i=0; i < imgArr.length; i++){
            console.log(i + ' imgArr [' + imgArr[i] + ']');
        }

        $("#update").click(function(){
            var form = document.editForm;

            if( imgArr.length > 0 ){
                $("#oview_img").val(imgArr);
            }

            form.target = "sbIframe";
            form.method = "post";
            form.action = "/admin/edit/mainImgProc";
            form.submit();
        });

        $("#fileUpload").on('change', function(){
            let up_area = $("#upload_area");
            let del_area = $("#delete_area");
            let addhtmls = "";
            let tempCnt = 0;
            blurCnt = 0;

            if(($(this.files).length + imgArr.length) > 30){
                alert("30개 이상의 이미지를 업로드할 수 없습니다.");
                $(this).val("");
                blurCnt = 0;
                $("div[name=new_blah]").remove();
                return false;
            }


            /*$("[name=blah]").each(function(){
                blurCnt += 1;
            });*/

            $("div[name=new_blah]").remove();

            tempCnt = blurCnt;

            $("#upload_area").remove();
            $("#delete_area").remove();

            for(let i=0; i < this.files.length; i++){
                addhtmls += "<div class='col-md-2' name='new_blah'> <div class='font-icon-wrapper upload-img'>";
                addhtmls += "<img name='blah' id='blah_" + blurCnt+ "' src='#' style='width:100%;' onclick='fn_blah()' '/>";
                addhtmls += "</div></div>";

                if(this.files.length > 1){
                    blurCnt++;
                }
            }

            $("#img_area").append(addhtmls);
            $("#img_area").append(up_area);
            $("#img_area").append(del_area);

            for(let i=0; i < this.files.length; i++){
                readURL(this, tempCnt, i);
                tempCnt++;
            }


        });

    });

    function fn_pick(thisObj){

       $("#pick_onDiv > .pick_div").attr("id", $(thisObj).attr("id"));
       $(thisObj).parent().prepend($("#pick_onDiv").html());
       imgArr_sel.push(Number($(thisObj).attr("id")));

    }

    function fn_pickOff(thisObj){
        $(thisObj).remove();
        let cur = Number($(thisObj).attr("id"));

        const idx = imgArr_sel.findIndex(function(item) {
            return item === cur
        });
        if (idx > -1) imgArr_sel.splice(idx, 1);


    }

    function readURL(input, cnt, point) {
        if (input.files) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah_' + cnt).attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[point]);
        }
    }

    function fn_triggerfile(){
        $("#fileUpload").trigger("click");
    };

    function fn_upload_set(){
        console.log(' blurCnt : ' + blurCnt);
        console.log('imgArr.length : ' + imgArr.length);

        imgCnt = Number(blurCnt) + Number(imgArr.length);

        if(imgCnt >= 31 ){
            alert("이미지는 30개 이상 등록이 불가능 합니다.")
            return false;
        }

        if( $("#fileUpload").val() !== undefined ){
            backup_Files = $("#fileUpload").attr("files");
            console.log('backup ▼▼▼▼▼▼▼▼▼▼▼▼');
            console.log(backup_Files);
            console.log('backup ▲▲▲▲▲▲▲▲▲▲▲▲');
        }

        $("#fileUpload").trigger("click");
    }

    function fn_image_del(){

        if(imgArr_sel <= 0){
            alert("이미지들을 먼저 선택해주세요."); return false;
        }
        var result = confirm("선택한 이미지들을 삭제하시겠습니까?");
        if(result){
            let cur;
            if(imgArr_sel.length > 0){
                for(let i=0; i < imgArr_sel.length; i++){

                    let cur = Number(imgArr_sel[i]);

                    const idx = imgArr.findIndex(function(item) {
                        return Number(item) === Number(cur)
                    });
                    if (idx > -1) imgArr.splice(idx, 1);

                    $("div[name=img_" + cur +"]").remove();
                }

                console.log('imgArr : ' + imgArr);
            }

        }
    };

    function fn_blah(){
        alert("새로 추가한 이미지는 선택이 불가능합니다.");
    }

</script>