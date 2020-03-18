<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<html lang="ko">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Hello world </title>

    <!-- Custom fonts for this template -->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" media="screen">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet" media="screen">

    <!-- Custom styles for this page -->
    <link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" media="screen">

</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">Hello world </div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0">

        <!-- Divider -->
        <hr class="sidebar-divider">
        <!-- Heading -->
        <div class="sidebar-heading">
            Department
        </div>

        <!-- A부서 -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                <i class="fas fa-fw fa-folder"></i>
                <span>A부서</span>
            </a>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">A부서 / 000 - 0000 - 0000</h6>
                    <a class="collapse-item" href="/department/hello">소개</a>
                    <a class="collapse-item" href="/department/list">게시판</a>
                    <a class="collapse-item" href="/department/worker">부서원</a>
                </div>
            </div>
        </li>

        <!-- B부서 -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseTwo">
                <i class="fas fa-fw fa-folder"></i>
                <span>B부서</span>
            </a>
            <div id="collapseUtilities" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">B부서 / 000 - 0000 - 0000</h6>
                    <a class="collapse-item" href="/department/hello">소개</a>
                    <a class="collapse-item" href="/department/list">게시판</a>
                    <a class="collapse-item" href="/department/worker">부서원</a>
                </div>
            </div>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <div class="sidebar-heading">
            about
        </div>

        <!-- Nav Item - Dashboard -->
        <li class="nav-item active">
            <a class="nav-link" href="/hello">
                <i class="fas fa-fw fa-folder"></i>
                <span>기업소개</span></a>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
            Board
        </div>

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapseTwo">
                <i class="fas fa-fw fa-folder"></i>
                <span>News</span>
            </a>
            <div id="collapsePages" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a class="collapse-item" href="/board/list">공지사항</a>
                    <a class="collapse-item" href="/board/gallery">갤러리</a>
                </div>
            </div>
        </li>


        <!-- Nav Item - Tables -->
        <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
        <hr class="sidebar-divider">
            <%--<sec:authorize access="hasRole('ROLE_ADMIN')">--%>
            <%--<sec:authorize access="!hasRole('ROLE_ADMIN')">--%>
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAAA" aria-expanded="true" aria-controls="collapseTwo">
                        <i class="fas fa-fw fa-folder"></i>
                        <span>Admin</span>
                    </a>
                    <div id="collapseAAA" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="/member/list">회원관리</a>
                            <a class="collapse-item" href="/department/list">부서관리</a>
                        </div>
                    </div>
                </li>
        </sec:authorize>
        <!-- Divider -->
        <hr class="sidebar-divider d-none d-md-block">

        <!-- Sidebar Toggler (Sidebar) -->
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                <!-- Sidebar Toggle (Topbar) -->
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <%--<!-- Topbar Search -->
                <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                    <div class="input-group">
                        <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button">
                                <i class="fas fa-search fa-sm"></i>
                            </button>
                        </div>
                    </div>
                </form>--%>

                <!-- Topbar Navbar -->
                <ul class="navbar-nav ml-auto">

                    <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                    <li class="nav-item dropdown no-arrow d-sm-none">
                        <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-search fa-fw"></i>
                        </a>
                        <!-- Dropdown - Messages -->
                        <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                            <form class="form-inline mr-auto w-100 navbar-search">
                                <div class="input-group">
                                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary" type="button">
                                            <i class="fas fa-search fa-sm"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </li>
                    <sec:authorize access="isAnonymous()">
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="/login" role="button">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                                <strong>Login</strong>
                                <img class="img-profile rounded-circle" src="/resources/img/navi_profile.jpg">
                            </span>
                            </a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <%--<!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've noticed unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>--%>

                        <%-- <!-- Nav Item - Messages -->
                         <li class="nav-item dropdown no-arrow mx-1">
                             <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                 <i class="fas fa-envelope fa-fw"></i>
                                 <!-- Counter - Messages -->
                                 <span class="badge badge-danger badge-counter">7</span>
                             </a>
                             <!-- Dropdown - Messages -->
                             <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                                 <h6 class="dropdown-header">
                                     Message Center
                                 </h6>
                                 <a class="dropdown-item d-flex align-items-center" href="#">
                                     <div class="dropdown-list-image mr-3">
                                         <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                                         <div class="status-indicator bg-success"></div>
                                     </div>
                                     <div class="font-weight-bold">
                                         <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div>
                                         <div class="small text-gray-500">Emily Fowler · 58m</div>
                                     </div>
                                 </a>
                                 <a class="dropdown-item d-flex align-items-center" href="#">
                                     <div class="dropdown-list-image mr-3">
                                         <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                                         <div class="status-indicator"></div>
                                     </div>
                                     <div>
                                         <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                                         <div class="small text-gray-500">Jae Chun · 1d</div>
                                     </div>
                                 </a>
                                 <a class="dropdown-item d-flex align-items-center" href="#">
                                     <div class="dropdown-list-image mr-3">
                                         <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                                         <div class="status-indicator bg-warning"></div>
                                     </div>
                                     <div>
                                         <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                                         <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                     </div>
                                 </a>
                                 <a class="dropdown-item d-flex align-items-center" href="#">
                                     <div class="dropdown-list-image mr-3">
                                         <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                                         <div class="status-indicator bg-success"></div>
                                     </div>
                                     <div>
                                         <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                                         <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                     </div>
                                 </a>
                                 <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                             </div>
                         </li>--%>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->

                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                                <strong><sec:authentication property="principal.member.name"/> </strong> 님
                               <sec:authentication var="member" property="principal.member"/>
                                <c:forEach items="${member.attachList}" var="attach">
                                    <c:set var='uploadPath' value="${attach['uploadPath']}"/>
                                    <c:set var='uuid' value="${attach['uuid']}"/>
                                    <c:set var='fileName' value="${attach['fileName']}"/>
                                <c:if test="${empty fileName}">
                                    <img class="img-profile rounded-circle" src="/resources/img/navi_profile.jpg">
                                </c:if>
                                <c:if test="${not empty fileName}">
                                    <img class="img-profile rounded-circle" src="/upload/display?fileName=<c:out value='${uploadPath}/s_${uuid}_${fileName}' />">
                                </c:if>
                               <%-- <img class="img-profile rounded-circle" src="/resources/img/profile/s_<c:out value='${uuid}_${fileName}'/> ">--%>
                                 <%--<c:out value="${uploadPath}\\${uuid}_${fileName}"/>--%>
                                </c:forEach>
                            </a>
                            <!-- Dropdown - User Information -->

                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="/member/get?mno=<sec:authentication property="principal.member.mno"/>">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="/member/password">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    ChangePassword
                                </a>
                                    <%--<a class="dropdown-item" href="#">
                                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Activity Log
                                    </a>--%>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </sec:authorize>
                </ul>
            </nav>
