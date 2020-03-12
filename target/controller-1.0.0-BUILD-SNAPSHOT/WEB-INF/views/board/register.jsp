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

    <title>Hello world - Board Register</title>

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
                                <h1 class="h4 text-gray-900 mb-4">Post a notice</h1>
                            </div>
                            <form action="/board/register" method="post" id="f_register" >
                                <div class="form-group">
                                    <input type="text" id="title" class="form-control form-control-user"  name='title' placeholder="제목">
                                </div>
                                <div class="form-group">
                                        <textarea type="text" id="content" class="form-control form-control-user" name="content" style="height: 20rem" ></textarea>
                                </div>

                                <div class="form-group">
                                    <div class="panel-body">
                                        <div class="pi_from">
                                            <label style="width: 5rem">첨부파일</label> <input type="file" name="uploadFile" multiple>
                                        </div>
                                        <!-- /.form-group uploadDiv  -->
                                        <div class="uploadResult">
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
                                <button type="submit" id="p_submit_btn" class="btn btn-primary btn-user btn-block">Post a notice</button>
                                <sec:authorize access="isAuthenticated()">
                                <input type="hidden" name="writer" value="<sec:authentication property="principal.member.mno"/>" >
                                </sec:authorize>
                                <input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }" />
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
        $(document).ready(function(e){
            var formObj = $("#f_register");
            $("button[type='submit']").on("click", function(e){
                e.preventDefault();
                console.log("submit clicked");
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

</body>
</html>
