<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%@include file="../includes/header.jsp" %>


<style>

    .uploadResult div div span {
        color:black;
    }
    .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top:0%;
        width:100%;
        height:100%;
        background-color: gray;
        z-index: 100;
        background:rgba(255,255,255,0.5);
    }

    .bigPicture {
        position: relative;
        display:flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img {
        width:600px;
    }

</style>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="card shadow mb-4">

        <div class="card-header py-3">
            <h1 class="h3 mb-1 text-gray-800">게시판</h1>
        </div>
        <!-- /.ard-header py-3-->

        <div class="card-body">
            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                <div class="row">
                    <div class="col-sm-12 col-md-12">
                        <h6 class="m-0 font-weight-bold text-primary">제목</h6>
                        <input type="text" id="title" class="form-control form-control-user"  name='title'
                               value='<c:out value="${board.title}"/>' readonly="readonly" placeholder="제목">
                    </div>
                    <div class="col-sm-12 col-md-12" style="padding-top: .7rem">
                        <h6 class="m-0 font-weight-bold text-primary">내용</h6>
                        <textarea type="text" id="content" class="form-control form-control-user" name="content" style="height: 10rem"  readonly="readonly"><c:out value="${board.content}"/></textarea>
                    </div>
                    <div class="col-sm-12 col-md-12" style="padding-top: .7rem">
                        <c:forEach items="${board.memberList}" var="member">
                            <h6 class="m-0 font-weight-bold text-primary">작성자</h6>
                            <input type="hidden"  class="form-control form-control-user" id="writer" name="writer"
                                   value='<c:out value="${member['id']}" />'>
                            <input type="text" class="form-control form-control-user" id="writername" name="writername"
                                   value='<c:out value="${member['name']}" />' placeholder="작성자" readonly="readonly">
                        </c:forEach>
                    </div>
                    <div class="col-sm-12 col-md-6" style="padding-top: .7rem">
                        <h6 class="m-0 font-weight-bold text-primary">작성일</h6>
                            <input type="text" id="regDate" name="regDate" placeholder="작성일"
                                   value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }" />'  readonly="readonly" class="form-control form-control-user" >
                    </div>
                    <div class="col-sm-12 col-md-6" style="padding-top: .7rem">
                        <h6 class="m-0 font-weight-bold text-primary">수정일</h6>
                        <input type="text" id="updateDate" name="updateDate"
                               value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" />' readonly="readonly" placeholder="수정일" class="form-control form-control-user" >
                    </div>
                </div>
                <hr>
                <%-- /.row --%>
                <div class="row">
                    <div class="col-sm-12 col-md-12">
                        <sec:authorize access="isAuthenticated()">
                            <c:forEach items="${board.memberList}" var="member">
                                <sec:authentication property="principal" var="pinfo"/>
                                <c:set value="${pinfo.username}" var="username" />
                                <c:set value="${member.id}" var="id" />

                                <c:if test="${username eq id}">
                                    <button data-oper="modify" class="btn btn-warning btn-user btn-block">Modify</button>
                                </c:if>
                            </c:forEach>
                        </sec:authorize>
                        <button data-oper="list" class="btn btn-primary btn-user btn-block">List</button>
                    </div>
                </div>
                <!-- /.row -->
                <hr>
                <div class="row">
                    <div class="col-sm-12 col-md-12">
                        <h6 class="m-0 font-weight-bold text-primary">첨부파일</h6>
                        <%--<input type="file" name="uploadFile">--%>
                    </div>
                    <div class="uploadResult  col-md-12 row" class="form-control form-control-user">

                    </div>
                    <div class='bigPictureWrapper'>
                        <div class='bigPicture'>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
                <hr>
                <div class="row">
                    <form id='operForm2' class="col-sm-12 col-md-12 row">
                    <div class="col-sm-12 col-md-12">
                        <h6 class="m-0 font-weight-bold text-primary">댓글 (<c:out value="${replyList.replyCnt}"/>)</h6>
                    </div>
                    <c:forEach items="${replyList.list}"  var="reply" varStatus="status">
                    <div class="col-sm-12 col-md-11" style="padding-top: .7rem">
                        <!-- reply list -->
                        <strong><c:out value="${reply.name}"/></strong>님
                     </div>
                    <div class="col-sm-12 col-md-1" style="padding-top: .7rem">
                        <small><fmt:formatDate pattern="yyyy-MM-dd" value="${reply.replyDate}" /> </small>
                    </div>
                    <div class="col-sm-12 col-md-10">
                        <input type="hidden" value="<c:out value="reply.rno}"/> ">
                        <input type="text" class="form-control form-control-user" id='reply' value="<c:out value="${reply.reply}" />" readonly="readonly">
                    </div>
                        <sec:authorize access="isAuthenticated()">
                            <sec:authentication property="principal" var="pinfo"/>
                            <c:set value="${pinfo.username}" var="username" />
                            <c:set value="${reply.id}" var="id" />
                            <c:if test="${username eq id}">
                    <div class="col-sm-12 col-md-2">
                        <div class="offset-md-4">
                            <button data-oper="modifyReply"data-rno='${reply.rno}' class='btn btn-secondary btn-sm'>댓글수정</button>
                            <button data-oper="removeReply" class='btn btn-secondary btn-sm'>댓글삭제</button>
                        </div>
                    </div>
                            </c:if>
                        </sec:authorize>
                    </c:forEach>
                        <input type='hidden' name='bno' value='<c:out value="${board.bno }"/>'>
                        <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                        <input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                        <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                        <input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                        <input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }" />
                    </form>

                    <sec:authorize access="isAuthenticated()">
                        <div class="col-sm-12 col-md-11"  style="padding-top: 1rem">
                            <form id='operForm' method="get">
                                <input type="text" class="form-control form-control-user" id="replyInput" name="reply" >
                                <input type='hidden' name='replyer' value="<sec:authentication property="principal.member.mno"/>" >
                                <input type='hidden' name='bno' value='<c:out value="${board.bno }"/>'>
                                <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                                <input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                                <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                                <input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                                <input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }" />
                            </form>
                        </div>
                        <div class="col-sm-12 col-md-1" style="padding-top: 1rem">
                            <button data-oper="reply" class='btn btn-primary'>댓글 작성</button>
                        </div>
                    </sec:authorize>

                    <div class="col-sm-12 col-md-12">
                        <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                            <ul class="pagination">
                                <c:if test="${pageMaker.prev}">
                                    <li class="paginate_button page-item previous disabled" id="dataTable_previous">
                                        <a href="${pageMaker.startPage-1}"class="page-link">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                    <li class="paginate_button page-item  ${pageMaker.cri.pageNum == num ? 'active' : '' }">
                                        <a href="${num}" class="page-link">${num}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${pageMaker.next}">
                                    <li class="paginate_button page-item next" id="dataTable_next">
                                        <a href="${pageMaker.endPage+1}" class="page-link">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- dataTable_wrapper -->
        </div>
        <!-- card-body -->
    </div>
    <!-- card shadow mb-4 -->
