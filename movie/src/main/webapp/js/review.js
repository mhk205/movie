// 리뷰를 가져오는 함수
function fetchReviews() {
    fetch('/movie/getReviews')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log('Fetched reviews:', data); // 데이터 로그 추가
            const reviewsDiv = document.getElementById('reviews');
            reviewsDiv.innerHTML = ''; // 기존 리뷰 삭제

            data.forEach(review => {
                const reviewElement = document.createElement('div');
                reviewElement.classList.add('review');
                reviewElement.dataset.reviewId = review.review_id; // review_id를 데이터 속성으로 저장

                const ratingDiv = document.createElement('div');
                ratingDiv.classList.add('rating');
                ratingDiv.textContent = '★'.repeat(review.rating);

                const textDiv = document.createElement('div');
                textDiv.classList.add('text');
                textDiv.textContent = review.review_text;

                const dateDiv = document.createElement('div');
                dateDiv.classList.add('date');
                dateDiv.textContent = new Date(review.created_at).toLocaleString();

                const userIdDiv = document.createElement('div');
                userIdDiv.classList.add('user-id');
                userIdDiv.textContent = 'Review ID: ' + review.review_id;

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

                reviewElement.appendChild(ratingDiv);
                reviewElement.appendChild(textDiv);
                reviewElement.appendChild(dateDiv);
                reviewElement.appendChild(userIdDiv);
                reviewElement.appendChild(likeContainer);

                reviewsDiv.appendChild(reviewElement);

                // 좋아요 상태와 좋아요 수를 확인
                checkLikeStatus(review.review_id)
                    .then(liked => {
                        if (liked) {
                            likeButton.classList.add('liked');
                        } else {
                            likeButton.classList.remove('liked');
                        }
                        return fetchLikeCount(review.review_id);
                    })
                    .then(count => {
                        likeCount.textContent = count;
                    })
                    .catch(error => {
                        console.error('Error fetching like status or count:', error);
                    });

                // 좋아요 버튼 클릭 이벤트 핸들러
                likeButton.addEventListener('click', () => {
                    handleLikeButtonClick(review.review_id);
                });

                // 댓글 폼 생성
                const commentsDiv = document.createElement('div');
                commentsDiv.id = `comments_${review.review_id}`; // review_id를 사용하여 댓글 컨테이너의 ID 설정
                const commentForm = createCommentForm(review.review_id);

                reviewElement.appendChild(commentsDiv);
                reviewElement.appendChild(commentForm);

                // 리뷰 클릭 시 댓글 폼 표시
                reviewElement.addEventListener('click', () => {
                    toggleCommentForm(review.review_id);
                });

                fetchComments(review.review_id);
            });
        })
        .catch(error => {
            console.error('Error fetching reviews:', error);
        });
}

// 좋아요 버튼 클릭 핸들러
function handleLikeButtonClick(reviewId) {
    const userId = 1; // 예시 사용자 ID, 실제 사용자 ID로 변경해야 함

    checkLikeStatus(reviewId)
        .then(liked => {
            if (liked) {
                // 좋아요가 이미 되어 있는 경우, 좋아요 취소
                return removeLike(reviewId, userId);
            } else {
                // 좋아요가 되어 있지 않은 경우, 좋아요 추가
                return addLike(reviewId, userId);
            }
        })
        .then(() => {
            // 좋아요 상태와 좋아요 수 업데이트
            checkLikeStatus(reviewId)
                .then(liked => {
                    const likeButton = document.querySelector(`.review[data-review-id="${reviewId}"] .like-button`);
                    const likeCount = document.querySelector(`.review[data-review-id="${reviewId}"] .like-count`);

                    if (likeButton && likeCount) {
                        if (liked) {
                            likeButton.classList.add('liked');
                        } else {
                            likeButton.classList.remove('liked');
                        }

                        fetchLikeCount(reviewId)
                            .then(count => {
                                likeCount.textContent = count;
                            })
                            .catch(error => console.error('Error fetching like count:', error));
                    }
                })
                .catch(error => console.error('Error checking like status:', error));
        })
        .catch(error => {
            console.error('Error handling like button click:', error);
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

// 댓글 폼 생성
function createCommentForm(reviewId) {
    const form = document.createElement('div');
    form.classList.add('comment-form');

    const textarea = document.createElement('textarea');
    textarea.placeholder = '댓글을 입력하세요...';

    const button = document.createElement('button');
    button.textContent = '댓글 등록';

    button.addEventListener('click', () => {
        const commentText = textarea.value;
        if (commentText.trim() !== '') {
            submitComment(reviewId, commentText)
                .then(() => {
                    fetchComments(reviewId);
                    textarea.value = ''; // 댓글 등록 후 텍스트 영역 초기화
                })
                .catch(error => {
                    console.error('Error submitting comment:', error);
                });
        }
    });

    form.appendChild(textarea);
    form.appendChild(button);
    return form;
}

// 댓글 제출
function submitComment(reviewId, commentText) {
    return fetch('/submitComment', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            reviewId: reviewId,
            commentText: commentText
        })
    });
}

