<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Hello world - Register</title>

    <link rel="stylesheet" type="text/css" href="/resources/vendor/datetimepicker/jquery.datetimepicker.css" media="screen"/>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" media="screen">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet" media="screen">

</head>
<body>
    <div class="container">
        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">비밀번호 입력</h1>
                                        <p class="mb-4">비밀번호 확인 후 변경이 가능합니다.</p>
                                    </div>
                                    <form action="/member/passwordChange" method='post'>
                                        <div class="form-group">
                                            <input type="password" id="pw1" class="form-control form-control-user" name="password"  placeholder="비밀번호">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" id="pw2" class="form-control form-control-user" placeholder="비밀번호 확인">
                                        </div>
                                        <div class="form-group">
                                            <span id="pwchk" style="color: red"></span>
                                        </div>
                                        <button type='submit' class="btn btn-primary btn-user btn-block">확인</button>
                                        <input type="hidden" name="mno"  value="<sec:authentication property="principal.member.mno"/>">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    </form>
                                    <hr>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>
    <script>
        $("#pw1").blur(function() {
            checkPw1();
        });
        $("#pw2").blur(function() {
            checkPw2();
        });

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

    </script>
</body>
</html>
