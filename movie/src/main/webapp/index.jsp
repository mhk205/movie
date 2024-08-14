<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>M-PEDIA</title>
    <link rel="stylesheet" href="./css/reset.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/variable/woff2/SUIT-Variable.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>
    <header>
        <h1><a href="index.html"><img src="./images/logo.png" alt=""></a></h1>
        <nav>
            <ul>
                <li><a href="#">로맨스</a>
                </li>
                <li><a href="#">액션</a>
                </li>
                <li><a href="#">코미디</a>
                </li>
                <li><a href="#">드라마</a></li>
                <li><a href="#">etc</a></li>
            </ul>
        </nav>
        <div class="btn">
            <form action="#">
                <input type="text" class="text" placeholder="영화 제목을 검색해주세요.">
                <input type="submit" class="search" value="검색">
                <button class="login_btn" src="#">로그인</button>
                <button class="join_btn" src="#">회원가입</button>
            </form>
        </div>
    </header>
    <main>
        <section id="sliderType03">
            <div class="slider__wrap">
                <div class="slider__img">
                    <div class="slider__inner">
                        <div class="slider">
                            <img src="./images/box1.jpg" alt="이미지1">
                        </div>
                        <div class="slider">
                            <img src="./images/box2.jpg" alt="이미지2">
                        </div>
                        <div class="slider">
                            <img src="./images/box3.jpg" alt="이미지3">
                        </div>
                        <div class="slider">
                            <img src="./images/box4.jpg" alt="이미지4">
                        </div>
                        <div class="slider">
                            <img src="./images/box5.jpg" alt="이미지5">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <h2><img src="./images/favorite.png" alt="">평점 많은 영화</h2>
        <div class="movies">
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt="">
                </a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
        </div>
        

        <h2><img src="./images/thumbs.png" alt="">추천 영화</h2>
        <div class="movies">
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
            <article>
                <a href="#"><p class="view">View More</p><img src="./images/pilot.jpg" alt=""></a>
                <p>파일럿</p>
                <p>대한민국, 2024</p>
            </article>
        </div>
        
    </main>
    <aside>
        <ul>
            <li><a href="#"><img src="./images/ico_cookie.svg" alt="">고객센터</a></li>
            <li><a href="#"><img src="./images/ico_edit.svg" alt="">공지사항</a></li>
        </ul>
    </aside>
    <footer>
           <img src="./images/logo.png" alt="">
    </footer>



    <script src="./js/slider.js"></script>
</body>
</html>