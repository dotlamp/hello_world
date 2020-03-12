<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Hello world - Profile</title>

    <link rel="stylesheet" type="text/css" href="/resources/vendor/datetimepicker/jquery.datetimepicker.css" media="screen"/>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" media="screen">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet" media="screen">

</head>
<body>
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">My Profile!</h1>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                     <lable>이름</lable><input type="text" class="form-control form-control-user" id="name" name="name" placeholder="이름"
                                            value='<c:out value="${member.name}"/>' readonly="readonly">
                                </div>
                                <div class="col-sm-6">
                                    <lable>성별</lable><input type="text" class="form-control form-control-user"
                                                            value='<c:out value="${member.gender}"/>' readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <lable>생년월일</lable><input type="text" class="form-control form-control-user"  name='birth'
                                           value='<c:out value="${member.birth}"/>' placeholder="생년월일" readonly="readonly">
                                </div>
                                <div class="col-sm-6">
                                    <c:set var="now" value="<%=new java.util.Date()%>" />
                                    <c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
                                    <c:set var="birthYear" value="${member.birth}"/>
                                    <c:set var="birthYear" value="${fn:substring(birthYear, 0, 4)}" />
                                    <c:set var="age" value="${sysYear-birthYear+1}" />
                                    <lable>나이</lable><input type="text" class="form-control form-control-user"
                                                              value='<c:out value="${age}" />세' readonly="readonly">
                                </div>
                            </div>
                                <div class="form-group">
                                    <lable>이메일</lable><input type="text"  class="form-control form-control-user" id="email" name="email"
                                           value='<c:out value="${member.email}"/>' placeholder="이메일" readonly="readonly">
                                </div>
                                <div class="form-group">
                                    <lable>전화번호</lable><input type="text"  class="form-control form-control-user"
                                           value='<c:out value="${member.tel1}-${member.tel2}-${member.tel3}"/>' placeholder="tel" readonly="readonly">
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <lable>주소</lable><input type="text" id="sample6_postcode" name="post" placeholder="우편번호"
                                               value='<c:out value="${member.post}"/>' readonly="readonly" class="form-control form-control-user" >
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" id="sample6_address" name="adr1" placeholder="주소"
                                               value='<c:out value="${member.adr1}"/>'  readonly="readonly" class="form-control form-control-user" >
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" id="sample6_detailAddress" name="adr2"
                                               value='<c:out value="${member.adr2}"/>' readonly="readonly" placeholder="상세주소" class="form-control form-control-user" >
                                        <input type="hidden" id="sample6_extraAddress" name="adr3"
                                               value='<c:out value="${member.adr3}"/>'  readonly="readonly" placeholder="참고항목" class="form-control form-control-user" >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="panel-body">
                                        <div class="pi_from">
                                            <label style="width: 5rem">프로필사진</label> <%--<input type="file" name="uploadFile">--%>
                                        </div>
                                        <!-- /.form-group uploadDiv  -->
                                        <div class="uploadResult" class="form-control form-control-user">
                                            <ul>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <script
                                src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
                                crossorigin="anonymous">
                                </script>

                                <button data-oper="modify" class="btn btn-warning btn-user btn-block">Modify</button>
                                <button data-oper="home" class="btn btn-secondary btn-user btn-block">Home</button>
                            <sec:authorize access="hasRole('ROLE_USER')">
                            <button data-oper="list" class="btn btn-primary btn-user btn-block">List</button>
                            </sec:authorize>
                            <form id='operForm' action="/member/modify" method="get">
                                <input type='hidden' id='mno' name='mno' value='<c:out value="${member.mno }"/>'>
                                <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                                <input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                                <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                                <input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>

    <%--fileupload --%>
    <script>
        $(document).ready(function(){
            /* modify 데이터 처리  */
            var operForm = $("#operForm");
            $("button[data-oper='modify']").on("click", function(e){
                operForm.attr("action", "/member/modify").submit();
            });
            $("button[data-oper='home']").on("click", function(e){
                operForm.find("#mno").remove();
                operForm.attr("action", "/");
                operForm.submit();
            });
            $("button[data-oper='list']").on("click", function(e){
                operForm.find("#mno").remove();
                operForm.attr("action", "/member/list");
                operForm.submit();
            });
        });
    </script>
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
                    url: '/upload/uploadAjaxAction',
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
                        str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
                        str += "<span>"+obj.fileName+"</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
                        str += "<i class='fa fa-times'></i></button><br>";
                        str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
                        str += "</div></li>";
                    }else{
                        var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
                        var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
                        str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
                        str += "<span>"+obj.fileName+"</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>";
                        str += "<i class='fa fa-times'></i></button><br>";
                        str += "<img src='/resources/img/attach.png'>";
                        str += "</div></li>";
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
    <script type="text/javascript">
        $(document).ready(function(){
            (function(){
                var mno = '<c:out value="${member.mno}"/>';
                $.getJSON("/member/getAttachList", {mno: mno}, function(arr){
                    console.log(arr);
                    var str = "";
                    $(arr).each(function(i, attach){
                        if(attach.fileType){
                            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);

                            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
                            str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
                            str += "</div></li>";
                        }else{
                            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
                            str += "<span> "+ attach.fileName+"</span><br/>";
                            str += "<img src='/resources/img/attach.png'></a>";
                            str += "</div></li>";
                        }
                    });
                    $(".uploadResult ul").html(str);
                }); //getJSON
            })(); //function

            $(".uploadResult").on("click","li", function(e){
                console.log("view image");
                var liObj = $(this);
                var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));

                    self.location ="/upload/download?fileName="+path
            });
            function showImage(fileCallPath){
// 				    alert(fileCallPath);
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
</body>
</html>
