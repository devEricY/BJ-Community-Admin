<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<%@ include file="../common/admCommon.jsp" %>
<%@ include file="../common/loginCheck.jsp" %>

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
            .up_div{height: 80px;}
            .upload-btn{cursor:pointer; border:1px solid #b2b2b2; padding:2px 5px 2px 5px; margin-left:5px; }
            .upload-btn:hover{background-color:#337ab7; color:#fff !important;}

            .close-btn{cursor:pointer; border:1px solid #b2b2b2; padding:2px 5px 2px 5px; margin-left:5px; }
            .close-btn:hover{background-color:#337ab7; color:#fff !important;}

            .opt-del{padding:3px 6px 3px 6px; border:1px solid #b2b2b2; color:#000 !important; font-size:14px; cursor:pointer;}
            .opt-del:hover{background-color: #1a7ab1; color:#fff !important;}
            .opt-del:active{background-color: #1a7ab1; color:#fff !important;}

            .text-center{text-align: center;}

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
        <form id="editForm" name="editForm" action="/admin/edit/rentUpdate" method="post" encType="multipart/form-data">
            <input type="hidden" id="mstSeqNo" name="mstSeqNo" value="<%=mstSeqNo%>" />
            <input type="hidden" id="oview_cont" name="oview_cont" value="" />
            <input type="hidden" id="rsv_cont" name="rsv_cont" value="" />
            <input type="hidden" id="price_cont" name="price_cont" value="" />
            <input type="hidden" id="rules_cont" name="rules_cont" value="" />
            <input type="hidden" id="option-order" name="option-order" value="" />
            <input type="hidden" id="option-cont1" name="option-cont1" value="" />
            <input type="hidden" id="option-cont2" name="option-cont2" value="" />
            <input type="hidden" id="option-cont3" name="option-cont3" value="" />
            <input type="hidden" id="price_options" name="price_options" value="" />
            <input type="hidden" id="oview_img" name="oview_img" value="${rentInfo.oview_img}" />
            <input type="hidden" id="floor_img" name="floor_img" value="${rentInfo.floor_img}" />
            <input type="hidden" id="equip_img" name="equip_img" value="${rentInfo.equip_img}" />
            <input type="hidden" id="free_eq" name="free_eq" value="" />
            <input type="hidden" id="pay_eq" name="pay_eq" value="" />

            <div style="display:none;" id="upload_area_hidd">
                <input type="file" id="fileUpload" name="fileUpload" style="display:none;" maxlength="${10-fn:length(imgMapList)}" accept="image/*"  multiple />
                <input type="file" id="floorUpload" name="floorUpload" style="display:none;" accept="image/*"  />
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
                                        <div>${rentInfo.subNm}
                                            <div class="page-title-subheading">${rentInfo.subNm}은 홍대 최대규모의 스튜디오 입니다.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">STUDIO SETTING <span style="font-size:12px;">( 예약 관련 설정 )</span></h5>
                                            <div class="form-row">
                                                <div class="col-md-3 mb-3">
                                                    <label>사진 촬영 금액 </label>
                                                    <input type="text" class="form-control" id="pic_amount" name="pic_amount" placeholder="사진 촬영 금액" value="${rentInfo.p_price}" required="" >
                                                </div>
                                                <div class="col-md-2 mb-3">
                                                    <label>사진 기준 인원 </label>
                                                    <input type="text" class="form-control" id="def_usrCnt" name="def_usrCnt" placeholder="사진 기준 인원 수" value="${rentInfo.defusrcnt}" required="" >
                                                </div>
                                                <div class="col-md-2 mb-3">
                                                    <label>사진 인원수 금액 </label>
                                                    <input type="text" class="form-control" id="def_usrAmt" name="def_usrAmt" placeholder="초과 인원수 금액" value="${rentInfo.defprice}" required="" >
                                                </div>
                                                <div class="col-md-2 mb-3">
                                                    <label>최소 예약 시간 </label>
                                                    <input type="text" class="form-control" id="def_times" name="def_times" placeholder="최소 예약 시간" value="${rentInfo.deftime}" required="" >
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="col-md-3 mb-3">
                                                    <label>영상 촬영 금액 </label>
                                                    <input type="text" class="form-control" id="vid_amount" name="vid_amount" placeholder="영상 촬영 금액" value="${rentInfo.v_price}" required="" >
                                                </div>
                                                <div class="col-md-2 mb-3">
                                                    <label>영상 기준 인원 </label>
                                                    <input type="text" class="form-control" id="def_usrCnt_video" name="def_usrCnt_video" placeholder="영상 기준 인원 수" value="${rentInfo.vid_usrcnt}" required="" >
                                                </div>
                                                <div class="col-md-2 mb-3">
                                                    <label>영상 인원수 금액 </label>
                                                    <input type="text" class="form-control" id="def_usrAmt_video" name="def_usrAmt_video" placeholder="영상 초과 인원수 금액" value="${rentInfo.vid_price}" required="" >
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
                                            <h5 class="card-title">STUDIO OVERVIEW <span style="font-size:12px;">( <span style="color:#0072ffb3">최대 12개</span> 까지 등록가능 )</span> <a class="upload-btn" onclick="fn_upload_set();">추가 <i class="pe-7s-plus" style="margin-top:0%;"></i></a> <a class="close-btn" onclick="fn_image_del();">삭제 <i class="pe-7s-close" style="margin-top:0%;"></i></a> <a class="close-btn" onclick="fn_pre_image_set();">대표 이미지 설정 <i class="pe-7s-diamond icon-gradient bg-sunny-morning" style="margin-top:0%;"></i></a></h5>
                                            <div class="row" id="img_area">
                                                <c:forEach var="imgMap" items="${imgMapList}" varStatus="status" >
                                                <div class="col-md-2" name="img_<c:out value="${imgMapList[status.index].num}" />">
                                                    <div class="font-icon-wrapper upload-img font-weight-bold"><c:if test="${rentInfo.pre_img == imgMapList[status.index].num}"> <i class="pe-7s-diamond icon-gradient bg-sunny-morning"></i></c:if>
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
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">STUDIO OVERVIEW <span style="font-size:12px;">( <span style="color:#0072ffb3">최대 3000자</span>까지 입력가능 )</span></h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; height:360px;">
                                                <iframe src="/admin/edit/editNote?seqNo=<%=mstSeqNo%>&gubun=oview" style="width:100%; border:0px; height:360px;" id="oview"></iframe>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">RESERVATION <span style="font-size:12px;">( <span style="color:#0072ffb3">최대 3000자</span>까지 입력가능 )</span></h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; height:360px;">
                                                <iframe src="/admin/edit/editNote?seqNo=<%=mstSeqNo%>&gubun=rsv" style="width:100%; border:0px; height:360px;" id="rsvCont"></iframe>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">RRICE <span style="font-size:12px;">( <span style="color:#0072ffb3">최대 3000자</span>까지 입력가능 )</span></h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                <table class="mb-0 table table-hover">
                                                    <thead>
                                                    <tr>
                                                        <th>Order</th>
                                                        <th>옵션명</th>
                                                        <th>옵션설명</th>
                                                        <th>옵션금액</th>
                                                        <th></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="option_cont">
                                                    <c:forEach var="options" items="${options}" varStatus="optStatus" >
                                                        <tr id="opt_${options.optno}">
                                                            <th scope="row" name="order_num" style="padding-left:25px; "><c:out value="${options.op_order}" /></th>
                                                            <td name="opCont1" id="opCont1_${optStatus.index}" ><pre style="margin-bottom:0px;"><c:out value="${options.op_cont1}" /></pre></td>
                                                            <td name="opCont2" id="opCont2_${optStatus.index}" ><pre style="margin-bottom:0px;"><c:out value="${options.op_cont2}" /></pre></td>
                                                            <td name="opCont3" id="opCont3_${optStatus.index}" ><pre style="margin-bottom:0px;"><c:out value="${options.op_cont3}" /></pre></td>
                                                            <td><a class="opt-del" onclick="fn_opDel(${options.optno});" >삭제</a></td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="form-row" style="margin-bottom:30px;">
                                                <div class="col-md-1">
                                                    <input name="op-order" id="op-order" placeholder="순서를 입력해주세요." type="email" class="form-control">
                                                </div>
                                                <div class="col-md-3">
                                                    <textarea id="op-cont1" placeholder="옵션명을 입력해주세요." type="email" class="form-control" style="height:38px; overflow-y:hidden;"></textarea>
                                                </div>
                                                <div class="col-md-3">
                                                    <textarea id="op-cont2" placeholder="옵션 설명을 입력해주세요." type="email" class="form-control" style="height:38px; overflow-y:hidden;"></textarea>
                                                </div>
                                                <div class="col-md-3">
                                                    <textarea id="op-cont3" placeholder="옵션 금액을 입력해주세요." type="email" class="form-control" style="height:38px; overflow-y:hidden;"></textarea>
                                                </div>
                                                <div class="col-md-2">
                                                    <a class="mb-2 mr-2 btn btn-info text-white" style="width:100%; height:38px;" onClick="fn_opAdd();">추가</a>
                                                </div>
                                            </div>
                                            <div class="row" style="padding-left:15px; padding-right:15px; height:360px;">
                                                <iframe src="/admin/edit/editNote?seqNo=<%=mstSeqNo%>&gubun=pri" style="width:100%; border:0px; height:360px;" id="priCont"></iframe>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">RULE <span style="font-size:12px;">( <span style="color:#0072ffb3">최대 3000자</span>까지 입력가능 )</span></h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; height:360px;">
                                                <iframe src="/admin/edit/editNote?seqNo=<%=mstSeqNo%>&gubun=rule" style="width:100%; border:0px; height:360px;" id="ruleCont"></iframe>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">FLOOR PLAN <a class="upload-btn" onclick="fn_floor_chg();">변경 <i class="pe-7s-upload" style="margin-top:0%;"></i></a> </h5>
                                            <div class="row" id="floor_area">
                                                <div class="col-md-2" name="new_floor_blah">
                                                    <div class="font-icon-wrapper upload-img font-weight-bold">
                                                        <img src="${rentInfo.floor_images}" style="width:100%;" onClick="fn_set_upload(this);" />
                                                    </div>
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
                                            <h5 class="card-title">Equipment Img <a class="upload-btn" onclick="fn_eqManage('IMG');">변경 <i class="pe-7s-plus" style="margin-top:0%;"></i></a></h5>
                                            <div class="row" id="equipment_area">
                                                <c:forEach var="equipImages" items="${equipImages}" varStatus="status" >
                                                <div class="col-md-2" >
                                                    <div class="font-icon-wrapper upload-img font-weight-bold">
                                                        <img src="${equipImages}" style="width:100%;" />
                                                    </div>
                                                </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">무료장비<a class="upload-btn" onclick="fn_eqManage('FREE_EQ');">변경 <i class="pe-7s-upload" style="margin-top:0%;"></i></a></h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                <table class="mb-0 table table-hover">
                                                    <colgroup>
                                                        <col width="20%" />
                                                        <col width="60%" />
                                                        <col width="20%" />
                                                    </colgroup>
                                                    <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>장비명</th>
                                                        <th></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="freeEq_area">
                                                    <c:set var="count" value="1" />
                                                    <c:forEach var="equipInfo" items="${equipInfo}" varStatus="eqStatus" >
                                                        <c:if test="${equipInfo.type == 'FREE'}">
                                                        <tr id="opt_${equipInfo.eqNo}">
                                                            <th scope="row" ><c:out value="${count}" /></th>
                                                            <td name="opCont1"><pre style="margin-bottom:0px;"><c:out value="${equipInfo.eqNm}" /></pre></td>
                                                            <td></td>
                                                        </tr>
                                                        <c:set var="count" value="${count + 1}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <h5 class="card-title">유료장비<a class="upload-btn" onclick="fn_eqManage('PAY_EQ');">변경 <i class="pe-7s-upload" style="margin-top:0%;"></i></a></h5>
                                            <div class="row" style="padding-left:15px; padding-right:15px; margin-bottom:20px;">
                                                <table class="mb-0 table table-hover ">
                                                    <colgroup>
                                                        <col width="20%" />
                                                        <col width="60%" />
                                                        <col width="20%" />
                                                    </colgroup>
                                                    <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>장비명</th>
                                                        <th></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="payEq_area">
                                                    <c:set var="count" value="1" />
                                                    <c:forEach var="equipInfo" items="${equipInfo}" varStatus="eqPayStatus" >
                                                        <c:if test="${equipInfo.type == 'PAY'}">
                                                            <tr id="opt_${equipInfo.eqNo}">
                                                                <th scope="row" ><c:out value="${count}" /></th>
                                                                <td name="opCont1"><pre style="margin-bottom:0px;"><c:out value="${equipInfo.eqNm}" /></pre></td>
                                                                <td></td>
                                                            </tr>
                                                            <c:set var="count" value="${count + 1}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
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
    let imgStr = "${rentInfo.oview_img}";
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
            var option_info = [];

             $("[name=order_num]").each(function(index){
               console.log('index : ' + index);
               option_info.push({"orderNum" : $(this).html(), "cont1" : $('#opCont1_' + index).html(), "cont2" : $('#opCont2_' + index).html(), "cont3" : $('#opCont3_' + index).html()})
            });

            $("#price_options").val(option_info);

            var childObj = document.getElementById("oview");
            var contents = childObj.contentWindow.getNote();


            $("#oview_cont").val(contents);

            var rsvChildObj = document.getElementById("rsvCont");
            var rsvContents = rsvChildObj.contentWindow.getNote();

            $("#rsv_cont").val(rsvContents);

            var priChildObj = document.getElementById("priCont");
            var priContents = priChildObj.contentWindow.getNote();

            $("#price_cont").val(priContents);

            var ruleChildObj = document.getElementById("ruleCont");
            var ruleContents = ruleChildObj.contentWindow.getNote();

            $("#rules_cont").val(ruleContents);

            var form = document.editForm;

            if( imgArr.length > 0 ){
                $("#oview_img").val(imgArr);
            }

            form.target = "sbIframe";
            form.method = "post";
            form.action = "/admin/edit/rentUpdate";
            form.submit();
        });

        $("#fileUpload").on('change', function(){
            let up_area = $("#upload_area");
            let del_area = $("#delete_area");
            let addhtmls = "";
            let tempCnt = 0;
            blurCnt = 0;

            if(($(this.files).length + imgArr.length) > 12){
                alert("12개 이상의 이미지를 업로드할 수 없습니다.");
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

        $("#floorUpload").on('change', function(){
            let up_area = $("#floor_area");
            let addhtmls = "";
            let tempCnt = 0;

            $("div[name=new_floor_blah]").remove();

            addhtmls += "<div class='col-md-2' name='new_floor_blah'> <div class='font-icon-wrapper upload-img'>";
            addhtmls += "<img id='new_floor_1' src='#' style='width:100%;' />";
            addhtmls += "</div></div>";

            $("#floor_area").append(addhtmls);

            readURL_NEW(this, tempCnt, 'new_floor_1');

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

    function fn_opAdd(){
        var in_order = $("#op-order").val();
        var in_cont1 = $("#op-cont1").val();
        var in_cont2 = $("#op-cont2").val();
        var in_cont3 = $("#op-cont3").val();
        var htmls = "";
        var flag = true;
        var cnt = 0;

        if(in_order == ""){
            alert("순서를 입력해주세요.");
            flag = false;
        }

        $("[name=order_num]").each(function(){
            if($(this).html() == in_order){
                alert("이미 존재하는 순서번호 입니다.");
                flag = false;
            }
            cnt++;
        });

        if(flag) {
            var result = confirm("입력한 옵션을 추가하시겠습니까? ");
            if (result) {
                $.ajax({
                    url: '/admin/edit/optAdd',
                    type: 'post',
                    dataType: "JSON",
                    data: {
                        "seq": $("#mstSeqNo").val(),
                        "order": in_order,
                        "opt1": in_cont1,
                        "opt2": in_cont2,
                        "opt3": in_cont3,
                    },
                    success: function (data) {
                        if (data.flag === "100") {

                            htmls += "<tr id='opt_" + data.optno + "'>";
                            htmls += "<th scope='row' name='order_num'>" + in_order + "</th>";
                            htmls += "<td id='opCont1_" + cnt + "'><pre>" + in_cont1 + "</pre></td>";
                            htmls += "<td id='opCont2_" + cnt + "'><pre>" + in_cont2 + "</pre></td>";
                            htmls += "<td id='opCont3_" + cnt + "'><pre>" + in_cont3 + "</pre></td>";
                            htmls += "<td><a class='opt-del' onclick='fn_opDel("+ data.optno +");' >삭제</a></td>";
                            htmls += "</tr>";

                            $("#option_cont").append(htmls);

                            $("#op-order").val("");
                            $("#op-cont1").val("");
                            $("#op-cont2").val("");
                            $("#op-cont3").val("");

                        }
                    }
                })
            }
        }

    }

    function fn_opDel(no){
        var result = confirm("입력한 옵션을 삭제하시겠습니까? ");
        if(result) {
            $.ajax({
                url:'/admin/edit/optDel',
                type:'post',
                dataType:"JSON",
                data: {"seq" : $("#mstSeqNo").val(), "opt_seq" : no },
                success:function(data){
                    if(data.flag == "100"){
                        $("#opt_" + no).remove();

                        alert("해당 옵션이 삭제되었습니다.");
                    }else{
                        alert("오류가 발생하였습니다. 관리자에게 문의해주세요.");
                    }
                }
            })
        }
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

    function readURL_NEW(input, cnt, values) {
        if (input.files) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#' + values).attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function fn_triggerfile(){
        $("#fileUpload").trigger("click");
    };

    function fn_floor_chg(){
        $("#floorUpload").trigger("click");
    };

    function fn_upload_set(){

        imgCnt = Number(blurCnt) + Number(imgArr.length);

        if(imgCnt >= 13 ){
            alert("이미지는 10개 이상 등록이 불가능 합니다.")
            return false;
        }

        if( $("#fileUpload").val() !== undefined ){
            backup_Files = $("#fileUpload").attr("files");
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

    function fn_pre_image_set(){

        if(imgArr_sel.length != 1){
            alert("이미지는 한개만 선택하여야 합니다.");
            return false;
        }

        var result = confirm("선택한 이미지를 대표이미지로 지정하시겠습니까? ");
        if(result) {
            $.ajax({
                url:'/admin/edit/preImg',
                type:'post',
                dataType:"JSON",
                data: {"seq" : $("#mstSeqNo").val(), "imgSeq" : imgArr_sel[0]},
                success:function(data){
                    if(data.flag == "100"){
                        alert("성공적으로 대표이미지가 변경되었습니다.");
                        location.reload();
                    }else{
                        alert("오류가 발생하였습니다. 관리자에게 문의해주세요.");
                    }
                }
            })
        }
    }

    /*function fn_fileUpdate(obj){
        var up_area = $("#upload_area");
        var del_area = $("#delete_area");
        var addhtmls = "";
        blahCnt = 0;

        $("[name=blah]").each(function(){
            blahCnt += 1;
        });

        $("#upload_area").remove();
        $("#delete_area").remove();

        addhtmls += "<div class='col-md-2'> <div class='font-icon-wrapper upload-img'>";
        addhtmls += "<img name='blah' id='blah_" + blahCnt + "' src='#' style='width:100%;'  onClick='fn_pick(this);'/>";
        addhtmls += "</div></div>";

        $("#img_area").append(addhtmls);
        $("#img_area").append(up_area);
        $("#img_area").append(del_area);

        readURL(obj, blahCnt);
    }*/


    function fn_eqManage(gubun){
        if(gubun == 'IMG'){
            window.open("/admin/getEquipImg?bef=" + $("#equip_img").val() + "", "EQUIP_MANAGE", "width=600,height=700, scrollbars=yes, resizable=no, toolbar=no");
        }else if(gubun == 'FREE_EQ'){
            window.open("/admin/getEquipList?eqMode=FREE&bef=", "EQUIP_MANAGE", "width=600,height=700, scrollbars=yes, resizable=no, toolbar=no");
        }else if(gubun == 'PAY_EQ'){
            window.open("/admin/getEquipList?eqMode=PAY&bef=", "EQUIP_MANAGE", "width=600,height=700, scrollbars=yes, resizable=no, toolbar=no");
        }
    }

    function setEquipImg(selImg, urls){
        let htmls;

        $("#equip_img").val(selImg);

        $("#equipment_area").html("");

        for(let i=0; i < urls.length; i++){

            htmls = "<div class='col-md-2' name='new_equip_blah'>";
            htmls += "<div class=\"font-icon-wrapper upload-img font-weight-bold\">";
            htmls += "<img src=" + urls[i] + " style=\"width:100%;\" />";
            htmls += "</div></div>";

            $("#equipment_area").append(htmls);
        }

    }

    function setEquipList(selEqNo, contents, gubun){
        let htmls;
        let areaNm = "freeEq_area";
        let tagNm = "free_eq";

        if(gubun == 'PAY'){
            areaNm = "payEq_area";
            tagNm = "pay_eq"
        }

        $("#" + tagNm).val(selEqNo);

        $("#" + areaNm).html("");

        for(let i=0; i < contents.length; i++){

            htmls = "<tr id=\"opt_\">";
            htmls += "<th scope=\"row\" name=\"order_num\">" + (i+1) + "</th>";
            htmls += "<td name='opCont1' id='opCont1_' >" +  contents[i] + " </td>";
            htmls += "<td></td>";
            htmls += "</tr>";

            $("#" + areaNm).append(htmls);
        }

    }
</script>