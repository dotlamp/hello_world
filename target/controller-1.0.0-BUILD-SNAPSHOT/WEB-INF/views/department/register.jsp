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
                            <h1 class="h4 text-gray-900 mb-4">지점 등록</h1>
                        </div>
                        <form action="/department/register" method="post" id="membercheck" >
                            <div class="form-group">
                                <input type="text" id="id" class="form-control form-control-user"  name='name' placeholder="지점명">
                                <span id="idchk" style="color: red"></span>
                            </div>
                            <div class="form-group" class="form-control form-control-user">
                                <input type = "text" name = "tel1" id="tel1" maxlength="3" size = "5"  style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .375rem .75rem;">  -
                                <input type = "text" name = "tel2" id="tel2" maxlength="4" size = "5"  style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .375rem .75rem;">  -
                                <input type = "text" name = "tel3" id="tel3" maxlength="4" size = "5"style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .375rem .75rem;">
                                <span id="telchk" style="color: red"></span>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="text" id="sample6_postcode" name="post" placeholder="우편번호" readonly="readonly" class="form-control form-control-user" >
                                </div>
                                <div class="col-sm-6">
                                    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"style="border: 1px solid #d1d3e2; border-radius:35rem; padding: .375rem .75rem; background: #4e73df; color: #fff; font-size: 1rem;" >
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="text" id="sample6_address" name="adr1" placeholder="주소" readonly="readonly" class="form-control form-control-user" >
                                </div>
                                <div class="col-sm-6">
                                    <input type="text" id="sample6_detailAddress" name="adr2" placeholder="상세주소" class="form-control form-control-user" >
                                    <input type="hidden" id="sample6_extraAddress" name="adr3" placeholder="참고항목" class="form-control form-control-user" >
                                    <span id="adrchk" style="color: red"></span>
                                </div>
                            </div>
                            <button type="submit"  class="btn btn-primary btn-user btn-block">지점 등록</button>
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

</body>
</html>
