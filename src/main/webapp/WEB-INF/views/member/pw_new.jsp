<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<style type="text/css">

.input-form {
      max-width: 500px;
      max-height: 2000px;

      margin-top: 30px;
      padding: 32px;

      background: powderblue;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 20px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
   
</style>
<title>새비밀번호 설정</title>
</head>
<body>

	<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <br>
        <div align="center">
         <h2 class="mb-3" align="center" id="jejuFont">새비밀번호</h2>
		<form action="pw_new" method="POST" class="content">
    <div class="textbox">
        <input id="userPassword" name="userPassword" class="form-control" type="password" placeholder="새 비밀번호">
        <div class="invalid-feedback">
            비밀번호를 입력해주세요.
        </div> 
    </div>
    <br>
    <div class="textbox">
        <input id="pw2" name="pw2" class="form-control" type="password" placeholder="새 비밀번호 재입력">
        <div class="invalid-feedback">
            비밀번호를 입력해주세요.
        </div> 
    </div>
    
    <span id="same"></span>
    <br><br>
    <input type="submit" id="check" value="비밀번호 변경" style="padding: 10px 20px; background-color: green; color: white; border: none; cursor: pointer;">
    <input type="hidden" name="email" value=${email}>

    <script>
        var userPasswordInput = document.getElementById("userPassword");
        var pw2Input = document.getElementById("pw2");
        var sameSpan = document.getElementById("same");

        function checkPasswords() {
            if (userPasswordInput.value !== pw2Input.value) {
                sameSpan.textContent = "비밀번호가 일치하지 않습니다.";
            } else {
                sameSpan.textContent = "";
            }
        }

        function handleSubmit(event) {
            event.preventDefault(); // 폼 기본 동작 막기
            checkPasswords(); // 비밀번호 일치 확인

            if (userPasswordInput.value !== pw2Input.value) {
                alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
            } else {
                // 비밀번호 일치 시 폼 전송
                event.target.parentElement.submit();
            }
        }

        document.getElementById("check").addEventListener("click", handleSubmit);
    </script>
</form>
	</div>
	</div>
	</div>
</div>
	
</body>
</html>