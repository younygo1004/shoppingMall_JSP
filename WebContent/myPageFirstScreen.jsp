<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ȸ�� ����������</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="jquery.mobile/jquery.mobile-1.4.5.min.css" />
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
<script src="jquery.mobile/jquery.mobile-1.4.5.min.js"></script>

<meta name="viewport" content="width=device-width" ,initial-scale="1">

<script>
<!-- �˻� ����� �� �� �ֵ��� �ϴ� ��ũ��Ʈ-->
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
	<!-- �����̳� -->
	<div class="container"
		style="position: absolute; left: 50%; margin-left: -45%; margin-right: 10%;">

		<!-- ��� ���� -->
		<div style="float: left; width: 100%;">
			<div
				style="border-radius: 30px; width: 320px; height: 200px; background-color: #A9F5BC; font-size: 35px; margin-left: 10px; float: left;">

				<table>
					<tr>
						<td style="border: 0px;"><img src="img/delivery.png"
							width="100" height="100" /></td>
						<td style="border: 0px;"><p style="text-align: center;">�����</p></td>
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
						<td style="border: 0px;"><p style="text-align: center;">��ۿϷ�</p></td>
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
						<td style="border: 0px;"><p style="text-align: center;">�������</p></td>
					</tr>
					<tr>
						<td style="border: 0px;"></td>
						<td style="border: 0px;"><%=DB.cancel(id)%></td>
					</tr>
				</table>

			</div>
		</div>
		<!-- �ϴ� ���� -->

		<div style="float: left; width: 100%;">
			<h2>���� ��ȸ</h2>
			<p>���� ����, ��� ����, ��� ���� ���� ������ Ȯ���� �� �ִ� ������ �Դϴ�.</p>

			<table id="myTable2" width=100%>
				<thead style="background-color: #f1f1f1;">

					<tr>
						<th>��ǰ �̹���</th>
						<th>���ų�¥</th>
						<th>��ǰ��</th>
						<th>����/��� ����</th>
						<th>����<select id='filterText' style='display: inline-block'
							onchange='filterText()'>
								<option disabled selected>�����ϼ���</option>
								<option value='all'>��ü ����</option>
								<option value='���'>���� ����</option>
								<option value='���� ���'>���� ��� ����</option>
						</select></th>
					</tr>
					<tr>
						<input id="myInput2" type="text" placeholder="�˻�� �Է��ϼ���">
						<br>
						<br>
					</tr>
				</thead>

				<tbody id="myTable" id="myTable2">

					<!-- �ݵ�� tr���� class="content"�� �������!!!!!!!!!!!!! -->
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
										out.print("<th> ���� ��� </th>");
										out.print("</tr>");
									}
									//DB.closeConnection();
					%>
				</tbody>
			</table>

		</div>

	</div>


	<script>
	<!-- ��� ������ �˻��� ���� ��ũ��Ʈ -->
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