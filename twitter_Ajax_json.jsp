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
		<p>���� ���� ��� null ���</p>
		<table class="table table-bordered">
		<thead id=thead>
		</thead>
			<tbody id="tbody">

			</tbody>
		</table>
	</div>

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
	
		//twitters is not defined at XMLHttpRequest.viewtwitter---?
		
	   
		
	    function viewtwitter(){  //printInfo �Լ��� �� ����:�Ȼ��� httpRequest.readyState �� 1,2,3�϶��� twitters�� �����Ͱ� ��(���������� ���� undifiened�� ���� ���������� ���� ������ 4�϶��� ������ ������ ���µ�)-������ �𸣰ڴ�
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
					twitter = {}; //XML �����͸� JSON���·� ��ȯ�� ���� var twitter�� ��������
					for (var j = 0; j < entryChilds.length; j++) {
						if (entryChilds[j].nodeType == 1) { //nodeType 1: ��� ���. ���� �����ؼ� ����ϱ� ���� ����. (�ؽ�Ʈ/������ 3)
							var currentName=entryChilds[j].nodeName;
							if (entryChilds[j].firstChild == null){//node���� ������ ��� null�� ����-null�̸� nodeValue�� ����� �� ��� if������ ó���������
								twitter[currentName]="null";
							}
							else if (entryChilds[j].firstChild != null) {
								if(currentName!='user'&&currentName!='entities'){
									twitter[currentName]=entryChilds[j].firstChild.nodeValue;
								}
 								if(currentName=='user'){ //�ڽĳ�尡 user�� ��� user�� �ڽĳ����� ����ϱ� ����
									var userChilds= entryChilds[j].childNodes; //���� �������� ���� �ѹ� �� ��ģ��
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
								} //user�� ���
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