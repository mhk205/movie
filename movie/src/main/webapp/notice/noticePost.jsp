<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>mpedia</title> 
    <link href="../css/boardPost.css" rel="stylesheet" type="text/css"> 
</head>
<body>
    <header>
        <img src="../images/mpedia_logo.png" alt="MPEDIA">
        <nav>
        </nav>
    </header>
    <div class="container">
        <h2>공지 작성</h2>
        <form name="postFrm" method="post" action="noticePost" enctype="multipart/form-data">
        <!-- <form action="submitPost.jsp" method="post"> -->
            <div class="form-group">
                <label for="subject">제목</label>
                <input type="text" id="subject" name="subject" required>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" maxlength="2000" required></textarea>
            </div>
            <div class="form-group">
                <label for="file">파일 업로드</label>
                <input type="file" name="filename">
            </div>
            <div>
                <input class="btn" type="submit" value="등록하기">
                <input class="btn" type="button" value="목록으로" onclick="javascript:location.href='noticeList.jsp'">
            </div>
       	<!-- 게시물 작성자의 ip주소 를 getRemoteAddr() 메서드를 이용하여 가져와서 입력한다. -->
        <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
        </form>
    </div>
</body>
</html>
