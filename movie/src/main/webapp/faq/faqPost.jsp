<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>mpedia</title> 
    <link href="../css/boardPost.css" rel="stylesheet" type="text/css">
    <style>
    .btn{
    	background-color: #555555;
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
        <h2>문의 작성</h2>
        <form action="submitPost.jsp" method="post">
            <div class="form-group">
                <label for="subject">제목 : </label>
                <input type="text" id="subject" name="subject" required>
            </div>
            <div class="form-group">
                <label for="content">문의 내용 : </label>
                <textarea id="content" name="content" maxlength="2000" required> ========어떤 내용이 궁금하신가요?======= </textarea>
            </div>
            <div class="form-group">
                <label for="file">파일 업로드</label>
                <input type="file" name="filename">
            </div>
            <div>
                <input class="btn" type="submit" value="등록하기">
                <input class="btn" type="button" value="나의 문의목록" placeholder="문의내용을 적어주세요." onclick="javascript:location.href='list.jsp'">
            </div>
        </form>
        <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
    </div>
</body>
</html>