// 댓글 가져오기
function fetchComments(reviewId) {
    fetch(`/getComments?reviewId=${reviewId}`)
        .then(response => response.json())
        .then(data => {
            const commentsDiv = document.getElementById(`comments_${reviewId}`);
            commentsDiv.innerHTML = ''; // 기존 댓글 삭제

            data.forEach(comment => {
                const commentElement = document.createElement('div');
                commentElement.classList.add('comment');
                commentElement.dataset.commentId = comment.comment_id;

                const commentText = document.createElement('div');
                commentText.classList.add('comment-text');
                commentText.textContent = comment.comment_text;

                const likeContainer = document.createElement('div');
                likeContainer.classList.add('like-container');

                const likeButton = document.createElement('span');
                likeButton.classList.add('like-button');
                likeButton.innerHTML = '👍'; // 따봉 이모지
                likeButton.id = `comment_like_${comment.comment_id}`; // ID 설정

                const likeCount = document.createElement('span');
                likeCount.classList.add('like-count');
                likeCount.textContent = '0'; // 기본 좋아요 수는 0
                likeCount.id = `comment_like_count_${comment.comment_id}`; // ID 설정

                likeContainer.appendChild(likeButton);
                likeContainer.appendChild(likeCount);

                commentElement.appendChild(commentText);
                commentElement.appendChild(likeContainer);

                commentsDiv.appendChild(commentElement);

                // 좋아요 버튼 클릭 이벤트 핸들러
                likeButton.addEventListener('click', () => {
                    handleCommentLike(comment.comment_id);
                });

                // 좋아요 상태와 좋아요 수 업데이트
                checkCommentLikeStatus(comment.comment_id)
                    .then(({ liked, likeCount }) => {
                        updateCommentLikeButton(comment.comment_id, liked, likeCount);
                    })
                    .catch(error => console.error('Error checking comment like status:', error));
            });
        })
        .catch(error => {
            console.error('Error fetching comments:', error);
        });
}


// 댓글 좋아요 버튼 상태를 업데이트하는 함수
function updateCommentLikeButton(commentId, liked, likeCount) {
    const likeButton = document.getElementById(`comment_like_${commentId}`);
    const likeCountSpan = document.getElementById(`comment_like_count_${commentId}`);
    
    if (likeButton) {
        if (liked) {
            likeButton.style.color = 'pink'; // 핑크색으로 변경
        } else {
            likeButton.style.color = ''; // 원래 색으로 변경
        }
    }

    if (likeCountSpan) {
        likeCountSpan.textContent = likeCount;
    }
}

// 댓글 좋아요 클릭 이벤트 처리
function handleCommentLike(commentId) {
    fetch('/movie/likeComment', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ commentId: commentId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            updateCommentLikeButton(commentId, data.liked, data.likeCount);
        } else {
            console.error('Error liking comment:', data.error);
        }
    })
    .catch(error => console.error('Error liking comment:', error));
}
// 댓글 좋아요 상태와 수를 가져오기
function checkCommentLikeStatus(commentId) {
    const userId = 1; // 예시 사용자 ID, 실제 사용자 ID로 변경해야 함
    return fetch(`/movie/checkCommentLike?commentId=${commentId}&userId=${userId}`)
        .then(response => response.json())
        .then(data => ({
            liked: data.liked,
            likeCount: data.likeCount
        }));
}

// 댓글 좋아요 제거
function removeCommentLike(commentId, userId) {
    return fetch('/movie/removeCommentLike', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            commentId: commentId,
            userId: userId
        })
    });
}

// 댓글 좋아요 상태 확인
function checkCommentLikeStatus(commentId) {
    const userId = 1; // 예시 사용자 ID, 실제 사용자 ID로 변경해야 함
    return fetch(`/movie/checkCommentLike?commentId=${commentId}&userId=${userId}`)
        .then(response => response.json())
        .then(data => data.liked);
}

// 댓글 좋아요 수 가져오기
function fetchCommentLikeCount(commentId) {
    return fetch(`/movie/getCommentLikeCount?commentId=${commentId}`)
        .then(response => response.json())
        .then(data => data.count);
}

// 댓글 폼 표시/숨김
function toggleCommentForm(reviewId) {
    const form = document.querySelector(`.review[data-review-id="${reviewId}"] .comment-form`);
    if (form) {
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }
}

// 페이지 로드 시 리뷰 가져오기
document.addEventListener('DOMContentLoaded', fetchReviews);
