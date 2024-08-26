<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="movie.MovieBean" %>
<%@ page import="movie.MovieSearchDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>M-PEDIA</title>
    <link rel="stylesheet" href="./css/reset.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/variable/woff2/SUIT-Variable.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<header>
        <h1><a href="index.jsp"><img src="./images/logo.png" alt=""></a></h1>
        <nav>
            <ul>
               <li><a href="genre.jsp?genrequery=로맨스">로맨스</a>
                </li>
                <li><a href="genre.jsp?genrequery=액션">액션</a>
                </li>
                <li><a href="genre.jsp?genrequery=코미디">코미디</a>
                </li>
                <li><a href="genre.jsp?genrequery=드라마">드라마</a></li>
                <li><a href="genre.jsp?genrequery=etc">etc</a></li>
            </ul>
        </nav>
        <div class="btn">
            <form method="get" action="searchResult.jsp">
                <input type="text" name="query" class="query" placeholder="영화, 배우, 감독을 검색하세요.">
                <input type="submit" class="search" value="검색">
                <button class="login_btn" >로그인</button>
                <button class="join_btn" >회원가입</button>

            </form>
        </div>
    </header>
     <%
     String query = request.getParameter("query");
     String genrequery = request.getParameter("genrequery"); 
     %>
     <main class="resultMain">
    	<div class="adv">
        	<img src="./images/<%=genrequery%>.png" alt="">
        </div>
        
            <%

    if (genrequery != null && !genrequery.trim().isEmpty()) {
        MovieSearchDAO dao = new MovieSearchDAO();
        Vector<MovieBean> results = dao.genreMovies(genrequery);

        if (results.isEmpty()) {
%>
            <h2><img src="./images/genre.png" alt=""> 결과가 없습니다.</h2>
<%
        } else {
%>
            <h2><img src="./images/genre.png" alt=""><%= genrequery %> 영화</h2>
            <div class="movies">
<%
            for (Enumeration<MovieBean> e = results.elements(); e.hasMoreElements();) {
                MovieBean genre = e.nextElement();
%>
                
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/poster/<%=genre.getMov_name()%>.jfif" alt="" ></a>
                <p><%= genre.getMov_name() %></p>
             </article>
                
<%
            }
%>
            </div>
<%
        }
    }
%>
    </main>
    <aside>
        <ul>
            <li><a href="#">고객<br>센터</a></li>
            <li><a href="#">공지<br>사항</a></li>
        </ul>
    </aside>
        <footer>
           <img src="./images/logo.png" alt="">
    </footer>
</body>
</html>