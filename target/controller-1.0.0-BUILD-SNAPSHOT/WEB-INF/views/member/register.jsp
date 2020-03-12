<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>


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
    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                <div class="col-lg-7">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                        </div>
                        <form action="/member/register" method="post" id="membercheck" >
                            <div class="form-group">
                                <input type="text" id="id" class="form-control form-control-user"  name='id' placeholder="아이디">
                                <span id="idchk" style="color: red"></span>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="password" id="pw1" class="form-control form-control-user" name="password"  placeholder="비밀번호">
                                    <span id="pwchk" style="color: red"></span>
                                </div>
                                <div class="col-sm-6">
                                    <input type="password" id="pw2" class="form-control form-control-user" placeholder="비밀번호 확인">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="text" class="form-control form-control-user" id="name" name="name" placeholder="이름">
                                    <span id="namechk" style="color: red"></span>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-control form-control-user">
                                        <label style="margin-right: 0.1rem; color:#6e707e;">남자</label>
                                        <input type="radio" name="gender" value="남자" style="background: #6e707e;">
                                        <label style="margin-left: 1rem; margin-right: 0.1rem; color:#6e707e;">여자</label>
                                        <input type="radio" name="gender" value="여자" style="background: #6e707e;">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="text" id="birth" class="form-control form-control-user"  name='birth' placeholder="생년월일" readonly="readonly">
                                <span id="birthchk" style="color: red"></span>
                            </div>
                            <div class="form-group">
                                <input type="text"  class="form-control form-control-user" id="email" name="email" placeholder="이메일">
                                <span id="emailchk" style="color: red"></span>
                            </div>
                            <div class="form-group" class="form-control form-control-user">
                                <input type = "text" name = "tel1" id="tel1" maxlength="3" size = "5" value="010" placeholder="010" style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .375rem .75rem;">  -
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
                            <button type="submit" id="p_submit_btn" class="btn btn-primary btn-user btn-block">Register Account</button>
                            <%--<hr>
                            <a href="#" class="btn btn-google btn-user btn-block">
                                <i class="fab fa-google fa-fw"></i> Register with Google
                            </a>
                            <a href="#" class="btn btn-facebook btn-user btn-block">
                                <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                            </a>--%>
                            <input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }" />
                        </form>
                        <hr>
                        <div class="text-center">
                            <a class="small" href="#">Forgot Password?</a>
                        </div>
                        <div class="text-center">
                            <a class="small" href="/login">Already have an account? Login!</a>
                        </div>
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


<%--register check--%>
<script>


