<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>mpedia</title> 
    <link href="../css/boardDelete.css" rel="stylesheet" type="text/css"> 
</head>
<body>
    <header>
        <img src="../images/mpedia_logo.png" alt="MPEDIA">
        <nav>
        </nav>
    </header>
    <div class="container">
        <h2>공지 삭제</h2>
        <p>삭제하시겠습니까?</p>
        <br>
        <form action="deletePost.jsp" method="post">
            <input class="btn" type="submit" value="삭제" onClick="check()">
            <input class="btn" type="button" value="취소" onclick="history.go(-1)">
        </form>
    </div>
<%-- 	<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
	<input type="hidden" name="num" value="<%=num%>"> --%>
</body>
</html>
