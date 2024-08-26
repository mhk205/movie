<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="movie.MovieBean" %>
<%@ page import="movie.MovieSearchDAO" %>
<%@ page import="java.io.*, java.net.*, org.json.*, java.util.Calendar, java.text.SimpleDateFormat" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>M-PEDIA</title>
    <link rel="stylesheet" href="./css/reset.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/variable/woff2/SUIT-Variable.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/style.css">
    
    <style>
   	 	.highRating > div > .ratingStar {
   	 		width:20px;
  		}
    </style>
    
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

    <main>
    
     <%
        // API 키와 URL 설정
        String apiKey = "32499c86bb320f4c9069f7d7e802a922"; // 여기에 API 키를 입력하세요.
        String apiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
        
        // Calendar 인스턴스를 생성하여 현재 날짜를 가져옵니다.
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        
        // 현재 날짜에서 하루를 빼서 어제 날짜를 구합니다.
        calendar.add(java.util.Calendar.DAY_OF_MONTH, -1);
        
        // SimpleDateFormat 인스턴스를 생성하여 날짜 형식을 설정합니다.
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        
        // 어제 날짜를 원하는 형식으로 포맷합니다.
        String yesterday = sdf.format(calendar.getTime());
        
        // API 호출 URL
        String urlString = apiUrl + "?key=" + apiKey + "&targetDt=" + yesterday;
        
        // HTTP 연결 및 응답 처리
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder apiResponse = new StringBuilder();
        
        while ((inputLine = in.readLine()) != null) {
            apiResponse.append(inputLine);
        }
        in.close();
        
        // JSON 데이터 파싱
        JSONObject jsonResponse = new JSONObject(apiResponse.toString());
        JSONArray boxOfficeList = jsonResponse.getJSONObject("boxOfficeResult").getJSONArray("dailyBoxOfficeList");
    %>
    


        <section id="sliderType03">
            <div class="slider__wrap">
                <div class="slider__img">
                    <div class="slider__inner">
            <%
                for (int i = 0; i < Math.min(5, boxOfficeList.length()); i++) {
                    JSONObject movie = boxOfficeList.getJSONObject(i);
                   // String rank = movie.getString("rank");
                    String movieName = movie.getString("movieNm");
                    String modifyMovieName = movieName.replaceAll("[^a-zA-Z0-9가-힣]", ""); //특수문자, 띄어쓰기 제거
                   
            %>  
                        <div class="slider" >
                            <img src="./images/rank/<%= modifyMovieName %>.jpg" alt="<%= modifyMovieName %>">
                            <div class="boxOffice"><%=movieName%></div>
                        </div>
                 
            <%
                }
            %>
                       
                    </div>
                </div>
            </div>
        </section>
            
        
        <h2><img src="./images/favorite.png" alt="">평점 높은 영화</h2>
        <div class="movies">
      <%
            List<MovieBean> moviesWithRatings = null;
            try {
                MovieSearchDAO movieDAO = new MovieSearchDAO();
                moviesWithRatings = movieDAO.getMoviesWithAverageRating();
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (moviesWithRatings != null) {
                int rank = 1;
                for (MovieBean movie : moviesWithRatings) {
                    String mov_name = movie.getMov_name();
                    double averageRating = movie.getRe_score();
                    String movieCd = movie.getMovieCd();
        %>
                    <article class="highRating">
                        <a href="#">
                            <p class="view">View More</p>
                            <img src="./images/poster/<%= mov_name %>.jfif" alt="">
                        </a>
                        <p><%= mov_name %></p>
                        <div>
                            <img class="ratingStar" src="./images/star.png">
                            <p class="rating"><%= averageRating %></p>
                            <input type="hidden" value="<%=movieCd %>">
                        </div>
                    </article>
        <%
                }
            }
        %>
         </div>

        <h2><img src="./images/thumbs.png" alt="">추천 영화</h2>
        <div class="movies">
        
        <%
                for (int i = 0; i < Math.min(10, boxOfficeList.length()); i++) {
                    JSONObject movie = boxOfficeList.getJSONObject(i);
                   // String rank = movie.getString("rank");
                   	String openDt = movie.getString("openDt");
                    String movieName = movie.getString("movieNm");
                    String movieCd = movie.getString("movieCd");
                    String modifyMovieName = movieName.replaceAll("[^a-zA-Z0-9가-힣]", ""); //특수문자, 띄어쓰기 제거
                   
            %>  
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/poster/<%= modifyMovieName %>.jfif" alt=""></a>
                <p><%=movieName %></p>
                <p>개봉일 : <%=openDt %></p>
                <input type="hidden" value="<%=movieCd %>">
            </article>
                 
            <%
                }
            %>
           
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



    <script src="./js/slider.js"></script>
</body>
</html>