</div>
<!-- container-fluid -->


<!-- reply modal -->
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Reply to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <form id='operForm3' >
                        <label>댓글내용</label>
                        <input type="text" class="form-control" name='reply'>
                        <input type="hidden" name="rno">
                        <input type="hidden" name="replyer">
                        <input type='hidden' name='bno' value='<c:out value="${board.bno }"/>'>
                        <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                        <input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                        <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                        <input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                        <input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }" />
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- /.reply modal -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%-- submit button --%>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
    $(document).ready(function(){
        /* modify 데이터 처리  */
        var operForm = $("#operForm");
        var operForm2 = $("#operForm2");
        var operForm3 = $("#operForm3");

        var modal = $(".modal");
        var modalInputReply = modal.find("input[name='reply']");
        var modalInputRno = modal.find("input[name='rno']");
        var modalInputReplyer = modal.find("input[name='replyer']");

        $("button[data-oper='modify']").on("click", function(e){
            operForm.find("#reply").remove();
            operForm.find("#replyer").remove();
            operForm.attr("action", "/board/modify").submit();
        });
        $("button[data-oper='home']").on("click", function(e){
            operForm.find("#reply").remove();
            operForm.find("#replyer").remove();
            operForm.find("#bno").remove();
            operForm.find("#pageNum").remove();
            operForm.find("#amount").remove();
            operForm.find("#type").remove();
            operForm.find("#keyword").remove();

            operForm.attr("action", "/");
            operForm.submit();
        });

        $("button[data-oper='list']").on("click", function(e){
            operForm.find("#reply").remove();
            operForm.find("#replyer").remove();

            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });

        $("button[data-oper='removeReply']").on("click", function (e) {
            operForm2.attr("action", "/replies/remove");
            operForm2.attr("method", "post").submit();
        });

        $("button[data-oper='reply']").on("click", function(e){
           if(!$("#replyInput").val()){
               alert("댓글을 입력하세요");
               return false;
           };
            operForm.attr("action", "/replies/register");
            operForm.attr("method", "post").submit();
        });

        $("button[data-oper='modifyReply']").on("click", function (e) {
           e.preventDefault();
            var rno = $(this).data("rno");
            replyService.get(rno, function(reply) {
                modalInputReply.val(reply.reply);
                modalInputRno.val(reply.rno);
                modalInputReplyer.val(reply.replyer);
                $("#replyModal").modal("show");
            });
        });
        $("#modalModBtn").on("click",function (e) {
            operForm3.attr("action", "/replies/modify");
            operForm3.attr("method", "post").submit();
            $("#replyModal").modal("hide");
        });


        $(".paginate_button a").on("click", function(e){
            e.preventDefault();
            operForm.find("#rno").remove();
            operForm.find("#reply").remove();
            operForm.find("#replyer").remove();

            operForm.attr("action", "/board/get");
            operForm.find("input[name='pageNum']").val($(this).attr("href"));
            operForm.submit();
        });


        $('.amount').change(function (){
            var name = $("option:selected", this).data("name");
            $('.amount_input').val(name);
            $('.pageNum_input').val("1");
            operForm.val($(this).attr("href"));
            operForm.submit();
        });

        $('.amount option').each(function () {
            if($(this).val() == "${pageMaker.cri.amount }"){
                $(this).attr("selected", "selected");
            }
        });

    });
