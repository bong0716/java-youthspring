<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
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
<title>비밀번호 찾기</title>
</head>
<body>

 <c:if test="${not empty error}">
   	<script>
        alert("인증번호가 일치하지 않습니다.");
    </script>   
    </c:if>
    
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <br>
        <div align="center">
        <h2 class="mb-3" align="center" id="jejuFont">비밀번호 찾기</h2>
		<form class="validation-form" novalidate action="${cpath}/member/pw_auth" method="post">
			<div class="textbox">
		  		<input id="text" name=name required type="text" class="form-control" placeholder="이름" style="font-size:14px; height:40px"  />
		   		<div class="invalid-feedback">
                이름을 입력해주세요.
                </div>
		 	</div>
		 	<br>
			<div class="textbox">
		  		<input id="email" name=email required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" type="email" class="form-control" placeholder="이메일" style="font-size:14px; height:40px"  />
		  		<div class="invalid-feedback">
                이메일을 입력해주세요.
                </div>
                <br>
		   	<input type="submit" id="check" value="비밀번호찾기" style="padding: 10px 20px; background-color: green; color: white; border: none; cursor: pointer;">
		</form>
		</div>
	</div>
	</div>
</div>
</body>
</html>