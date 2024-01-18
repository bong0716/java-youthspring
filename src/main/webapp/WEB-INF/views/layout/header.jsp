<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

<head>
<style>
.nav-item {
    display: flex;
    align-items: center;
  }

  .nav-item a {
    margin-left: 50px;
    font-size: 4px;
  }

  .nav-item a.active {
    color: green;
  }

  .nav-item a:not(.active) {
    color: gray;
    }
    
  #navFix{
      position: fixed;
      top: 10;
      left: 0;
      right: 0;
      z-index: 999;
      background-color: white;
      
    }
    
    nav {
  display: flex; /* Flexbox 레이아웃 적용 */
  justify-content: center; /* 카테고리들을 수평 중앙 정렬 */
}

.nav-list {
  list-style: none; /* 기본 목록 표시 스타일 제거 */
  display: flex; /* Flexbox 레이아웃 적용 */
  justify-content: space-around; /* 카테고리들 사이의 간격 자동 조정 */
  padding: 0; /* 기본 padding 제거 */
}

.nav-list li {
  margin: 0 10px; /* 카테고리들 사이의 간격을 조정 (원하는 크기로 조정) */
  padding: 5px 10px; /* 각 카테고리의 padding 설정 (원하는 크기로 조정) */
}
    
.fixed-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 999;
  background-color: white;
}


</style>
<script>
$(document).ready(function() {
    $(window).scroll(function() {
      if ($(this).scrollTop() > 0) {
        $('#navFix').addClass('fixed-navbar');
      } else {
        $('#navFix').removeClass('fixed-navbar');
      }
    });
  });

</script>
</head>

<c:if test="${not empty result}">
	<script>
	alert("${result}님 회원가입이 완료되었습니다.");
	</script>
</c:if>
<c:if test="${not empty success}">
	<script>
	alert("회원정보 수정이 완료되었습니다. 다시 로그인 해주세요.");
	</script>
</c:if>
<c:if test="${withdrawal == 'success'}">
	<script>
	alert("탈퇴가 성공적으로 완료되었습니다.");
	</script>
</c:if>

<div style="padding:30px 60px 0px 100px; align: center">  
<nav class="navbar navbar-expand-sm" id="navFix">
<div class="container">
<a href="${cpath}/board/list"><img src="../resources/images/logo.jpg" alt="logo" style="width:300px; padding:0px 200px 0px 0px"></a>
  <div class="vertical-center">
  	<form class="form-inline" action="${cpath}/board/list?query=${userMessage}" style="padding: 0px 0px 0px 40px">
    	<input id="userMessage" name="userMessage" class="form-control mr-sm-2" type="text" placeholder="어떤 정책 찾으세요?" style="width:500px; height:50px; border-color:green; border-radius: 20px; background-color: rgb(228,247,239)">
    	<button style="display: block" class="btn btn-outline-success">
		  <i class="fas fa-search"></i>
		</button>
  	</form>
  </div>
   <c:if test="${empty mvo}"> 
 <div style="text-align: right;">
  <button class="btn btn-outline-dark" onclick="location.href='${cpath}/member/loginProcess'">로그인</button>
  <button class="btn btn-outline-dark" onclick="location.href='${cpath}/member/memberRegister'">회원가입</button>
</div>
  </c:if>
   <c:if test="${!empty mvo}"> 
   <div style="text-align: right;">
   	<font>${mvo.userName}님</font> &nbsp;
    <button id="jua" class="btn btn-outline-dark" onclick="location.href='${cpath}/member/logoutProcess'">로그아웃</button>
   </div>
   </c:if>
 </div>
</nav>
</div>

<div style="padding:120px 100px 0px 100px; align: center">  
<nav class="navbar navbar-expand-sm bg-light navbar-light">
  <a id="jua" class="navbar-brand" href="${cpath}/board/list" style="margin : 0px 0px 0px 0px">청년복지</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse justify-content-center" id="navbarNavDropdown">
    <ul class="navbar-nav">
	   <c:if test="${empty category}">
      <li id="jua" class="nav-item" style="margin : 0px 50px 0px 0px">
        <a class="nav-link" href="${cpath}/board/content?category=employment"><font size="4px">취업/창업</font></a>
      </li>
      <li id="jua" class="nav-item" style="margin : 0px 60px 0px 50px">
        <a class="nav-link" href="${cpath}/board/content?category=finance"><font size="4px">금융</font></a>
      </li>
      <li id="jua" class="nav-item" style="margin : 0px 60px 0px 50px">
        <a class="nav-link" href="${cpath}/board/content?category=residence"><font size="4px">주거</font></a>
      </li>
      <li id="jua" class="nav-item" style="margin : 0px 60px 0px 50px">
        <a class="nav-link" href="${cpath}/board/content?category=culture"><font size="4px">생활/문화</font></a>
      </li>
       </c:if>
        <c:if test="${!empty category}">
        <li id="jua" class="nav-item" style="margin : 0px 50px 0px 100px">
		  <c:choose>
		     <c:when test="${category == 'employment'}">
		      <a class="nav-link" href="${cpath}/board/content?category=employment"><font size="4px" color="green">취업/창업</font></a>
		    </c:when>
		    <c:otherwise>
		      <a class="nav-link" href="${cpath}/board/content?category=employment"><font size="4px" color="gray">취업/창업</font></a>
		    </c:otherwise>
		  </c:choose>
		</li>

		<li id="jua" class="nav-item" style="padding: 0px 50px;">
		  <c:choose>
		    <c:when test="${category == 'finance'}">
		      <a class="nav-link" href="${cpath}/board/content?category=finance"><font size="4px" color="green">금융</font></a>
		    </c:when>
		    <c:otherwise>
		      <a class="nav-link" href="${cpath}/board/content?category=finance"><font size="4px" color="gray">금융</font></a>
		    </c:otherwise>
		  </c:choose>
		</li>
		
		<li id="jua" class="nav-item" style="margin : 0px 60px 0px 50px">
		  <c:choose>
		    <c:when test="${category == 'residence'}">
		      <a class="nav-link" href="${cpath}/board/content?category=residence"><font size="4px" color="green">주거</font></a>
		    </c:when>
		    <c:otherwise>
		      <a class="nav-link" href="${cpath}/board/content?category=residence"><font size="4px" color="gray">주거</font></a>
		    </c:otherwise>
		  </c:choose>
		</li>
		
		<li id="jua" class="nav-item" style="margin : 0px 60px 0px 50px">
		  <c:choose>
		    <c:when test="${category == 'culture'}">
		      <a class="nav-link" href="${cpath}/board/content?category=culture"><font size="4px" color="green">생활/문화</font></a>
		    </c:when>
		    <c:otherwise>
		      <a class="nav-link" href="${cpath}/board/content?category=culture"><font size="4px" color="gray">생활/문화</font></a>
		    </c:otherwise>
		  </c:choose>
		</li>
	</c:if>
      <c:if test="${!empty mvo}"> 
      <li id="jua" class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <font size="4px" color="black">〓</font>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <button class="dropdown-item" onclick="location.href='${cpath}/member/modify?userId=${mvo.userId}'">회원정보 수정</button>
          <button class="dropdown-item" onclick="location.href='${cpath}/board/wishList?userId=${mvo.userId}'">찜 모아보기</button>
          <button class="dropdown-item" onclick="location.href='${cpath}/member/withdrawal'">탈퇴</button>
        </div>
      </li>
      </c:if>
    </ul>
  </div>
</nav>
</div>
