<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<c:set var="cpath" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
    .input-form {
      max-width: 850px;
      max-height: 2000px;

      margin-top: 80px;
      padding: 32px;

      background: powderblue;;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 20px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
     *{
font-family: 'Jua', sans-serif;
   }
 
 
  </style>
</head>

<body>

<jsp:include page="../layout/header.jsp"/>

<br>
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원정보 수정</h4>
        <br><br>
        <form class="validation-form" novalidate action="${cpath}/member/modify?userId=${userId}" method="post">
         <div class="row">
		  <div class="col-md-6 mb-3">	
          <div class="mb-3">
            <label for="name">이름</label>
            <input type="text" class="form-control" name="userName" style="font-size:14px" value="${vo.userName}" required>
            <div class="invalid-feedback">
              이름을 입력해주세요.
            </div>
          </div>
          </div>
  		  <div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="age">나이</label>
            <input type="text" class="form-control" name="age" style="width:350px; font-size:14px" value="${vo.age}" required>
             <div class="invalid-feedback">
              나이를 입력해주세요.
            </div>
          </div>
		  </div>
		 </div>
          <div class="row">
          <div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="phone">*전화번호(숫자만 입력)</label>
            <input type="text" class="form-control" name="phoneNo" pattern="[0-9]{3}[0-9]{4}[0-9]{4}" style="font-size:14px"  value="${vo.phoneNo}" required>
            <div class="invalid-feedback">
              전화번호를 입력해주세요.
            </div>
          </div>
          </div>
           <div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="phone">*이메일</label>
            <input type="email" class="form-control" name="email" style="font-size:14px"  value="${vo.email}"required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>
          </div>
          </div>
        <div class="row">
          <div class="col-md-6 mb-3">
		  <div class="mb-3">
            <label for="address">주소(시,도)</label>
            <select name="adressSi" class="custom-select d-block w-100" required>
            	<option>서울특별시</option>
            	<option>부산광역시</option>
            	<option>대구광역시</option>
            	<option>인천광역시</option>
            	<option>광주광역시</option>
            	<option>대전광역시</option>
            	<option>울산광역시</option>
            	<option>경기도</option>
            	<option>강원도</option>
            	<option>충청북도</option>
            	<option>충청남도</option>
            	<option>전라북도</option>
            	<option>전라남도</option>
            	<option>경상북도</option>
            	<option>경상남도</option>
            	<option>제주특별자치도</option>
            	<option>세종특별자치시</option>
            </select>
          </div>
		 </div>
		 <div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="adressGu">주소(구)<span class="text-muted"></span></label>
            <input type="text" class="form-control" name="adressGu" value="입력안함">
          </div>
         </div>
         </div>
         <div class="row">
         <div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="gender">성별</label>
            <select name="gender" class="custom-select d-block w-100">
            	<option selected>선택안함</option>
            	<option>여</option>
            	<option>남</option>
            </select>
          </div>
		</div>
		<div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="incomeQuintile">소득분위</label>
            <select name="incomeQuintile" class="custom-select d-block w-100">
           		<option selected>선택안함</option>
            	<option>1</option>
            	<option>2</option>
            	<option>3</option>
            	<option>4</option>
            	<option>5</option>
            	<option>6</option>
            	<option>7</option>
            	<option>8</option>
            	<option>9</option>
            	<option>10</option>
            </select>
          </div>
		</div>
		</div>
          <div class="row">
          <div class="col-md-6 mb-3">
		  <div class="mb-3">
            <label for="accrRqisCn">학력</label>
            <select name="accrRqisCn" class="custom-select d-block w-100">
           		<option selected>선택안함</option>
            	<option>고등학교 졸업</option>
            	<option>대학교 2/3년제 재학</option>
            	<option>대학교 4년제 재학</option>
            	<option>대학교 2/3년제 졸업</option>
            	<option>대학교 4년제 졸업</option>
            </select>
          </div>
		 </div>
		 <div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="major">전공<span class="text-muted"></span></label>
            <input type="text" class="form-control" name="major" value="입력안함">
          </div>
         </div>
         </div>
         <div class="row">
          <div class="col-md-6 mb-3">
		  <div class="mb-3">
            <label for="splzRlmRqisCn">특화분야</label>
            <input type="text" class="form-control" name="splzRlmRqisCn" value="입력안함">
          </div>
		 </div>
		 <div class="col-md-6 mb-3">
          <div class="mb-3">
            <label for="employmentStatus">취업상태<span class="text-muted"></span></label>
             <select name="employmentStatus" class="custom-select d-block w-100" >
             	<option selected>선택안함</option>
            	<option>유</option>
            	<option>무</option>
            </select>
          </div>
         </div>
         </div>
          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div><br>
          <div class="mb-4"></div>
           <button class="btn btn-outline-success btn-lg btn-block" type="submit" style="height:50px;">수정 완료</button>
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2021 YD</p>
    </footer>
  </div>
  <script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  </script>

<jsp:include page="../layout/footer.jsp"/>
   
</body>
</html>