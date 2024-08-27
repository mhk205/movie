<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ 추가</title>
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
    <br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/>
    <br/><br/>
    <form action="addFaq" method="post">
    
    <label for="category">카테고리:</label>
    <select name="category" id="category">
        <c:forEach var="category" items="${categories}">
            <option value="${category.id}">${category.name}</option>
        </c:forEach>
    </select>
    <br/><br/>

    <label for="question">질문:</label><br/>
    <textarea name="question" id="question" rows="4" cols="50"></textarea>
    <br/><br/>
    
    <label for="answer">답변:</label><br/>
    <textarea name="answer" id="answer" rows="4" cols="50"></textarea>
    <br/><br/>
    
    <input type="submit" value="추가">
    </div>
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