</script>
<%-- /.submit button --%>

<%--fileupload --%>
<script>
    $(document).ready(function(e){
        var formObj = $("#f_register");
        /* 파일 업로드 */
        $("button[type='submit']").on("click", function(e){
            e.preventDefault();
            var str = "";
            $(".uploadResult ul li").each(function (i, obj) {
                var jobj = $(obj);
                console.dir(jobj);
                str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
                str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
                str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
                str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
            });
            console.log(str);
            formObj.append(str).submit();
        });
        /* 파일 체크 */
        var regex = new RegExp("(.*?)\.(exe|sh|zup|alz|7z)$");
        var maxSize = 5242880; //5MB
        function checkExtension(fileName, fileSize){
            if(fileSize >= maxSize){
                alert("파일사이즈 초과");
                return false;
            }
            if(regex.test(fileName)){
                alert("해당종류의 파일은 업로드 불가");
                return false;
            }
            return true;
        }

        var csrfHeaderName = "${_csrf.headerName}";
        var csrfTokenValue = "${_csrf.token}";
        /* */
        $("input[type='file']").change(function(e){
            var formData = new FormData();
            var inputFile = $("input[name='uploadFile']");
            var files = inputFile[0].files;
// 		console.log(files);
            for(var i = 0; i < files.length; i++){
                if(!checkExtension(files[i].name, files[i].size) ){
                    return false;
                }
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                url: '/upload/uploadAjaxAction2',
                processData: false,
                contentType: false,
                beforeSend: function(xhr){
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                data: formData,
                type: 'POST',
                dataType: 'json',
                success: function(result){
                    console.log(result);
                    showUploadResult(result);
                }
            }); // .ajax
        });

        /* /display */
        function showUploadResult(uploadResultArr){
            if(!uploadResultArr || uploadResultArr.length == 0){
                return;
            }
            var uploadUL = $(".uploadResult ul");
            var str = "";
            $(uploadResultArr).each(function(i, obj){
                if(obj.image){
                    var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
                    str += "<div class='col-sm-12 col-md-1' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
                    str += "<span>"+obj.fileName+"</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
                    str += "<i class='fa fa-times'></i></button><br>";
                    str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
                    str += "</div>";
                }else{
                    var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
                    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
                    str += "<div class='col-sm-12 col-md-1' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
                    str += "<span>"+obj.fileName+"</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>";
                    str += "<i class='fa fa-times'></i></button><br>";
                    str += "<img src='/resources/img/attach.png'>";
                    str += "</div>";
                }
            });
            uploadUL.append(str);
        }


        $(".uploadResult").on("click", "button", function(e){
            console.log("delete file");
            var targetFile = $(this).data("file");
            var type = $(this).data("type");
            var targetLi = $(this).closest("li");

            $.ajax({
                url: '/upload/deleteFile',
                data: {fileName: targetFile, type:type},
                beforeSend: function(xhr){
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                dataType:'text',
                type: 'POST',
                success: function(result){
                    alert(result);
                    targetLi.remove();
                }
            }); //$.ajax
        });
    })
</script>
<%--/.fileupload --%>

<script type="text/javascript">
    $(document).ready(function(){
        (function(){
            var bno = '<c:out value="${board.bno}"/>';
            $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
                console.log(arr);
                var str = "";
                $(arr).each(function(i, attach){
                    if(attach.fileType){
                        var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);

                        str += "<div class='col-sm-12 col-md-1' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' >";
                        str += "<span> "+ attach.fileName+"</span><br/>";
                        str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
                        str += "</div>";
                    }else{
                        str += "<div class='col-sm-12 col-md-1' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' >";
                        str += "<span> "+ attach.fileName+"</span><br/>";
                        str += "<img src='/resources/img/attach.png'></a>";
                        str += "</div>";
                    }
                });
                $(".uploadResult").html(str);
            }); //getJSON
        })(); //function

        $(".uploadResult").on("click","div", function(e){
            console.log("view image");
            var liObj = $(this);
            var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));

            console.log(liObj);
            console.log(path);
            console.log(liObj.data("type"));

            if(liObj.data("type")){
                showImage(path.replace(new RegExp(/\\/g),"/"));
            }else {
                //download
                self.location ="/upload/download?fileName="+path
            }
        });
        function showImage(fileCallPath){
            $(".bigPictureWrapper").css("display","flex").show();
            $(".bigPicture")
                .html("<img src='/upload/display?fileName="+fileCallPath+"' >")
                .animate({width:'100%', height: '100%'}, 1000);
        }
        $(".bigPictureWrapper").on("click", function(e){
            $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
            setTimeout(function(){
                $('.bigPictureWrapper').hide();
            }, 1000);
        });

    });
