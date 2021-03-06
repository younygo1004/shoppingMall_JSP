<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원 마이페이지</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="jquery.mobile/jquery.mobile-1.4.5.min.css" />
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
<script src="jquery.mobile/jquery.mobile-1.4.5.min.js"></script>

<meta name="viewport" content="width=device-width" ,initial-scale="1">

<script>
<!-- 검색 기능을 할 수 있도록 하는 스크립트-->
	$(document).ready(
			function() {
				$("#myInput2").on(
						"keyup",
						function() {
							var value = $(this).val().toLowerCase();
							$("#myTable2 tr").filter(
									function() {
										$(this).toggle(
												$(this).text().toLowerCase()
														.indexOf(value) > -1)
									});
						});
			});
</script>

<style>
#myTable tr.header, #myTable tr:hover {
	
}

.menu {
	float: left;
	width: 20%;
	height: 150vh;
}

.content {
	
}

table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: center;
	padding: 8px;
}

tr:nth-child(even) {
	
}
</style>

</head>

<body>
	<%
		String id = (String) session.getAttribute("id");
			System.out.println(id);
			//DB.getConnection();
	%>
	<!-- 컨테이너 -->
	<div class="container"
		style="position: absolute; left: 50%; margin-left: -45%; margin-right: 10%;">

		<!-- 상단 내용 -->
		<div style="float: left; width: 100%;">
			<div
				style="border-radius: 30px; width: 320px; height: 200px; background-color: #A9F5BC; font-size: 35px; margin-left: 10px; float: left;">

				<table>
					<tr>
						<td style="border: 0px;"><img src="img/delivery.png"
							width="100" height="100" /></td>
						<td style="border: 0px;"><p style="text-align: center;">배송중</p></td>
					</tr>
					<tr>
						<td style="border: 0px;"></td>
						<td style="border: 0px;"><%=DB.sending(id)%></td>
					</tr>
				</table>

			</div>

			<div
				style="border-radius: 30px; width: 320px; height: 200px; background-color: #A9F5BC; font-size: 35px; margin-left: 10px; float: left;">

				<table>
					<tr>
						<td style="border: 0px;"><img src="img/box.png" width="100"
							height="100" /></td>
						<td style="border: 0px;"><p style="text-align: center;">배송완료</p></td>
					</tr>
					<tr>
						<td style="border: 0px;"></td>
						<td style="border: 0px;"><%=DB.complete(id)%></td>
					</tr>
				</table>

			</div>

			<div
				style="border-radius: 30px; width: 320px; height: 200px; background-color: #A9F5BC; font-size: 35px; margin-left: 10px; float: left;">

				<table>
					<tr>
						<td style="border: 0px;"><img src="img/cancel.png"
							width="100" height="100" /></td>
						<td style="border: 0px;"><p style="text-align: center;">구매취소</p></td>
					</tr>
					<tr>
						<td style="border: 0px;"></td>
						<td style="border: 0px;"><%=DB.cancel(id)%></td>
					</tr>
				</table>

			</div>
		</div>
		<!-- 하단 내용 -->

		<div style="float: left; width: 100%;">
			<h2>내역 조회</h2>
			<p>구매 내역, 취소 내역, 배송 여부 등의 정보를 확인할 수 있는 페이지 입니다.</p>

			<table id="myTable2" width=100%>
				<thead style="background-color: #f1f1f1;">

					<tr>
						<th>상품 이미지</th>
						<th>구매날짜</th>
						<th>상품명</th>
						<th>구매/취소 개수</th>
						<th>상태<select id='filterText' style='display: inline-block'
							onchange='filterText()'>
								<option disabled selected>선택하세요</option>
								<option value='all'>전체 보기</option>
								<option value='배송'>구매 내역</option>
								<option value='구매 취소'>구매 취소 내역</option>
						</select></th>
					</tr>
					<tr>
						<input id="myInput2" type="text" placeholder="검색어를 입력하세요">
						<br>
						<br>
					</tr>
				</thead>

				<tbody id="myTable" id="myTable2">

					<!-- 반드시 tr마다 class="content"를 해줘야함!!!!!!!!!!!!! -->
					<%
					//DB.closeConnection();
					//DB.getConnection();
						request.setCharacterEncoding("euc-kr");
									ResultSet rs = DB.selectBuy(id);

									ResultSetMetaData md = rs.getMetaData();
									int count = md.getColumnCount();
									String[] columns = new String[count];
									String[] columnTypes = new String[count];

									for (int i = 0; i < count; i++)
										columns[i] = md.getColumnLabel(i + 1);

									while (rs.next()) {
										out.print("<tr class='content'>");
										for (int i = 0; i < columns.length; i++) {
											Object obj = rs.getObject(columns[i]);
											if (i == 0)
												out.print("<th><image src='img/" + obj + "' width='50px' height='50px'</th>");
											else
												out.print("<th>" + obj + "</th>");

										}
										out.print("</tr>");
									}

									rs = DB.selectCBuy(id);

									md = rs.getMetaData();
									count = md.getColumnCount();
									columns = new String[count];
									columnTypes = new String[count];

									for (int i = 0; i < count; i++)
										columns[i] = md.getColumnLabel(i + 1);

									while (rs.next()) {
										out.print("<tr class='content'>");
										for (int i = 0; i < columns.length; i++) {
											Object obj = rs.getObject(columns[i]);
											if (i == 0)
												out.print("<th><image src='img/" + obj + "' width='50px' height='50px'</th>");
											else
												out.print("<th>" + obj + "</th>");

										}
										out.print("<th> 구매 취소 </th>");
										out.print("</tr>");
									}
									//DB.closeConnection();
					%>
				</tbody>
			</table>

		</div>

	</div>


	<script>
	<!-- 배송 상태의 검색을 위한 스크립트 -->
		function filterText() {
			var rex = new RegExp($('#filterText').val());
			if (rex == "/all/") {
				clearFilter()
			} else {
				$('.content').hide();
				$('.content').filter(function() {
					return rex.test($(this).text());
				}).show();
			}
		}

		function clearFilter() {
			$('.filterText').val('');
			$('.content').show();
		}
	</script>


</body>
</html>
