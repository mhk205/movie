<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 - MPEDIA</title>
 	<link href="../css/boardRead.css" rel="stylesheet" type="text/css">
 	<style>
 		.answer {
 			background-color: #D3D3D3;
 		}
 	</style>  
</head>
<body>
    <header>
        <img src="../images/mpedia_logo.png" alt="MPEDIA">
        <nav>
        </nav>
    </header>
    <div class="container">
        <div class="post-title"><%= request.getAttribute("subject") %></div>
        <div class="post-meta">
            작성자: <%= request.getAttribute("name") %> | 작성일: <%= request.getAttribute("date") %>
        </div>
        <div class="post-content"><%= request.getAttribute("content") %></div>
    <br><br>
	<div class="form-group">
                <label for="file">첨부 파일</label>
                <input type="file" name="filename">
    </div>
    <br>
    <div class="btnbox" >
	    <input class="btn" type="button" value="뒤로" onClick="history.go(-1)">
    	<input class="btn" type="submit" value="수정" <%-- href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" --%> onClick="check()">
	    <input class="btn" type="submit" value="삭제" <%-- href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>" --%> onClick="check()">
	    <input class="btn, answer"  type="submit" value="답변"   onClick="check()">    
    </div>
    
     
</body>
</html>
