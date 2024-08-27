<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
    <title>자주 묻는 질문</title> 
    <link rel="stylesheet" href="../css/reset.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/variable/woff2/SUIT-Variable.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
<body>
 <body>
	<header>
        <h1><a href="index.jsp"><img src="../images/logo.png" alt=""></a></h1>
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
    <h1>자주 묻는 질문</h1>
    
    <!-- 검색 폼 추가 -->
    <form action="searchFaq" method="get">
        <input type="text" name="query" placeholder="검색어를 입력하세요">
        <input type="submit" value="검색">
    </form>
    
     <a href="addFaq">FAQ 추가</a> <!-- 추가된 링크 -->
     
    <h2>카테고리</h2>
    <ul>
        <c:forEach var="category" items="${categories}">
            <li><a href="faq?category=${category.id}">${category.name}</a></li>
        </c:forEach>
    </ul>
    
	<h2>검색 결과</h2>
	<c:if test="${not empty query}">
	    <p>검색어: "${query}"에 대한 결과</p>
	</c:if>

    <h2>질문 목록</h2>
    <c:if test="${not empty faqs}">
        <ul>
            <c:forEach var="faq" items="${faqs}">
                <li>
                    <strong>${faq.question}</strong><br/>
                    ${faq.answer}
                </li>
            </c:forEach>
        </ul>
    </c:if>
    <c:if test="${empty faqs}">
    <p>검색 결과가 없습니다.</p>
</c:if>
</div>
    </main>
   <aside>
        <ul>
            <li><a href="#">고객<br>센터</a></li>
            <li><a href="#">공지<br>사항</a></li>
        </ul>
    </aside>
        <footer>
           <img src="../images/logo.png" alt="">
    </footer>
</body>
</html>