/*

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
*/

    //모든 공백 체크 정규식
    var empJ = /\s/g;
    //아이디 정규식
    var idJ =  /^[a-z0-9][a-z0-9_\-]{0,10}$/;
    // 비밀번호 정규식
    var pwJ = /^[A-Za-z0-9]{0,12}$/;
    // 이름 정규식
    var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
    // 이메일 검사 정규식
    var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

    $(document).ready(function () {
        $("#id").blur(function(){
            if($("#id").val() == ''){
                $("#idchk").text("아이디를 입력하세요");
                $("#idchk").css("color", 'red');
            }else if(idJ.test($('#id').val()) != true){
                $("#idchk").text("1자 이상, 10자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용가능합니다.");
                $("#idchk").css("color", 'red');
            }else if($('#id').val() != ''){
                var id = $('#id').val();
                $.ajax({
                    type : "get",
                    url : "./idChk?id="+id,
                    dataType:'json',
                    success : function(data) {
                        if (data == 1){
                            $("#idchk").text("중복된 아이디 입니다.");
                            $("#idchk").css("color", 'red');
                            $("#membercheck").attr("disabled", true);
                        }else {
                            if(idJ.test(id)){
                            $("#idchk").text("");
/*                            $("#idchk").css("color", 'blue');*/
                            $("#membercheck").attr("disabled",false);
                            }else if(id ==''){
                                $("#idchk").text("아이디를 입력해주세요");
                                $("#idchk").css("color", 'red');
                                $("#membercheck").attr("disabled", true);
                            }else{
                                $("#idchk").text("1자 이상, 10자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용가능합니다.");
                                $("#idchk").css("color", 'red');
                                $("#membercheck").attr("disabled", true);
                            }
                        }
                    }/*,
                    error:function (error) {
                        console.log("error"+error);
                    }*/
                }); //ajax
            }//else if
        });//blur

        $('form').on('submit', function () {
            var inval_Arr = new Array(8).fill(false);
            if(idJ.test($('#id').val())){
                inval_Arr[0] = true;
            }else{
                inval_Arr[0] = false;
                alert('아이디를  확인하세요.');
                return false;
            }

            if(($('#pw1').val() == ($('#pw2').val()))
                && pwJ.test($('#pw1').val())){
                inval_Arr[1] = true;
            }else{
                inval_Arr[1] = false;
                alert('비밀번호를 확인하세요.');
                return false;
            }

            if (nameJ.test($('#name').val())) {
                inval_Arr[2] = true;
            } else {
                inval_Arr[2] = false;
                alert('이름을 확인하세요.');
                return false;
            }

            if(!($('input:radio[name=gender]').is(':checked'))){
                inval_Arr[3] = false;
                alert('성별을 확인하세요.');
                return  false;
            } else{
                inval_Arr[3] = true;
            }

            if ($('#birth').val() != "") {
                inval_Arr[4] = true;
            } else {
                inval_Arr[4] = false;
                alert('생년월일을 확인하세요.');
                return false;
            }

            if (emailJ.test($('#email').val())){
                inval_Arr[5] = true;
            } else {
                inval_Arr[5] = false;
                alert('이메일을 확인하세요.');
                return false;
            }

            if($('#tel2').val() != "" && $('#tel3').val() != ""){
                inval_Arr[6] = true;
            }else{
                inval_Arr[6] = false;
                alert("휴대폰 번호를 확인하세요.")
                return false;
            }

            if($('#sample6_postcode').val() != '' && $('#sample6_detailAddress').val() != ''){
                inval_Arr[7] = true;
            }else{
                inval_Arr[7] = false;
                alert("주소를 확인하세요.");
                return false;
            }

            var validAll = true;
            for(var i =0; i<inval_Arr.length; i++){
                if(inval_Arr[i] == false){
                    validAll = false;
                }
            }
            if(validAll == true){
                alert("반갑습니다.");
            }else{
                alert("입력한 정보를 다시 확인하세요.")
            }
        }); //form submit

        $('#id').blur(function() {
            if (idJ.test($('#id').val())) {
                console.log('true');
                $('#idchk').text('');
            } else {
                console.log('false');
                $('#idchk').text('1자 이상, 10자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용가능합니다.');
                $('#idchk').css('color', 'red');
            }
        });
        $('#pw1').blur(function() {
            if (pwJ.test($('#pw1').val())) {
                console.log('true');
                $('#pwchk').text('');
            } else {
                console.log('false');
                $('#pwchk').text('1~12자의 숫자 , 문자로만 사용 가능합니다.');
                $('#pwchk').css('color', 'red');
            }
        });
        //1~2 패스워드 일치 확인
        $('#pw2').blur(function() {
            if ($('#pw1').val() != $(this).val()) {
                $('#pwchk').text('비밀번호가 일치하지 않습니다.');
                $('#pwchk').css('color', 'red');
            } else {
                $('#pwchk').text('');
            }
        });
        //이름에 특수문자 들어가지 않도록 설정
        $("#name").blur(function() {
            if (nameJ.test($(this).val())) {
                console.log(nameJ.test($(this).val()));
                $("#namechk").text('');
            } else {
                $('#namechk').text('한글 2~4자 이내로 입력하세요. (특수기호, 공백 사용 불가)');
                $('#namechk').css('color', 'red');
            }
        });
        $("#birth").blur(function () {
            var birth = $("#birth").val();
            var now = new Date();
            var yearNow = now.getFullYear();

            if(yearNow-(birth.substr(0,4)) < 14){
                $('#birthchk').text('14세 미만은 회원가입 불가능 합니다.');
                $('#birthchk').css('color', 'red');
            }else{
                $('#birthchk').text('');
            }
        $("#email").blur(function() {
            if (emailJ.test($(this).val())) {
                $("#emailchk").text('');
            } else {
                $('#emailchk').text('이메일 양식을 확인해주세요.');
                $('#emailchk').css('color', 'red');

            }
        });
        });
        $('#tel1').blur(function () {
            checkTel();
        });
        $('#tel2').blur(function () {
            checkTel();
        });
        $('#tel3').blur(function () {
            checkTel();
        });
        function checkTel() {
            var tel1 = $("#tel1").val();
            var tel2 = $("#tel2").val();
            var tel3 = $("#tel3").val();
            var tel = tel1+"-"+tel2+"-"+tel3;
            var telC =/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

            if(telC.test(tel)){
                $('#telchk').text('');
            }else{
                $('#telchk').text('휴대폰 번호를 확인해주세요.');
                $('#telchk').css('color', 'red');
            }
        }



    }); //ready


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
