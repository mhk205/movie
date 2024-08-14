<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="notice.NoticeBean"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" />
<%
	  request.setCharacterEncoding("UTF-8");

	  int num = Integer.parseInt(request.getParameter("num"));
	  
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 - MPEDIA</title>
 	<link href="../css/boardRead.css" rel="stylesheet" type="text/css">  
</head>
<body>
    <header>
        <img src="../images/mpedia_logo.png" alt="MPEDIA">
        <nav>
        </nav>
    </header>
    <div class="container">
        <div class="post-title">
        <%-- <%=subject%> --%>
        </div>
        <%-- <%= request.getAttribute("subject") %>  --%>
        <div class="post-meta">
            <%-- 작성자: <%= request.getAttribute("name") %> | 작성일: <%= request.getAttribute("date") %> --%>
            작성자: 
            <%-- <%=name%> --%> 
            | 
            작성일: 
            <%-- <%=regdate%> --%>
             
        </div>
        <div class="post-content"><%= request.getAttribute("content") %></div>
    <br><br>
	<div class="form-group">
                <label for="file">첨부 파일</label>
                <input type="file" name="filename">
    </div>
    <br>
    <div class="btnbox" >                                                <!-- onClick="history.go(-1)" --> 
	    <input class="btn" type="button" value="목록" onclick="javascript:location.href='noticeList.jsp'">
    	<input class="btn" type="submit" value="수정" onclick="location.href='noticeUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>'">
	    <input class="btn" type="submit" value="삭제" onclick="location.href='noticeDelete.jsp?nowPage=<%=nowPage%>&num=<%=num%>'">    
    </div>

     
</body>
<script type="text/javascript">
		function list(){
		    document.listFrm.submit();
		 } 
		
		function down(filename){
			 document.downFrm.filename.value=filename;
			 document.downFrm.submit();
		}
</script>
</html>

