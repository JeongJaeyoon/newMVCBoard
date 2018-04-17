<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>상세정보</h3>
<hr>
idx : ${member.idx}<br>
아이디 : ${member.member_id}<br>
이름 : ${member.member_name}<br>
비밀번호 : ${member.password}<br>
날짜 : <fmt:formatDate value="${member.regdate }" pattern="yyyy-mm-dd hh:mm" /> <br>
사진 : <img src="${pageContext.request.contextPath }/uploadfile/memberphoto/${member.photo}">
<br><br>
<a href="memberList">회원리스트</a>
</body>
</html>