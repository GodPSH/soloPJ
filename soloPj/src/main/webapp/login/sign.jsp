<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/sign.css"
	rel="stylesheet">
	
	<script type="text/javascript">
	function checkFn(type){
		if(type == 'id'){
			var checkId = /^[a-z]+[a-z0-9]{4,15}/g;
			var value = document.frm.id.value;
			var span = document.getElementsByClassName("id")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "*필수";
				span.style.color = "red";
				span.style.display = "inline";
			}else if(!checkId.test(value)){
				span.textContent = "*형식오류";
				span.style.color = "red";
				span.style.display = "inline";
			}else{
				span.textContent = "";
				span.style.display = "none";
			}
		}else if(type == 'pass'){
			var checkId = /^.*(?=^.{4,15}$)(?=.*\d)(?=.*[a-zA-Z]).*$/;
			var value = document.frm.password.value;
			var span = document.getElementsByClassName("password")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "*필수";
				span.style.color = "red";
				span.style.display = "inline";
			}else if(!checkId.test(value)){
				span.textContent = "*형식오류";
				span.style.color = "red";
				span.style.display = "inline";
			}else{
				span.textContent = "";
				span.style.display = "none";
			}
		}else if(type == 'passre'){
			var value = document.frm.password.value;
			var value2 = document.frm.passwordre.value;
			var span = document.getElementsByClassName("passwordre")[0].getElementsByTagName("span")[0];
			if(value2 == ""){
				span.textContent = "*필수";
				span.style.color = "red";
				span.style.display = "inline";
			}else if(value != value2){
				span.textContent = "*비밀번호 불일치";
				span.style.color = "red";
				span.style.display = "inline";
			}else{
				span.textContent = "";
				span.style.display = "none";
			}
		}else if(type == 'name'){
			var checkName = /^[가-힣]/g;
			var value = document.frm.name.value;
			var span = document.getElementsByClassName("name")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "*필수";
				span.style.color = "red";
				span.style.display = "inline";
			}else if(!checkName.test(value)){
				span.textContent = "*형식오류";
				span.style.color = "red";
				span.style.display = "inline";
			}else{
				span.textContent = "";
				span.style.display = "none";
			}
		}else if(type == 'phone2'){
			var checkPhone2 = /^[0-9]{3,4}/g;
			var value = document.frm.phone2.value;
			var span = document.getElementsByClassName("phone")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "*필수";
				span.style.color = "red";
				span.style.display = "inline";
			}else if(!checkPhone2.test(value)){
				span.textContent = "*형식오류";
				span.style.color = "red";
				span.style.display = "inline";
			}else{
				span.textContent = "";
				span.style.display = "none";
			}
		}else if(type == 'phone3'){
			var checkPhone2 = /^[0-9]{4}/g;
			var value = document.frm.phone3.value;
			var span = document.getElementsByClassName("phone")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "*필수";
				span.style.color = "red";
				span.style.display = "inline";
			}else if(!checkPhone2.test(value)){
				span.textContent = "*형식오류";
				span.style.color = "red";
				span.style.display = "inline";
			}else{
				span.textContent = "";
				span.style.display = "none";
			}
		}else if(type =='birth'){
			var checkBirth = /([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/g;
			var value = document.frm.birth.value;
			var span = document.getElementsByClassName("birth")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "*필수";
				span.style.color = "red";
				span.style.display = "inline";
			}else if(!checkBirth.test(value)){
				span.textContent = "*형식오류";
				span.style.color = "red";
				span.style.display = "inline";
			}else{
				span.textContent = "";
				span.style.display = "none";
			}
		}
	}

	
	</script>
</head>
<body>
	<section>
		<form name="frm" method="post" action="signOk.jsp">
			<div class="header">회원가입</div>
			<div class="rows h">
				<label for="id">아이디<span class="red">*</span></label>
			</div>
			<div class="rows id">
				<input type="text" class="id impor" name="membid" id="id"
					placeholder="아이디를 입력하세요." onblur="checkFn('id')"> <span
					class="check"></span>
			</div>
			<div class="rows h">
				<label for="password">비밀번호<span class="red">*</span></label>
			</div>

			<div class="rows password">
				<input type="password" class="impor" name="membpw" id="password"
					placeholder="비밀번호를 입력하세요." onblur="checkFn('pass')"> <span
					class="check"></span>
			</div>
			<div class="rows h">
					<label for="name">이름<span class="red">*</span></label>
				</div>
				<div class="rows name">
					<input type="text" class="impor" name="membname" id="name" placeholder="이름을 입력하세요." onblur="checkFn('name')">
					<span class="check"></span>
				</div>
			<div class="rows h">
				<label for="addr">주소<span class="red">*</span></label>
				<div class="rows addr">
				<select name="membaddr" id="addr">
						<option value="서울">서울</option>
						<option value="경기도">경기도</option>
						<option value="강원도">강원도</option>
						<option value="대전">대전</option>
						<option value="전주">전주</option>
						<option value="부산">부산</option>
						<option value="광주">광주</option>
						<option value="울산">울산</option>
						<option value="대구">대구</option>
						<option value="군산">군산</option>
						<option value="김제">김제</option>
						<option value="세종">세종</option>
						<option value="포항">포항</option>
						<option value="무주">무주</option>
						<option value="완주">완주</option>		
					</select>
				</div>
			</div>	
			<div class="rows h">
					<label for="birth">생년월일<span class="red">*</span></label>
				</div>
				<div class="rows birth">
					<input type="text" class="birth" name="membage" id="birth1" placeholder="예시)220207" maxlength="10" onblur="checkFn('birth')"><span class="check"></span>					
				</div>
			<div class="rows h">
					<label for="phone1">연락처<span class="red">*</span></label>
				</div>
				<div class="rows phone">
					<select name="membph" id="phone1">
						<option value="010">010</option>
						<option value="010">011</option>
						<option value="010">016</option>
					</select>&nbsp;
					<input type="text" class="impor" name="membph2" id="phone2" placeholder="연락처2" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="checkFn('phone2')">&nbsp;
					<input type="text" class="impor" name="membph3" id="phone3" placeholder="연락처3" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="checkFn('phone3')">
					<span class="check"></span>
				</div>
				<div class="sign-btn-wrap">
				<input class="sign-btn" type="submit" value="확인">
				<input class="sign-btn" type="button" value="취소" onclick="location.href='../main.jsp'">
				</div>
		</form>
		
	</section>
</body>
</html>