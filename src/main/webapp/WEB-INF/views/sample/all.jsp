<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- all or member or admin -->
<a href="/">Home</a>
<h1>/sample/all page</h1>

<sec:authorize access="isAuthenticated()">
  <form action="/logout" method='post'>
    <div>
      <strong><sec:authentication property="principal.member.name"/></strong>님 반갑습니다.
    </div>
    <div>
      <button>로그아웃</button>
    </div>
    <input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
  </form>
  <hr>
  <p>principal : <sec:authentication property="principal"/></p>
  <p>MemberVO : <sec:authentication property="principal.member"/></p>
<%--  <p>사용자이름 : <sec:authentication property="principal.member.username"/></p>
  <p>사용자아이디 : <sec:authentication property="principal.member.userid"/></p>--%>
  <p>사용자 권한 리스트  : <sec:authentication property="principal.member.authList"/></p>
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

</body>
</html>
