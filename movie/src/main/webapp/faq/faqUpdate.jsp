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
        <h2>내용 수정</h2>
        <form action="submitPost.jsp" method="post">
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
                <input class="btn" type="submit" value="수정완료" onClick="check()">
                <input class="btn" type="button" value="목록으로" onClick="history.go(-1)">
            </div>
        </form>
    <%--     <input type="hidden" name="nowPage" value="<%=nowPage %>">
        <input type='hidden' name="num" value="<%=num%>"> --%>
    </div>
</body>
</html>
