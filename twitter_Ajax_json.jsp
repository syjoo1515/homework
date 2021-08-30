<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>Twitter</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<button onclick="twitter()">twitter</button>


	<div class="container">
		<h2>TWITTER</h2>
		<p>값이 없을 경우 null 출력</p>
		<table class="table table-bordered">
		<thead id=thead>
		</thead>
			<tbody id="tbody">

			</tbody>
		</table>
	</div>

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
	
		//twitters is not defined at XMLHttpRequest.viewtwitter---?
		
	   
		
	    function viewtwitter(){  //printInfo 함수로 뺀 이유:안빼면 httpRequest.readyState 가 1,2,3일때도 twitters에 데이터가 들어감(전역변수로 쓰면 undifiened로 들어가고 지역변수로 쓰면 동일한 4일때와 동일한 데이터 들어가는듯)-왜인지 모르겠다
	    	   if(httpRequest.readyState==4&&httpRequest.status==200){
	    	       xmlDom=httpRequest.responseXML;
	    	      //console.log(xmlDom);
	    	      printInfo();
	    	   }
	    	}
		
	    var twitters=[];
		function printInfo() {
				entry = xmlDom.getElementsByTagName("status"); 
				for (var i = 0; i < entry.length; i++) {
					var entryChilds = entry[i].childNodes; 
					twitter = {}; //XML 데이터를 JSON형태로 변환한 다음 var twitter에 넣을예정
					for (var j = 0; j < entryChilds.length; j++) {
						if (entryChilds[j].nodeType == 1) { //nodeType 1: 요소 노드. 공백 제거해서 출력하기 위해 쓴다. (텍스트/공백은 3)
							var currentName=entryChilds[j].nodeName;
							if (entryChilds[j].firstChild == null){//node값이 공백일 경우 null값 넣음-null이면 nodeValue를 사용할 수 없어서 if문으로 처리해줘야함
								twitter[currentName]="null";
							}
							else if (entryChilds[j].firstChild != null) {
								if(currentName!='user'&&currentName!='entities'){
									twitter[currentName]=entryChilds[j].firstChild.nodeValue;
								}
 								if(currentName=='user'){ //자식노드가 user인 경우 user의 자식노드들을 출력하기 위해
									var userChilds= entryChilds[j].childNodes; //위와 마찬가지 과정 한번 더 거친다
									for(var x=0;x<userChilds.length;x++){
										if(userChilds[x].nodeType == 1){ 
										if (userChilds[x].firstChild == null){
											twitter[userChilds[x].nodeName]="null";
										}
										else if (userChilds[x].firstChild != null) {
											twitter[userChilds[x].nodeName]=userChilds[x].firstChild.nodeValue;
										//console.log(userChilds[x].nodeName+' '+userChilds[x].firstChild.nodeValue);
										}
										}
									}//for 3
								} //user인 경우
							}
						}
					}//for 2
					twitters.push(twitter);
				}//for 1
		//	console.log(twitters);
			drawTwitters();
		}
		
		function drawTwitters(){
			var thtemp="";
			var tbtemp = "<tr>";
		 //	console.log(twitters[0]); 
 			  var keyValue=Object.keys(twitters[0]);
			for(var i=0;i<keyValue.length;i++){ 
				thtemp+="<th>"+keyValue[i]+"</th>";
			} 
		     for(var i in twitters){
		         for(var j in twitters[i]){
		           // console.log(j+' '+twitters[i][j]);
		           tbtemp+="<td>"+twitters[i][j]+"</td>";
		 		}
		         tbtemp+="</tr><tr>"
		      }
		     tbtemp+="</tr>";
		     console.log(document.getElementById("thead"));
		     document.getElementById("thead").innerHTML = thtemp;
		     console.log(document.getElementById("tbody"));
		     document.getElementById("tbody").innerHTML = tbtemp;  
		}

	</script>
</body>
</html>