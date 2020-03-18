<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@include file="../includes/header.jsp" %>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="card shadow mb-4">

        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Member</h6>
        </div>
        <%--/.card-header py-3--%>

        <div class="card-body">
            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                <div class="row">
                    <div class="col-sm-12 col-md-11">
                        <label>Show
                            <select name="dataTable_length" aria-controls="dataTable" class="amount" style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .1rem .75rem;">
                                <option name='amount' data-name="10">10</option>
                                <option name='amount' data-name="20">20</option>
                                <option name='amount' data-name="50">50</option>
                                <option name='amount' data-name="100">100</option>
                            </select> entries</label>
                    </div>
                </div>
               <%--/.row--%>

                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <%--<th>지점</th>--%>
                                    <th>아이디</th>
                                    <th>이름</th>
                                    <th>성별</th>
                                    <th>나이</th>
                                    <th>연락처</th>
                                    <th>email</th>
                                    <th>주소</th>
                                    <th>가입일</th>
                                    <th>권한</th>
                                    <th>권한</th>
                                </tr>
                            </thead>
                           <tbody>
<%--                           <c:set value="${pageMaker.cri.pageNum }" var="pageNum"/>
                           <c:set value="${pageMaker.cri.amount }" var="amount"/>
                           <c:set value="${((pageNum-1)*amount)+1}" var="tableNum" />--%>
                               <c:forEach items="${list}" var="member">
                                <tr>
                                    <td><c:out value="${member.mno}"/></td>
                                    <%--<td>지점명</td>--%>
                                    <td><a class='getmove' href="<c:out value="${member.mno}" />"><c:out value="${member.id}" /></a></td>
                                    <td><a class='getmove' href="<c:out value="${member.mno}" />"><c:out value="${member.name}" /></a></td>
                                    <td><c:out value="${member.gender}"/></td>
                                    <%--나이계산--%>
                                        <c:set var="now" value="<%=new java.util.Date()%>" />
                                        <c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
                                        <c:set var="birthYear" value="${member.birth}"/>
                                        <c:set var="birthYear" value="${fn:substring(birthYear, 0, 4)}" />
                                        <c:set var="age" value="${sysYear-birthYear+1}" />
                                    <td> <c:out value="${age}세" /></td>
                                    <%--<td><c:out value="${member.birth}"/></td>--%>
                                    <td><c:out value="${member.tel1}"/>-<c:out value="${member.tel2}"/>-<c:out value="${member.tel3}"/></td>
                                    <td><c:out value="${member.email}"/></td>
                                    <td><c:out value="${member.adr1}"/><c:out value="${member.adr3}"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate }" /></td>
                                    <td>
                                        <c:forEach items="${member.authList}" var="auth" varStatus="status">
                                        ${auth['auth']}
                                    </c:forEach>
                                    </td>
                                    <td>
                                        <c:url var="changeRoleUrl" value="/member/auth/${member.mno}"/>
                                        <a href="${changeRoleUrl}/admin" class="btn <c:if test="${ member.hasAuth('ADMIN')}" >btn-success </c:if>" >관리자</a>
                                        <a href="${changeRoleUrl}/manager" class="btn <c:if test="${ member.hasAuth('MANAGER')}" >btn-success </c:if>" >매니저</a>
                                        <a href="${changeRoleUrl}/user" class="btn <c:if test="${ member.hasAuth('USER')}" >btn-success </c:if>" >사용자</a>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                 </div>
                <%--/.row--%>

                <div class="row">
                    <div class="col-sm-12 col-md-5">
                        <div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">
                            <form id='searchForm' action="/member/list" method="get">
                            <lable>Total : <c:out value="${pageMaker.total}"/></lable>
                            <label>| Search : </label>
                                <select name='type' style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .1rem .75rem;">
                                <option value=""
                                        <c:out value="${pageMaker.cri.type == null? 'selected':'' }"/>>--</option>
                                <option value="N"
                                        <c:out value="${pageMaker.cri.type eq 'N'? 'selected':'' }"/>>이름</option>
                                <option value="G"
                                        <c:out value="${pageMaker.cri.type eq 'G'? 'selected':'' }"/>>성별</option>
                                <option value="B"
                                        <c:out value="${pageMaker.cri.type eq 'B'? 'selected':'' }"/>>나이</option>
                                <option value="T"
                                        <c:out value="${pageMaker.cri.type eq 'T'? 'selected':'' }"/>>연락처</option>
                                <option value="E"
                                        <c:out value="${pageMaker.cri.type eq 'E'? 'selected':'' }"/>>메일</option>
                                <option value="A"
                                        <c:out value="${pageMaker.cri.type eq 'A'? 'selected':'' }"/>>주소</option>
                                <option value="R"
                                        <c:out value="${pageMaker.cri.type eq 'R'? 'selected':'' }"/>>권한</option>
                            </select>
                            <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .1rem .75rem;"/>
                            <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }' />
                            <input type='hidden' name='amount' value='${pageMaker.cri.amount }' />
                            <button class="btn btn-secondary btn-sm">검색</button>
                            </form>
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-7">
                        <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                            <ul class="pagination">
                                <c:if test="${pageMaker.prev}">
                                    <li class="paginate_button page-item previous" id="dataTable_previous">
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
                <%--/.row--%>
            </div>
            <%--/.dataTable_wrapper--%>
        </div>
        <%--/.card-body--%>
    </div>
    <%--/.card shadow mb-4--%>
</div>
<!-- /.container-fluid -->

<form id='actionForm' action="/member/list" method="get">
    <input type='hidden' name='amount' class='amount_input' value='${pageMaker.cri.amount }' >
    <input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
    <input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
    <input type='hidden' name='pageNum' class='pageNum_input' value='${pageMaker.cri.pageNum }' >
</form>

<%@include file="../includes/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        var actionForm = $("#actionForm");
        $(".paginate_button a").on("click", function(e){
            e.preventDefault();
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });


        $('.amount').change(function (){
            var name = $("option:selected", this).data("name");
            $('.amount_input').val(name);
            $('.pageNum_input').val("1");
            actionForm.val($(this).attr("href"));
            actionForm.submit();
        });

        $('.amount option').each(function () {
            if($(this).val() == "${pageMaker.cri.amount }"){
                $(this).attr("selected", "selected");
            }
        });

        /* /member/get*/
        $('.getmove').click(function (e) {
            e.preventDefault();
            actionForm.append("<input type='hidden' name='mno' value='"+ $(this).attr("href") +"'>");
            actionForm.attr("action", "/member/get");
            actionForm.submit();
        });

        var searchForm = $("#searchForm");
        $("#searchForm button").on("click", function(e){
            if(!searchForm.find("option:selected").val()){
                alert("검색종류를 선택하세요");
                return false;
            }
            if(!searchForm.find("input[name='keyword']").val()){
                alert("키워드를 입력하세요");
                return false;
            }
            searchForm.find("input[name='pageNum']").val("1");
            e.preventDefault();
            searchForm.submit();
        });


    });
</script>