</script>

<%--register check--%>
<script>
    $("#id").blur(function(){
        checkId();
    });
    $("#pw1").blur(function() {
        checkPw1();
    });
    $("#pw2").blur(function() {
        checkPw2();
    });
    $("#pw2").blur(function() {
        checkPw2();
    });
    $("#name").blur(function() {
        checkName();
    });
    $("#email").blur(function() {
        checkEmail();
    });
    $("#tel3").blur(function() {
        checkTel();
    });
    $("#birth").blur(function () {
        checkBirth();
    });
    $("#adr").blur(function() {
        checkPost();
    });
    $("#sample6_detailAddress").blur(function () {
        checkPost();
    });

    function checkId() {
        var id = $("#id").val();
        var idC = /^[a-z0-9][a-z0-9_\-]{2,19}$/;

        if (id == "") {
            $("#idchk").html("필수 정보입니다.");
            return false;
        }
        if (!idC.test(id)) {
            $("#idchk").html("3자 이상, 20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용가능합니다.");
            return false;
        }else{
            $.ajax({
                type : "get",
                url : "./idChk?id="+id,
                dataType:'json',
                success : function(data) {
                    if (data == 1){
                        $("#idchk").html("이미 사용중이거나 탈퇴한 아이디입니다.");
                        return false;
                    }else {
                        $("#idchk").html("");
                        return true;
                    }
                },
                error:function (error) {
                    console.log("error"+error);
                }
            });
        }
    } //checkId

    function checkPw1() {
        var pw1 = $("#pw1").val();
        if (pw1 == "") {
            $("#pwchk").html("패스워드 입력해주세요.");
            return false;
        }
        if (pw1.length < 3 || pw1.length > 16) {
            $("#pwchk").html("3자 이상 16자 이하 입력 부탁드립니다.");
            return false;
        }else if (pw1 != ""){
            $("#pwchk").html("");
            return true;
        }
    } //checkPw1

    function checkPw2() {
        var pw1 = $("#pw1").val();
        var pw2 = $("#pw2").val();

        if (pw2 == "") {
            $("#pwchk").html("비밀번호 한번더 입력해주세요.");
            return false;
        }
        if (pw1 != pw2) {
            $("#pwchk").html("비밀번호가 일치하지 않습니다.");
            return false;
        }
        if(pw1 == pw2){
            $("#pwchk").html("");
            return true;
        }

    }//checkPw2

    function checkName() {
        var name = $("#name").val();
        var nameC = /^[가-힣]{2,4}$/;

        if(name == ''){
            $("#namechk").html("필수정보입니다.");
            return false;
        }
        if (!nameC.test(name)) {
            $("#namechk").html("2~4자 한글만 입력가능합니다.");
            return false;
        }else {
            $("#namechk").html("");
            return true;
        }
    }//checkName

    function checkEmail() {
        var email = $("#email").val();
        var emailC = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

        if(email == ""){
            $("#emailchk").html("메일을 입력해주세요");
            return false;
        }
        if(!emailC.test(email)){
            $("#emailchk").html("메일을 정확히 입력해주세요");
            return false;
        }else {
            $("#emailchk").html("");
            return true;
        }

    }//checkEmail

    function checkTel() {
        var tel1 = $("#tel1").val();
        var tel2 = $("#tel2").val();
        var tel3 = $("#tel3").val();

        var tel = tel1+"-"+tel2+"-"+tel3;

        var telC =/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

        if(tel1 == "" || tel2 == "" || tel3 ==""){
            $("#telchk").html("입력해주세요.");
            return false;
        }
        if(!telC.test(tel)){
            $("#telchk").html("전화번호가 올바르지 않습니다.");
            return false;
        }else {
            $("#telchk").html("");
            return true;
        }

    }//checkTel

    function checkBirth() {
        var birth = $("#birth").val();
        var now = new Date();
        var yearNow = now.getFullYear();

        if(birth == ""){
            $("#birthchk").html("생년월일을 입력해주세요");
            return false;
        }
        if(yearNow-(birth.substr(0,4)) < 14){
            $("#birthchk").html("14세 미만은 회원가입 불가능 합니다.");
            return false;
        }else{
            $("#birthchk").html("");
            return true;
        }

    }//checkBirth

    function checkPost() {
        var sample6_postcode = $("#sample6_postcode").val();
        var sample6_detailAddress = $("#sample6_detailAddress").val();

        if(sample6_postcode ==  ""){
            $("#adrchk").html("주소를 입력해주세요");
            return false;
        }
        if(sample6_detailAddress == ""){
            $("#adrchk").html("상세주로를 입력해주세요");
            return false;
        }
        if(sample6_postcode != ""&& sample6_detailAddress != "" ){
            $("#adrchk").html("");
            return true;
        }
    }//checkPost

</script>
<%--/.register check--%>

<%-- calendar --%>
<script src="/resources/vendor/datetimepicker/jquery.js"></script>
<script src="/resources/vendor/datetimepicker/jquery.datetimepicker.js"></script>
<script>
    $('#birth').datetimepicker({
        lang:'ko',
        format: 'Y/m/d',
        onGenerate:function( ct ){
            $(this).find('.xdsoft_date')
                .toggleClass('xdsoft_disabled');
        },
        minDate:'-1970/01/2',
        maxDate:'+1970/01/2',
        timepicker:false
    });
</script>
<%-- /.calendar --%>

<%-- post code--%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<%-- /.post code--%>

<%@include file="../includes/footer.jsp" %>