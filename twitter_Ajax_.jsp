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
		var httpRequest = null /*��������  */
		function getXmlHttpRequest() {
			if (window.ActiceXObject) { /*window:���尴ü  */
				try {
					return new ActiveXObject("Msxm12.XMLHTTP");
				} catch (e) {

				}
			} else if (window.XMLHttpRequest) {
				return new XMLHttpRequest(); //������. XMLHttpRequest�� �ʱ�ȭ��. XMLHttpRequest:��� ������ �����͸� �޾ƿ� �� ����
			}
		}//function getXmlHttpRequest    --->������ �ļ��� ��ü�� �޾ƿ��� �Լ�

		function twitter() {
			httpRequest = getXmlHttpRequest();
			httpRequest.onreadystatechange = viewtwitter;
			httpRequest.open('GET', 'twitter.xml', true);
			httpRequest.send(null);
		}
		//nodeValue:�ؽ�Ʈ�� ��ȯ�ϰ� null�� ��ȯ ����
		//entryChilds[j].firstChild�� �����ϴ� ����: entryChilds[j].nodeValue�� �ϸ� �ڱ��ڽ��� ����Ű�� ������ null�� ��ȯ. node���� �ؽ�Ʈ�̸� firstChild�� �� �ؽ�Ʈ�� ���� ��
		function viewtwitter() {
			var thtemp1 = "<tr>";
			var tbtemp1 = "<tr>";
			var thtemp2 = "<tr>";
			var tbtemp2 = "<tr>";
			if (httpRequest.readyState == 4 && httpRequest.status == 200) {
				var xmlData = httpRequest.responseXML;
				entry = xmlData.getElementsByTagName("status"); //�� status�� �迭�� ��ҷ� �� �迭 entry ����
				for (var i = 0; i < entry.length; i++) {
					var entryChilds = entry[i].childNodes; //childNodes: �ڽĳ�带 ��帮��Ʈ�� ��ȯ�ϱ� ������ entryChilds�� status�� �ڽĳ��� ��-�ٵ� ���鵵 ��
					var twitter = {}; //XML �����͸� JSON���·� ��ȯ�� ���� var twitter�� ��������
					
					for (var j = 0; j < entryChilds.length; j++) {
						if (entryChilds[j].nodeType == 1) { //nodeType 1: ��� ���. ���� �����ؼ� ����ϱ� ���� ����. (�ؽ�Ʈ/������ 3)
							if(i==0){
								thtemp1 += "<td>" + entryChilds[j].nodeName + "</td>";
							}
							if (entryChilds[j].firstChild == null){
								tbtemp1 += "<td>null</td>";
							}
							else if (entryChilds[j].firstChild != null) { //������� ã��-node���� ������ ��� ����
								//console.log(entryChilds[j].nodeName+' '+entryChilds[j].firstChild.nodeValue);
								//if (entryChilds[j].firstChild.nextSibling!=null) {} //�ڽĳ���� �ڽĳ�尡 �ִ���
								tbtemp1 += "<td>" + entryChilds[j].firstChild.nodeValue + "</td>";
 								if(entryChilds[j].nodeName=='user'){ //�ڽĳ�尡 user�� ��� user�� �ڽĳ����� ����ϱ� ����
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
								} //user�� ���
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
		<p>���� ���� ��� null ���</p>
		 <table class="table table-bordered">
			<thead id="th1">
			</thead>
			<tbody id="tb1">
			</tbody>
		</table>
		
		<h2>TWITTER-USER����</h2>
		<p>���� ���� ��� null ���</p>
		<table class="table table-bordered">
			<thead id="th2">
			</thead>
			<tbody id="tb2">
			</tbody>
		</table>
	</div>
	
</body>
</html>