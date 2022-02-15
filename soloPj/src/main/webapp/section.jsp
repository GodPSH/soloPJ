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
		<input type="radio" name="slide" id="slide1" checked> <input
			type="radio" name="slide" id="slide2"> <input type="radio"
			name="slide" id="slide3"> <input type="radio" name="slide"
			id="slide4">
		<ul id="imgholder" class="imgs">
			<li><img src="<%=request.getContextPath()%>/img/team.jpg"></li>
			<li><img src="<%=request.getContextPath()%>/img/team2.jpg"></li>
			<li><img src="<%=request.getContextPath()%>/img/team3.jpg"></li>
			<li><img src="<%=request.getContextPath()%>/img/team4.jpg"></li>

		</ul>
		<div class="bullets">
			<label for="slide1">&nbsp;</label> <label for="slide2">&nbsp;</label>
			<label for="slide3">&nbsp;</label> <label for="slide4">&nbsp;</label>
		</div>
		<div class="team">
			<p>
				팀소개글입니다.팀소개글입니다.
				팀소개글입니다.팀소개글입니다.
				팀소개글입니다.팀소개글입니다.
				팀소개글입니다.팀소개글입니다.
				팀소개글입니다.팀소개글입니다.
				팀소개글입니다.팀소개글입니다.
				팀소개글입니다.팀소개글입니다.
				팀소개글입니다.팀소개글입니다.
			</p>
		</div>
	</div>




</section>

</html>