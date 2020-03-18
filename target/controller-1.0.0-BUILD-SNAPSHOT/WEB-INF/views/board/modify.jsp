<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


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
                                <h1 class="h4 text-gray-900 mb-4">Board!</h1>
                            </div>
                            <form action="/board/modify" method="post" id="f_register" >
                            <div class="form-group">
                                <label>제목</label><input type="text" id="title" class="form-control form-control-user"  name='title'
                                       value='<c:out value="${board.title}"/>' placeholder="제목">
                            </div>
                            <div class="form-group">
                                <label>내용</label>
                                <textarea type="text" id="content" class="form-control form-control-user" name="content" style="height: 20rem"  ><c:out value="${board.content}"/></textarea>
                            </div>

                                <div class="form-group">
                                    <div class="panel-body">
                                        <div class="pi_from">
                                            <label style="width: 5rem">첨부파일</label> <input type="file" name="uploadFile">
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
                                <hr>
                            <sec:authorize access="isAuthenticated()">
                                <sec:authorize access="hasRole('ROLE_ADMIN')">
                                    <button data-oper="modify" class="btn btn-warning btn-user btn-block">Modify</button>
                                    <button data-oper="remove" class="btn btn-danger btn-user btn-block">Remove</button>
                                </sec:authorize>
                                <c:forEach items="${board.memberList}" var="member">
                                    <sec:authentication property="principal" var="pinfo"/>
                                    <c:set value="${pinfo.username}" var="username" />
                                    <c:set value="${member.id}" var="id" />
                                    <sec:authorize access="hasRole('ROLE_USER')">
                                        <c:if test="${username eq id}">
                                            <button data-oper="modify" class="btn btn-warning btn-user btn-block">Modify</button>
                                            <button data-oper="remove" class="btn btn-danger btn-user btn-block">Remove</button>
                                        </c:if>
                                    </sec:authorize>
                                </c:forEach>
                            </sec:authorize>
                                <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
                                <input type='hidden' id='writer' name='writer' value='<c:out value="${board.writer }"/>'>
                                <input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }" />

                                <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                                <input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                                <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                                <input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                            </form>
                                <button data-oper="list" class="btn btn-primary btn-user btn-block">List</button>
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

    <script>
        $(document).ready(function(){
            /* button data-oper 이용한 동작처리 */
            var formObj = $("form");
            $('button').on("click", function(e){
                e.preventDefault(); //submit 버튼 비활성화
                var operation = $(this).data("oper");
                console.log(operation);
                if(operation === 'remove'){
                    formObj.attr("action", "/board/remove");
                }else if(operation === 'list'){
                    /* self.location="/board/list"; */
                    /* return; */
                    formObj.attr("action", "/board/list").attr("method", "get");
                    var pageNumTag = $("input[name='pageNum']").clone();
                    var amountTag = $("input[name='amount']").clone();
                    var typeTag = $("input[name='type']").clone();
                    var keywordTag = $("input[name='keyword']").clone();

                    formObj.empty();
                    formObj.append(pageNumTag);
                    formObj.append(amountTag);
                    formObj.append(typeTag);
                    formObj.append(keywordTag);
                }else if(operation === 'modify'){
                    console.log("submit clicked");
                    var str = "";
                    $(".uploadResult ul li").each(function(i, obj){
                        var jobj = $(obj);
                        console.dir(jobj);
                        str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
                        str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
                        str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
                        str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
                    });
                    console.log(str);
                    formObj.append(str).submit();
                }
                formObj.submit(); //submit 버튼 활성화(/board/modify)
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
                        str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
                        str += "<span>"+obj.fileName+"</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-danger btn-circle'>";
                        str += "<i class='fa fa-times'></i></button><br>";
                        str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
                        str += "</div></li>";
                    }else{
                        var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
                        var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
                        str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
                        str += "<span>"+obj.fileName+"</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-danger btn-circle'>";
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
                var bno = '<c:out value="${board.bno}"/>';
                $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
                    console.log(arr);
                    var str = "";
                    $(arr).each(function(i, attach){
                        if(attach.fileType){
                            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);

                            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
                            str += "<span>"+attach.fileName+"</span>";
                            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-danger btn-circle'>";
                            str += "<i class='fa fa-times'></i></button><br>";
                            str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
                            str += "</div></li>";
                        }else{
                            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
                            str += "<span> "+ attach.fileName+"</span>";
                            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-danger btn-circle'>";
                            str += "<i class='fa fa-times'></i></button><br>";
                            str += "<img src='/resources/img/attach.png'></a>";
                            str += "</div></li>";
                        }
                    });
                    $(".uploadResult ul").html(str);
                }); //getJSON
            })(); //function

        });
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


