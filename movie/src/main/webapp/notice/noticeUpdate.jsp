<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeBean"%>
<% 
	  //read.jsp 페이지에서 이동한 num, nowPage 파라미터를 받아 각 각 변수에 저장
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  
	  //session에 저장된 bean객체를 이용해서 게시물 정보를 각 각 변수에 저장 
	  NoticeBean bean = (NoticeBean)session.getAttribute("bean");
	  String subject = bean.getSubject();
	  String name = bean.getName(); 
	  String content = bean.getContent(); 
%>

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
        <h2>공지 수정</h2>
        <form name="updateFrm" action="noticeUpdate"   method="post">   <!--noticeUpdate  boardUpdate -->
            <div class="form-group">
                <label for="subject">제목</label>
               <!-- <input type="text" id="subject" name="subject" required>  -->
               <input name="subject" size="50" value="<%=subject%>" required maxlength="50" >  
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <!-- <textarea id="content" name="content" maxlength="2000" required></textarea> -->
                <textarea name="content" rows="10" cols="50" maxlength="2000" required ><%=content%></textarea>
            </div>
            <div class="form-group">
                <label for="file">파일 업로드</label>
                <input type="file" name="filename">
            </div>
            <div>
                <input class="btn" type="submit" value="수정완료" onClick="check()">
                <input class="btn" type="button" value="목록으로" onclick="javascript:location.href='noticeList.jsp'">
            </div>
        </form>
        <input type="hidden" name="nowPage" value="<%=nowPage %>">
        <input type='hidden' name="num" value="<%=num%>"> 
    </div>
</body>
<script>
 //패스워드 가 입력 되었는지 확인하는 check() 함수
		function check() {
		    
		   document.updateFrm.submit();
		}
	</script>
</html>
