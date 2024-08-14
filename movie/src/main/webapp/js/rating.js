let selectedRating = 0; // 선택된 별점을 저장하는 변수
let reviewsLoaded = 8; // 초기 로드된 리뷰 수

function submitRating(rating) {
    selectedRating = rating;
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "submitRating", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            fetchAverageRating();
            highlightStars(selectedRating); // 별점 선택 후 하이라이트 유지
            document.getElementById('reviewText').style.display = 'block'; // 별점 선택 시 텍스트 영역 보이기
            document.getElementById('submitReviewButton').style.display = 'block'; // 리뷰 작성 버튼 보이기
        }
    };
    xhr.send("rating=" + rating);
}

function highlightStars(rating) {
    const stars = document.querySelectorAll('.star');
    stars.forEach((star, index) => {
        star.classList.toggle('selected', index < rating);
    });
}

function resetStars() {
    highlightStars(selectedRating); // 마우스가 별점 위를 떠나면 현재 선택된 별점만 하이라이트
}

function fetchAverageRating() {
    fetch('getAverageRating')
        .then(response => response.text())
        .then(data => {
            const [avgRating, totalRatings] = data.split(',');
            document.getElementById('averageRating').innerText = '평균 별점: ' + parseFloat(avgRating).toFixed(1);
            document.getElementById('ratingCount').innerText = '('+ totalRatings + '명)';
        });
}

function getSelectedRating() {
    return selectedRating;
}

document.addEventListener('DOMContentLoaded', function () {
    fetchAverageRating();
    fetchReviews(); // 페이지 로드 시 리뷰 가져오기
});

function submitReview() {
    const rating = getSelectedRating();
    const reviewText = document.getElementById('reviewText').value;

    if (rating === 0) {
        alert('별점을 선택해 주세요.');
        return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("POST", "submitReview", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            fetchAverageRating();
            fetchReviews();
            document.getElementById('reviewText').value = '';
            selectedRating = 0;
            resetStars(); // 리뷰 제출 후 별점 초기화
            document.getElementById('reviewText').style.display = 'none'; // 리뷰 작성 후 텍스트영역 숨기기
            document.getElementById('submitReviewButton').style.display = 'none'; // 리뷰 작성 후 버튼 숨기기
        }
    };
    xhr.send("rating=" + rating + "&review=" + encodeURIComponent(reviewText));
}

// 리뷰 가져오기 함수
function fetchReviews() {
    fetch('/movie/getReviews')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            const reviewsDiv = document.getElementById('reviews');
            reviewsDiv.innerHTML = ''; // 기존 리뷰 삭제

            data.forEach((review, index) => {
                const reviewElement = document.createElement('div');
                reviewElement.classList.add('review');
                if (index >= reviewsLoaded) {
                    reviewElement.classList.add('hidden'); // 숨김 클래스 추가
                }

                const idDiv = document.createElement('div');
                idDiv.classList.add('id');
                idDiv.textContent = '닉네임: ' + review.review_id; // 리뷰 ID 표시

                const ratingDiv = document.createElement('div');
                ratingDiv.classList.add('rating');
                ratingDiv.textContent = '★'.repeat(review.rating);

                const textDiv = document.createElement('div');
                textDiv.classList.add('text');
                textDiv.textContent = review.review_text.replace(/"/g, '\\"');

                const dateDiv = document.createElement('div');
                dateDiv.classList.add('date');
                dateDiv.textContent = new Date(review.created_at).toLocaleString();

                const likeContainer = document.createElement('div');
                likeContainer.classList.add('like-container');

                const likeButton = document.createElement('span');
                likeButton.classList.add('like-button');
                likeButton.innerHTML = '👍'; // 따봉 이모지

                const likeCount = document.createElement('span');
                likeCount.classList.add('like-count');
                likeCount.textContent = '0'; // 좋아요 수는 기본적으로 0으로 설정

                likeContainer.appendChild(likeButton);
                likeContainer.appendChild(likeCount);

                reviewElement.appendChild(idDiv); // ID 추가
                reviewElement.appendChild(ratingDiv);
                reviewElement.appendChild(textDiv);
                reviewElement.appendChild(dateDiv);
                reviewElement.appendChild(likeContainer);

                reviewsDiv.appendChild(reviewElement);

                // 좋아요 상태와 좋아요 수를 확인
                Promise.all([
                    checkLikeStatus(review.review_id),
                    fetchLikeCount(review.review_id)
                ])
                .then(([liked, count]) => {
                    updateLikeUI(review.review_id, liked, count);
                })
                .catch(error => {
                    console.error('Error fetching like status or count:', error);
                });

                // 리뷰 클릭 이벤트 리스너 추가 (리뷰 클릭 시 review.jsp로 이동)
                reviewElement.addEventListener('click', () => {
                    window.location.href = '/review.jsp'; // review.jsp로 이동
                });

                // 좋아요 버튼 클릭 이벤트 핸들러
                likeButton.addEventListener('click', (event) => {
                    event.stopPropagation(); // 클릭 이벤트가 부모 요소로 전파되지 않도록 함
                    handleLikeButtonClick(review.review_id);
                });
            });

            // '더 보기' 버튼 표시 여부 결정
            const showMoreButton = document.getElementById('showMoreButton');
            if (data.length > reviewsLoaded) {
                showMoreButton.style.display = 'block'; // '더 보기' 버튼 표시
            } else {
                showMoreButton.style.display = 'none'; // 모든 리뷰를 표시한 경우 '더 보기' 버튼 숨기기
            }
        })
        .catch(error => {
            console.error('Error fetching reviews:', error);
            const reviewsDiv = document.getElementById('reviews');
            reviewsDiv.innerHTML = '<div>리뷰를 가져오는 중에 오류가 발생했습니다.</div>';
        });
}


// 좋아요 추가
function addLike(reviewId, userId) {
    return fetch('/movie/addLike', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            reviewId: reviewId,
            userId: userId
        })
    });
}

// 좋아요 제거
function removeLike(reviewId, userId) {
    return fetch('/movie/removeLike', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            reviewId: reviewId,
            userId: userId
        })
    });
}

// 좋아요 상태 확인
function checkLikeStatus(reviewId) {
    const userId = 1; // 예시 사용자 ID, 실제 사용자 ID로 변경해야 함
    return fetch(`/movie/checkLike?reviewId=${reviewId}&userId=${userId}`)
        .then(response => response.json())
        .then(data => data.liked);
}

// 좋아요 수 가져오기
function fetchLikeCount(reviewId) {
    return fetch(`/movie/getLikeCount?reviewId=${reviewId}`)
        .then(response => response.json())
        .then(data => data.count);
}

// 페이지 로드 시 리뷰 가져오기
document.addEventListener('DOMContentLoaded', fetchReviews);

// 리뷰 더 보기 함수
function showMoreReviews() {
    reviewsLoaded += 8; // 더 보기 클릭 시 8개 리뷰를 추가로 로드
    fetchReviews(); // 리뷰를 다시 가져와서 더 보기 버튼 상태를 업데이트
}

// 별점 클릭 이벤트 리스너 추가
document.querySelectorAll('.star').forEach((star, index) => {
    star.addEventListener('click', () => submitRating(index + 1));
    star.addEventListener('mouseover', () => highlightStars(index + 1));
    star.addEventListener('mouseout', resetStars);
});

// 더 보기 버튼 클릭 이벤트 리스너 추가
const showMoreButton = document.querySelector('.show-more');
if (showMoreButton) {
    showMoreButton.addEventListener('click', showMoreReviews);
}
