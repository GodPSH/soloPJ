<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/slide.css"
	rel="stylesheet">
</head>
<section>
	
  

  <div class="slider">  

    <ul class="js__slider__images slider__images">
      <li class="slider__images-item"><img class="slider__images-image" src="<%=request.getContextPath()%>/img/team.png" /></li>
      <li class="slider__images-item"><img class="slider__images-image" src="<%=request.getContextPath()%>/img/head.png" /></li>
     
    </ul>

    <div class="sliders">
      <span class="slider__control js__slider__control--prev slider__control--prev">Prev</span>
      
      <ol class="js__slider__pagers slider__pagers"></ol>
      
      <span class="slider__control js__slider__control--next slider__control--next">Next</span>
    </div>
  </div>
  
 


</section>

</html>