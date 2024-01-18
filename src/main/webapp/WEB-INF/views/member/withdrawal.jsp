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
  <c:if test= "${mvoId == 'fail'}">
    	<script>
			alert("해당 정보의 회원이 존재하지 않습니다. 다시 입력해주세요.");
			history.back()
		</script>
  </c:if>
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">탈퇴</h4>
        <br>
        <h6>탈퇴 시 모든 계정정보가 소실됩니다</h6><br>
        <div align="center" style="border : 1px solid gray; padding : 30px">
        <form class="validation-form" novalidate action="${cpath}/member/withdrawal" method="post">
            <div class="col-md-8 mb-6">
              <input type="text" class="form-control" placeholder="아이디를 입력해주세요." name="userId" style="font-size:14px; height:40px" required>
              <div class="invalid-feedback">
                아이디를 입력해주세요.
              </div>
            </div>
            </br>
            <div class="col-md-8 mb-6">
              <input type="password" class="form-control" placeholder="비밀번호를 입력해주세요." name="userPassword" style="font-size:14px; height:40px" required>
              <div class="invalid-feedback">
                비밀번호를 입력해주세요.
              </div>
			</div>
          <div class="mb-4"></div>
           <button class="btn btn-dark btn-lg btn-block" type="submit" style="height:40px; width:500px">탈퇴</button>
           <br>
        </form>
        <c:if test="${msg == false}">
        	<font style="color: gray">아이디나 비밀번호가 틀립니다. </font>
        </c:if>
        </div>
        </div>
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