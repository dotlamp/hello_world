<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%@include file="../includes/header.jsp" %>


<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="card shadow mb-4">

        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">
                Board
            </h6>
        </div>
        <%--/.ard-header py-3--%>

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
                    <div class="col-sm-12 col-md-1">
                        <button id="regBtn" type="button" class="btn btn-secondary btn-user btn-block btn-sm">글작성</button>
                    </div>
                </div>
                <%--/.row--%>

                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>조회수</th>
                                <th>작성일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set value="${pageMaker.cri.pageNum }" var="pageNum"/>
                            <c:set value="${pageMaker.cri.amount }" var="amount"/>
                            <c:set value="${((pageNum-1)*amount)+1}" var="startNo" />
                            <c:set value="${pageNum*amount}" var="endNo" />

                            <c:forEach items="${list}" var="board" >
                                <tr>
                                    <td><c:out value="${board.bno}" /></td>
                                    <td>
                                        <a class='getmove' href="<c:out value="${board.bno}" />">
                                            <strong><c:out value="${board.title}" /></strong>
                                            <small>(<c:out value="${board.replyCnt}"/>)</small>
                                        </a>
                                    </td>
                                    <c:forEach items="${board.memberList}" var="member">
                                        <td><c:out value="${member['name']}" /> </td>
                                    </c:forEach>
                                    <td><c:out value="${board.viewCnt}"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }" /></td>
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
                            <form id='searchForm' action="/board/list" method="get">
                            <lable>Total : <c:out value="${pageMaker.total}"/></lable>
                            <label>| Search : </label>
                            <select name='type' style="color: #6e707e; border: 1px solid #d1d3e2; border-radius:35rem; padding: .1rem .75rem;">
                                <option value=""
                                        <c:out value="${pageMaker.cri.type == null? 'selected':'' }"/>>--</option>
                                <option value="T"
                                        <c:out value="${pageMaker.cri.type eq 'T'? 'selected':'' }"/>>제목</option>
                                <option value="C"
                                        <c:out value="${pageMaker.cri.type eq 'C'? 'selected':'' }"/>>내용</option>
                                <option value="W"
                                        <c:out value="${pageMaker.cri.type eq 'W'? 'selected':'' }"/>>작성자</option>
                                <option value="TC"
                                        <c:out value="${pageMaker.cri.type eq 'TC'? 'selected':'' }"/>>제목, 내용</option>
                                <option value="TW"
                                        <c:out value="${pageMaker.cri.type eq 'TW'? 'selected':'' }"/>>제목, 작성자</option>
                                <option value="TWC"
                                        <c:out value="${pageMaker.cri.type eq 'TWC'? 'selected':'' }"/>>제목, 내용, 작성자</option>
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
                <%--/.row--%>
            </div>
            <%--/.dataTable_wrapper--%>
        </div>
        <%--/.card-body--%>
    </div>
    <%--/.rd shadow mb-4--%>
</div>
<!-- /.container-fluid -->


<form id='actionForm' action="/board/list" method="get">
    <input type='hidden' name='amount' class='amount_input' value='${pageMaker.cri.amount }' >
    <input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
    <input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
    <input type='hidden' name='pageNum' class='pageNum_input' value='${pageMaker.cri.pageNum }' >
</form>

<%@include file="../includes/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        $("#regBtn").on("click", function(){
            self.location = "/board/register";
        });

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
            actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href") +"'>");
            actionForm.attr("action", "/board/get");
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