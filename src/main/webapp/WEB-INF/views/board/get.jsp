<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="org.xml.sax.*" %>
<%@ page import="java.util.List,java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>청년복지 맞춤 제공</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 
   <meta name="view-transition" content="same-origin"/>
  <style>
     .td1 {background-color: rgb(234,234, 234);}
      
     .btnGo{
	    border-radius:2em;
	    background-color: teal;
	    color: #ffffff;
	    padding: .5em 1.5em;
	}
	.btnGo:hover {
	  background-color: rgba(0, 128, 128, 0.7);
	  color: #ffffff;
	  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  }
  

	a{
		  color: black; /* 링크 색상 변경 */
		  text-decoration: none; /* 밑줄 제거 */
	}
	
	a:hover {text-decoration: none;}
	
	.modal-dialog {max-width: 800px;}
	
	.modal-content {width: 100%;}
	    
	*{font-family: 'Jua', sans-serif;}

table {
      border-collapse: collapse;
      width: 100%;
      font-size: 20px;
    }

    th, td {
      padding: 8px;
      text-align: left;
      border-bottom: 1px solid #ddd;
       font-size: 16px;
    }

    th {
      background-color: AliceBlue;
      text-align: center;
      white-space: nowrap;
      border-right: 1px solid #ddd;
    }

    td {
      border-right: 1px solid #ddd;
    }
    
    .heart-container {
    float: right;
}

.heart-btn {
    font-size: 20px;
    color: #f44336;
    background-color: transparent;
    border: none;
    cursor: pointer;
    font-family: Arial, sans-serif;
    font-weight: bold;
}

.heart-btn:hover {
  transform: scale(1.2);
}

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
      top: 0;
      left: 0;
      right: 0;
      z-index: 999;
      background-color: white;
      
    }
    
.fixed-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 999;
  background-color: white;
}

#cardUp {
  transition: transform 0.3s ease;
}

#cardUp:hover {
  transform: translateY(-10px);
}

 #jejuFont{
