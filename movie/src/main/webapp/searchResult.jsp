<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="movie.MovieBean" %>
<%@ page import="movie.MovieSearchDAO" %>
<%@ page import="java.io.*, java.net.*, org.json.*, java.util.Calendar, java.text.SimpleDateFormat" %>
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
    <main class="resultMain">
    	<div class="adv">
        	<img src="./images/adv.png" alt="">
        </div>

    
    
        <%    
    String query = request.getParameter("query");
    if (query != null && !query.trim().isEmpty()) {
        MovieSearchDAO dao = new MovieSearchDAO();
        Vector<MovieBean> results = dao.searchMovies(query);

        if (results.isEmpty()) {
%>
            <h2><img src="./images/search.png" alt=""><%= query %>"로 검색한 결과가 없습니다.</h2>
<%
        } else {
%>
            <h2><img src="./images/search.png" alt=""><%= query %>" (으)로 검색한 결과</h2>
            <div class="movies">
<%
            for (Enumeration<MovieBean> e = results.elements(); e.hasMoreElements();) {
                MovieBean movie = e.nextElement();
%>
                
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/poster/<%=movie.getMov_name()%>.jfif" alt="" ></a>
                <p><%= movie.getMov_name() %></p>
              
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