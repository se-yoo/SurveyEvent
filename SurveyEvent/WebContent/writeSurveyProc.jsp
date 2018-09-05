<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<script>
	var cnt=1;
	var aCnt=new Array();
	for(i=0;i<50;i++){
		aCnt[i-1]=1;
	}
	
	function addAn(qNum){
		if(aCnt[qNum-1]>=10){
			alert("최대 10개의 답변만 가능합니다");
		}
		else{
			var a=document.createElement("div");
			aCnt[qNum-1]+=1;
			a.innerHTML="ㄴ답변 >> <input type='text' name='a"+qNum+"_"+aCnt[qNum-1]+"' size='48' required style='margin-bottom:10px'>";
			
			var q = document.getElementById("q"+qNum);
			q.appendChild(a);
			document.getElementById("q"+qNum+"ACnt").value=aCnt[qNum-1];
			console.log(document.getElementById("q"+qNum+"ACnt").value);
		}
	}
	
	function addQu(){
		if(cnt>=20){
			alert("최대 20개의 질문만 가능합니다");
		}else{
			cnt++;
			var q=document.createElement("div");
			q.id="q"+cnt;
			q.className="qq";
			q.innerHTML="<input type='hidden' id='q"+cnt+"ACnt' name='q"+cnt+"ACnt' value='1'>질문"+cnt+" >> <input type='text' name='q"+cnt+"' size='36' required style='margin:10px'> <input type='button' value='답변 추가'"+
			"onclick='addAn("+cnt+")''><br><div>ㄴ답변 >> <input type='text' name='a"+cnt+"_1' size='48' required style='margin-bottom:10px'></div>";
			
			var qBox = document.getElementById("questionBox");
			qBox.appendChild(q);
			document.getElementById("qCnt").value=cnt;
			console.log(document.getElementById("qCnt").value);
		}
	}
</script>
<style>
#form{
	padding-top:50px;
	padding-bottom:50px;
	display:inline-block;
	width:70%;
	background-color:white;
}
#formBox{
	display:inline-block;
	width:35%;
	text-align:left;
	color:#2b1850;
}
#addQuestion,#upload{
	width:90%;
	margin:10px 0px;
}
input{
	font-family:Nanum;
}
input[type='button'],input[type='submit']{
	background-color:#cec0ea;
	color:white;
	border:0px;
	padding:5px;
}
.qq{
	margin:10px auto 0px auto;
}
</style>
</head>
<body>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar c1 = Calendar.getInstance();
c1.add(Calendar.DATE,1);
String strToday = sdf.format(c1.getTime());
%>
	<div id="form"><form action="upload.jsp" method="post" enctype="multipart/form-data">
	<div id="formBox">설문제목 >> <input type="text" name="title" placeholder="ex) 설문사이트 관련 실태조사" size="46" required><br><br>
	상품이름 >> <input type="text" name="prize" placeholder="ex) OO편의점 3천원권, 무선마우스" size="46" required><br><br>
	연락처 >> <input type="text" name="connect" placeholder="ex) 010-0000-0000" size="48" required><br>
	<span style="font-size:0.6em">(상품 문의나 상품을 전달해 주기 위한 연락처를 입력해주세요 당첨자에게만 보여줍니다)</span><br><br>
	상품 사진 및 기프티콘 >> <input type="file" name="img" required><br><br>
	마감날짜 >> <input type="date" name="eDate" min="<%=strToday %>" required><br><br>
	<hr width="90%" style="margin-left:0px;">
	<div style="font-size:0.8em; margin-bottom:25px; color:gray;">
		※ 현재 설문은 질문 최대 20개, 한 질문당 답변 최대 10개가 가능하며 현재는 직접<br>
		입력 받거나 중복 답변을 받을 수 있는 기능 없습니다. 빠른 시일 내에 기능을 추가하<br>
		도록하겠습니다. 또한 설문 결과만 가지고 설문을 삭제하는 경우가 있어서 수정,삭제<br>
		이 불가하니 신중하게 작성, 검토 부탁드립니다. 감사합니다
	</div>
	<div id="questionBox">
	<input type="hidden" id="qCnt" name="qCnt" value="1">
	<div id="q1" class="qq">
	<input type="hidden" id="q1ACnt" name="q1ACnt" value="1">
	질문1 >> <input type="text" name="q1" size="36" required style="margin:10px"> <input type="button" value="답변 추가" onclick="addAn(1)"><br>
	<div>ㄴ답변 >> <input type="text" name="a1_1" size="48" required style='margin-bottom:10px'></div>
	</div>
	</div><br>
	<input id="addQuestion" type="button" value="질문 추가" onclick="addQu()"><br>
	<input id="upload" type="submit" value="설문업로드"><br>
	</div>
	</form>
	</div><br><br>
</body>
</html>