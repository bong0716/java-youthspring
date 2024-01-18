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
    font-size: 25px;
    color: #f44336;
    background-color: transparent;
    border: none;
    cursor: pointer;
    font-weight: bold;
}

.heart-btn:hover {
  transform: scale(1.2);
}

#cardUp {
  transition: transform 0.3s ease;
}

#cardUp:hover {
  transform: translateY(-10px);
}

.no-wrap {
    white-space: nowrap;
    display: inline;
  }
  
   </style>
   
</head>
<body>

 <jsp:include page="../layout/header.jsp"/>

<br><br>
<div style="display: flex; align-items: center; justify-content: center;">
  <h1 class="no-wrap" style="color: green;">내가 찜한</h1>
  <h2 class="no-wrap">정책</h2> 
</div>
<br>

  <div class="card" style="background-color:powderblue; ">
    <br>
   <div class="row">
    <c:forEach items="${apiData}" var="apiData" varStatus="loop">
        <div class="col-lg-3" style="margin-bottom: 20px;">
            <div id="cardUp" class="card" style="min-height: 350px; max-height: 350px; border-radius: 30px;">
                <div class="card-body" style="padding: 0px;">
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
                        
                        </h3>
                        <div class="heart-container">
	                     	 <form action="${cpath}/board/deleteWishList" method="post" >
	                     	 	  <input type="hidden" name="userId" value="${userId}">
	                     	 	  <input type="hidden" name="bizId" value="${apiData.bizId}">
						        <button type="submit" class="heart-btn">♥</button>
						     </form>
						</div>
						<br><br>
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