<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@include file="./includes/header.jsp" %>
<div class="container-fluid">
<sec:authorize access="isAnonymous()">
	<form method='post' action="/login">
		<div>
			<input type='text' name='username'>
		</div>
		<div>
			<input type='password' name='password'>
		</div>
		<div>
			<div>
				<input type='checkbox' name='remember-me'> 로그인상태유지
			</div>
			<div>
				<button type="submit">로그인</button>
				<h3><c:out value="${error}"/></h3>
				<h3><c:out value="${logout}"/></h3>
			</div>
			<input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />

			<a href="/member/register">회원가입</a>
	</form>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<hr>

	<p>principal : <sec:authentication property="principal"/></p>
	<p>MemberVO : <sec:authentication property="principal.member"/></p>
	<p>사용자mno : <sec:authentication property="principal.member.mno"/></p>
	<p>사용자id : <sec:authentication property="principal.member.id"/></p>

	<p>사용자 권한 리스트  : <sec:authentication property="principal.member.authList"/></p>
	<sec:authentication var="member" property="principal.member"/>
	<c:forEach items="${member.attachList}" var="attach">
		<c:set var='uploadPath' value="${attach['uploadPath']}"/>
		<c:set var='uuid' value="${attach['uuid']}"/>
		<c:set var='fileName' value="${attach['fileName']}"/>
		<c:out value="${uploadPath}\\${uuid}_${fileName}"/>
	</c:forEach>
<hr>

	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER','ROLE_USER')">
		<a href="/sample/all">all</a>
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_MANAGER')">
		<a href="/sample/member">member</a>
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<a href="/sample/admin">admin</a>
	</sec:authorize>
</sec:authorize>
</div>

<%@include file="./includes/footer.jsp" %>