font-family: 'Jeju Gothic', sans-serif;
   }
   
   .no-wrap {
    white-space: nowrap;
    display: inline;
  }
  
 .pagination .page-item.active .page-link {
    background-color: green;
    border-color: green;
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
<body>
<div style="padding:30px 60px 0px 100px; align: center">  
<nav class="navbar navbar-expand-sm" id="navFix">
<div class="container">
<a href="${cpath}/board/list"><img src="../resources/images/logo.jpg" alt="logo" style="width:300px; padding:30px 200px 0px 0px"></a>
  <div class="vertical-center">
  	<form class="form-inline" action="${cpath}/board/get?query=${userMessage}" style="padding: 130px 0px 0px 40px">
    	<input id="userMessage" name="userMessage" class="form-control mr-sm-2" type="text" placeholder="어떤 정책 찾으세요?" style="width:500px; height:50px; border-color:green; border-radius: 20px; background-color: rgb(228,247,239)">
    	<input type="hidden" name="category" value="${category}">
    	<button style="display: block" class="btn btn-outline-success">
		  <i class="fas fa-search"></i>
		</button>
  	</form>
  </div>
   <c:if test="${empty mvo}"> 
  <div style="text-align: right;">
	  <button id="jua" class="btn btn-outline-dark" onclick="location.href='${cpath}/member/loginProcess'">로그인</button> 
	  <button id="jua" class="btn btn-outline-dark" onclick="location.href='${cpath}/member/memberRegister'">회원가입</button>
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

<div style="padding:120px 100px 0px 100px">  
<nav nav class="navbar navbar-expand-sm bg-light navbar-light">
  <a id="jua" class="navbar-brand" href="${cpath}/board/list" style="margin : 0px 0px 0px 100px">청년복지</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
     <!--  <li class="nav-item active">
        <a class="nav-link" href="#">정책정보 <span class="sr-only">(current)</span></a>
      </li> -->
	   <c:if test="${empty category}">
      <li id="jua" class="nav-item" style="margin : 0px 50px 0px 100px">
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

<br>
<div style="align-items: center; justify-content: center; text-align: center; height: 150px;">
		  <h1 style="color: green; font-weight: bold;">분야별 새소식</h1>
		   <c:choose>
		    <c:when test="${category == 'finance'}">
		      <h2 class="no-wrap">금융</h2>
		      <img src="../resources/images/dollar2.png" width="50" height="50">
		    </c:when>
		    <c:when test="${category == 'employment'}">
		     <h2 class="no-wrap">취업/창업</h2>
		     <img src="../resources/images/empl.png" width="50" height="50">
		    </c:when>
		    <c:when test="${category == 'residence'}">
		    <h2 class="no-wrap">주거</h2>
		    <img src="../resources/images/house.png" width="50" height="50">
		    </c:when>
		    <c:when test="${category == 'culture'}">
		    <h2  class="no-wrap">생활/문화</h2>
		    <img src="../resources/images/life.png" width="50" height="50">
		    </c:when>
		    </c:choose>
		 
	</div>  
  <div class="card" style="background-color:powderblue;">
    <br>
    
     <c:if test="${apiDataList eq '[]'}">
		       <br>
		        <div style="display: flex; justify-content: center; align-items: center; height: 100px;">
			    <h3>결과정보 없음..</h3>
			  </div>
		       	<br>
	 </c:if>
       <div class="row">
    <c:forEach items="${apiDataList}" var="apiData" varStatus="loop">
        <div class="col-lg-3" style="margin-bottom: 20px;">
            <div class="card" style="min-height: 350px; max-height: 350px; border-radius: 30px;">
                <div id="cardUp" class="card-body" style="padding: 0px;">
                    <div style="background-color: AliceBlue; padding: 20px; border-radius: 30px;">
                        <h3 style="font-weight: bold; display: inline;">
                      
                        <a class="card-title text-success" data-toggle="modal" data-target="#contentModal" 
                        data-index="${loop.index}" data-polyBizSjnm="${apiData.polyBizSjnm}" 
                        data-polyItcnCn="${apiData.polyItcnCn}" data-rqutPrdCn="${apiData.rqutPrdCn}" 
                        data-ageInfo="${apiData.ageInfo}" data-sporCn="${apiData.sporCn}"
                        data-rqutProcCn="${apiData.rqutProcCn}" data-jdgnPresCn="${apiData.jdgnPresCn}"
                        data-empmSttsCn="${apiData.empmSttsCn}" data-accrRqisCn="${apiData.accrRqisCn}"
                        data-majrRqisCn="${apiData.majrRqisCn}" data-splzRlmRqisCn="${apiData.splzRlmRqisCn}" >
                        
                        ${apiData.polyBizSjnm}
                        </a>
                        <br><br>
                        </h3>
                         <c:if test="${!empty mvo}"> 
	                     	 <div class="heart-container">
	                     	 <form action="${cpath}/board/insertWishlist" method="post" >
	                     	 	  <input type="hidden" name="userId" value="${mvo.userId}">
	                     	 	  <input type="hidden" name="bizId" value="${apiData.bizId}">
	                     	 	  <input type="hidden" name="rqutPrdCn" value="${apiData.rqutPrdCn}">
	                     	 	  <input type="hidden" name="polyBizSjnm" value="${apiData.polyBizSjnm}">
								  <input type="hidden" name="polyItcnCn" value="${apiData.polyItcnCn}">
								  <input type="hidden" name="rqutUrla" value="${apiData.rqutUrla}">
								  <input type="hidden" name="cnsgNmor" value="${apiData. cnsgNmor}">
								  <input type="hidden" name="ageInfo" value="${apiData.ageInfo}">
								  <input type="hidden" name="sporCn" value="${apiData.sporCn}">
								  <input type="hidden" name="rqutProcCn" value="${apiData.rqutProcCn}">
								  <input type="hidden" name="jdgnPresCn" value="${apiData.jdgnPresCn}">
								  <input type="hidden" name="empmSttsCn" value="${apiData.empmSttsCn}">
								  <input type="hidden" name="accrRqisCn" value="${apiData.accrRqisCn}">
								  <input type="hidden" name="majrRqisCn" value="${apiData.majrRqisCn}">
								  <input type="hidden" name="splzRlmRqisCn" value="${apiData.splzRlmRqisCn}">
						        <button type="submit" class="heart-btn">♡</button>
						     </form>
						     
							     <script>
								  document.getElementById('heartBtn').addEventListener('click', function() {
								    this.style.color = 'red';
								  });
								</script>
						    </div>
					    </c:if>
						<c:set var="cardText" value="${fn:length(apiData.polyItcnCn) > 75 ? fn:substring(apiData.polyItcnCn, 0, 75) : apiData.polyItcnCn}"/>

						<c:if test="${fn:length(apiData.polyItcnCn) > 75}">
						    <p class="card-text">${cardText}...</p>
						</c:if>
						<c:if test="${fn:length(apiData.polyItcnCn) <= 75}">
						    <p class="card-text">${cardText}</p>
						</c:if>
                       <p class="card-text"><span style="color: rgb(244,162,9)">신청기간:</span> ${apiData.rqutPrdCn}</p>
                    </div><br>
                    <div align="right" style="padding: 0px 10px 0px 0px">
                     <c:set var="urlText" value="${fn:length(apiData.cnsgNmor) > 23 ? fn:substring(apiData.cnsgNmor, 0, 23) : apiData.cnsgNmor}"/>
                       <c:if test="${fn:length(apiData.cnsgNmor) > 23}">
						    <a href="${apiData.rqutUrla}" class="btnGo" style="text-decoration:none">${urlText}...</a>
					   </c:if>
					   <c:if test="${fn:length(apiData.cnsgNmor) <= 23}">
						   <a href="${apiData.rqutUrla}" class="btnGo" style="text-decoration:none">${urlText}</a>
					   </c:if>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${loop.count % 4 == 0}">
       </div><div class="row">
        </c:if>
    </c:forEach>
</div>
<br>
<c:if test="${apiDataList ne '[]'}">
<c:if test="${pageNum ne 1}">
<div style="display: flex; justify-content: center;">
  <ul class="pagination">
    <c:forEach var="pageNum" begin="1" end="8">
      <c:if test="${perPageNum eq pageNum}">
        <li class="page-item active">
          <a class="page-link" href="${cpath}/board/content?category=${category}&perPageNum=${pageNum}" style="color: white;">${pageNum}</a>
        </li>
      </c:if>
      <c:if test="${perPageNum ne pageNum}">
        <li class="page-item">
          <a class="page-link" href="${cpath}/board/content?category=${category}&perPageNum=${pageNum}" style="color: gray;">${pageNum}</a>
        </li>
      </c:if>
    </c:forEach>
  </ul>
</div>
</c:if>
</c:if>
				
  
<div class="modal fade" id="contentModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: AliceBlue">
        <h5 class="modal-title">사업개요</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="max-height: 700px; overflow-y: scroll;">
        <p id="modalText"></p>
        <h4 id="polyBizSjnm" align="center"></h4><br>
           
          <table>
			  <tr>
			    <th>정책소개</th>
			    <td id="polyitcncn"></td>
			  </tr>
			  <tr>
			    <th>지원내용</th>
			    <td id="sporCn"></td>
			  </tr>
			   <tr>
			    <th>신청기간</th>
			    <td id="rqutPrdCn"></td>
			  </tr>
			  <tr>
			    <th>신청연령</th>
			    <td id="ageInfo"></td>
			  </tr>
			  <tr>
			    <th>취업상태</th>
			    <td id="empmSttsCn"></td>
			  </tr>
			  <tr>
			    <th>학력</th>
			    <td id="accrRqisCn"></td>
			  </tr>
			  <tr>
			    <th>전공</th>
			    <td id="majrRqisCn"></td>
			  </tr>
			  <tr>
			    <th>신청절차</th>
			    <td id="rqutProcCn"></td>
			  </tr>
			  <tr>
			    <th>특화분야</th>
			    <td id="splzRlmRqisCn"></td>
			  </tr>
			  <tr>
			    <th>심사발표</th>
			    <td id="jdgnPresCn"></td>
			  </tr>
			</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

 
 $(function() {
	 <!-- 모달 창에서 데이터를 추출하여 사용하는 JavaScript 코드 -->
$('#contentModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // 모달을 호출한 버튼 객체
  var polyItcnCn = button.data('polyitcncn') // 정책소개
  var polyBizSjnm = button.data('polybizsjnm') //정책명
  var rqutPrdCn = button.data('rqutprdcn') //신청기간
  var ageInfo = button.data('ageinfo') // 신청연령
  var sporCn = button.data('sporcn') //지원내용
  var rqutProcCn = button.data('rqutproccn') //신청절차
  var jdgnPresCn = button.data('jdgnprescn') //심사발표
  var empmSttsCn = button.data('empmsttscn') //취업상태
  var accrRqisCn = button.data('accrrqiscn') //학력
  var majrRqisCn = button.data('majrrqiscn') //전공
  var splzRlmRqisCn = button.data('splzrlmrqiscn') //특화분야
      
  var modal = $(this)
  modal.find('.modal-body #polyBizSjnm').text(polyBizSjnm) // 모달 창 타이틀에 polyBizSjnm 값 대입
  modal.find('.modal-body #polyitcncn').text(polyItcnCn)
  modal.find('.modal-body #rqutPrdCn').text(rqutPrdCn) //신청기간
  modal.find('.modal-body #ageInfo').text(ageInfo) //신청연령 
  modal.find('.modal-body #sporCn').text(sporCn) //지원내용
  modal.find('.modal-body #rqutProcCn').text(rqutProcCn) //신청절차
  modal.find('.modal-body #jdgnPresCn').text(jdgnPresCn) //심사발표
  modal.find('.modal-body #empmSttsCn').text(empmSttsCn) //취업상태
  modal.find('.modal-body #accrRqisCn').text(accrRqisCn) //학력
  modal.find('.modal-body #majrRqisCn').text(majrRqisCn) //전공
  modal.find('.modal-body #splzRlmRqisCn').text(splzRlmRqisCn) //특화분야
  

  
  //modal.find('.modal-footer #rqutUrla').attr("href", rqutUrla).text(cnsgNmor) // 모달 창 푸터에 rqutUrla 값 대입
});
 });
	
</script>
		
   <jsp:include page="../layout/footer.jsp"/>
   
</div>
</body>
</html>