const sliderWrap = document.querySelector(".slider__wrap");
const sliderImg = document.querySelector(".slider__img");   //보여지는 영역
const sliderInner = document.querySelector(".slider__inner"); //움직이는 영역
const slider = sliderWrap.querySelectorAll(".slider");      //각각의 이미지

let currentIndex = 0; //현재 보이는 이미지
let sliderCount = slider.length; //이미지 총 갯수
let sliderWidth = sliderImg.offsetWidth; //이미지 가로 값 (offsetWidth : 가로 값 구하는 메서드)
let sliderClone = sliderInner.firstElementChild.cloneNode(true); // 제이쿼리는 클론만 적기 복사를 위해서는 true 꼭 적기 : 첫번째 자식 요소 복사하기(이미지)

sliderInner.appendChild(sliderClone);   //첫번째 이미지를 마지막에 넣어준다.

function sliderEffect(){
    currentIndex++;
    sliderInner.style.transition = "all 0.9s";

    sliderInner.style.transform = "translateX(-" + sliderWidth * currentIndex + "px)";


    //마지막 사진에 위치했을 때 : 효율성보단 간편한 코드 
     if(currentIndex == sliderCount){
        sliderInner.style.transition = "0s";
        sliderInner.style.transform = "translateX(0px)";
        currentIndex = 0; 
     }
}
setInterval(sliderEffect,2000);
