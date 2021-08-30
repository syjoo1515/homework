<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<button onclick="twitter()">twitter</button>
	<script type="text/javascript">
		var httpRequest = null /*변수선언  */
		function getXmlHttpRequest() {
			if (window.ActiceXObject) { /*window:내장객체  */
				try {
					return new ActiveXObject("Msxm12.XMLHTTP");
				} catch (e) {

				}
			} else if (window.XMLHttpRequest) {
				return new XMLHttpRequest(); //생성자. XMLHttpRequest를 초기화함. XMLHttpRequest:모든 종류의 데이터를 받아올 수 있음
			}
		}//function getXmlHttpRequest    --->브라우저 파서를 객체로 받아오는 함수

		function twitter() {
			httpRequest = getXmlHttpRequest();
			httpRequest.onreadystatechange = viewtwitter;
			httpRequest.open('GET', 'twitter.xml', true);
			httpRequest.send(null);
		}
		//nodeValue:텍스트만 반환하고 null값 반환 못함
		//entryChilds[j].firstChild로 접근하는 이유: entryChilds[j].nodeValue를 하면 자기자신을 가리키기 때문에 null값 반환. node값이 텍스트이면 firstChild에 그 텍스트가 들어가는 것
		function viewtwitter() {
			var thtemp1 = "<tr>";
			var tbtemp1 = "<tr>";
			var thtemp2 = "<tr>";
			var tbtemp2 = "<tr>";
			if (httpRequest.readyState == 4 && httpRequest.status == 200) {
				var xmlData = httpRequest.responseXML;
				entry = xmlData.getElementsByTagName("status"); //각 status가 배열의 요소로 들어간 배열 entry 생성
				for (var i = 0; i < entry.length; i++) {
					var entryChilds = entry[i].childNodes; //childNodes: 자식노드를 노드리스트로 반환하기 때문에 entryChilds에 status의 자식노드들 들어감-근데 공백도 들어감
					var twitter = {}; //XML 데이터를 JSON형태로 변환한 다음 var twitter에 넣을예정
					
					for (var j = 0; j < entryChilds.length; j++) {
						if (entryChilds[j].nodeType == 1) { //nodeType 1: 요소 노드. 공백 제거해서 출력하기 위해 쓴다. (텍스트/공백은 3)
							if(i==0){
								thtemp1 += "<td>" + entryChilds[j].nodeName + "</td>";
							}
							if (entryChilds[j].firstChild == null){
								tbtemp1 += "<td>null</td>";
							}
							else if (entryChilds[j].firstChild != null) { //개힘들게 찾음-node값이 공백일 경우 제거
								//console.log(entryChilds[j].nodeName+' '+entryChilds[j].firstChild.nodeValue);
								//if (entryChilds[j].firstChild.nextSibling!=null) {} //자식노드의 자식노드가 있는지
								tbtemp1 += "<td>" + entryChilds[j].firstChild.nodeValue + "</td>";
 								if(entryChilds[j].nodeName=='user'){ //자식노드가 user인 경우 user의 자식노드들을 출력하기 위해
									var userChilds= entryChilds[j].childNodes;
									for(var x=0;x<userChilds.length;x++){
										if(userChilds[x].nodeType == 1){
										
										if(i==0 && j==19){
											console.log(userChilds[x].nodeName);
											thtemp2 += "<td>" + userChilds[x].nodeName + "</td>";
										}
										if (userChilds[x].firstChild == null){
											tbtemp2 += "<td>null</td>";
										}
										else if (userChilds[x].firstChild != null) {
											tbtemp2 += "<td>" + userChilds[x].firstChild.nodeValue + "</td>";
										//console.log(userChilds[x].nodeName+' '+userChilds[x].firstChild.nodeValue);
										}
										}
									}//for 3
									tbtemp2+="</tr><tr>"
								} //user인 경우
							}
						}
					}//for 2
					tbtemp1+="</tr><tr>"
				}//for 1
				thtemp1+="</tr>";
				document.getElementById("th1").innerHTML = thtemp1;
				tbtemp1+="</tr>";
				document.getElementById("tb1").innerHTML = tbtemp1;
				
				thtemp2+="</tr>";
				document.getElementById("th2").innerHTML = thtemp2;
				tbtemp2+="</tr>";
				document.getElementById("tb2").innerHTML = tbtemp2;
			}
		}
	</script>
	
	<div class="container">
		<h2>TWITTER</h2>
		<p>값이 없을 경우 null 출력</p>
		 <table class="table table-bordered">
			<thead id="th1">
			</thead>
			<tbody id="tb1">
			</tbody>
		</table>
		
		<h2>TWITTER-USER정보</h2>
		<p>값이 없을 경우 null 출력</p>
		<table class="table table-bordered">
			<thead id="th2">
			</thead>
			<tbody id="tb2">
			</tbody>
		</table>
	</div>
	
</body>
</html>