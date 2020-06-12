<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/main"/>
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Module V_0.1</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/main">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Dashboard</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
               정훈
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-cog"></i>
          <span>개발스터디</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">테스트영역</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/member/management/viewMemberList">일반회원관리목록</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/viewTestFile">TESTFILEUPLOAD</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/products">Cards</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/sourceMaker">소스Maker</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/viewQuiz">Quiz</a>
          </div>
        </div>
      </li>

      <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-fw fa-wrench"></i>
          <span>없는 메뉴</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Custom Utilities:</h6>
            <a class="collapse-item" href="#">Colors</a>
            <a class="collapse-item" href="#">Borders</a>
            <a class="collapse-item" href="#">Animations</a>
            <a class="collapse-item" href="#">Other</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        최선길
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>개발스터디</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">최선길의 개발 스터디</h6>
            <a class="collapse-item" href="#">Sample</a>
<!--             <a class="collapse-item" href="#">Register</a> -->
<!--             <a class="collapse-item" href="#">Forgot Password</a> -->
<!--             <div class="collapse-divider"></div> -->
<!--             <h6 class="collapse-header">Other Pages:</h6> -->
<!--             <a class="collapse-item" href="#">404 Page</a> -->
<!--             <a class="collapse-item" href="#">Blank Page</a> -->
          </div>
        </div>
      </li>
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        박서은
      </div>

      <!-- Nav Item - Charts -->
      <li class="nav-item">
         <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages1" aria-expanded="true" aria-controls="collapsePages1">
          <i class="fas fa-fw fa-folder"></i>
          <span>개발스터디</span>
        </a>
     <div id="collapsePages1" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">박서은의 개발 스터디</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/demo1/pse/dailyDiaryList">SEOEUN'S DAILY DIARY</a>
<!--             <a class="collapse-item" href="#">Register</a> -->
<!--             <a class="collapse-item" href="#">Forgot Password</a> -->
<!--             <div class="collapse-divider"></div> -->
<!--             <h6 class="collapse-header">Other Pages:</h6> -->
<!--             <a class="collapse-item" href="#">404 Page</a> -->
<!--             <a class="collapse-item" href="#">Blank Page</a> -->
          </div>
        </div>
      </li>

      <!-- Nav Item - Tables -->
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fas fa-fw fa-table"></i>
          <span>테스트</span></a>
      </li>
      <hr class="sidebar-divider">
      <div class="sidebar-heading">
        공통
      </div>

      <!-- Nav Item - Charts -->
      <li class="nav-item">
         <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="true" aria-controls="collapsePages2">
          <i class="fas fa-fw fa-folder"></i>
          <span>개발스터디</span>
        </a>
     <div id="collapsePages2" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">공통 샘플 게시</h6>
            <a class="collapse-item" href="#">Sample</a>
<!--             <a class="collapse-item" href="#">Register</a> -->
<!--             <a class="collapse-item" href="#">Forgot Password</a> -->
<!--             <div class="collapse-divider"></div> -->
<!--             <h6 class="collapse-header">Other Pages:</h6> -->
<!--             <a class="collapse-item" href="#">404 Page</a> -->
<!--             <a class="collapse-item" href="#">Blank Page</a> -->
          </div>
        </div>
      </li>


      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>


    <script>
     function fn_changeContent (goUrl) {

         console.log("dd");
         $('#site-content').children().remove().load("/home1");
     }

    </script>