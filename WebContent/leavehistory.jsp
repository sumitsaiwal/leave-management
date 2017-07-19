<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Leave History</title>
<script src="js/jquery-1.11.1.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">
<script src="js/bootstrap-table.js"></script>

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body>
	<%@ page import="java.sql.*" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="com.leave.*" %>

	<% 
		HttpSession sess=request.getSession();
		if(sess.getAttribute("name")==null){
			response.sendRedirect("index.jsp");
		}
		else{
		String userid=(String)sess.getAttribute("name");
		Connection con =DBConnection.getConnection();
		Statement stm=con.createStatement();
		PreparedStatement p=con.prepareStatement("select leave_id,leavetype,startdate,enddate,comment,status from emp_leave where EmpID=?");
		p.setString(1, userid);
		ResultSet rs =p.executeQuery();
			if(!rs.first()){
			request.setAttribute("ErrorMsg", "Soryy you have not applied for any leave");
			}
			else{%>
	
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="userwelcome.jsp"><span>Easy</span>Leave</a>
				<ul class="user-menu">
					<li class="dropdown pull-right">
						<svg class="glyph stroked male-user"><use xlink:href="#stroked-male-user"></use></svg><font color="white"><%=session.getAttribute("username")%></font>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="Logout">Logout</a></li>
						
					</li>
				</ul>
			</div>
							
		</div><!-- /.container-fluid -->
	</nav>
		
	<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		
		<ul class="nav menu">
			<li class="active"><a href="userwelcome.jsp"><svg class="glyph stroked dashboard-dial"><use xlink:href="#stroked-dashboard-dial"></use></svg> Dashboard</a></li>
			<li><a href="newleave.jsp"><svg class="glyph stroked calendar"><use xlink:href="#stroked-calendar"></use></svg> Apply for Leave</a></li>
			<li><a href="cancelLeave.jsp"><svg class="glyph stroked line-graph"><use xlink:href="#stroked-line-graph"></use></svg> Cancel Leave</a></li>
			<li><a href="leavehistory.jsp"><svg class="glyph stroked table"><use xlink:href="#stroked-table"></use></svg> Leave History</a></li>
			
		</ul>
	</div><!--/.sidebar-->
		
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#"><svg class="glyph stroked home"><use xlink:href="#stroked-home"></use></svg></a></li>
				<li class="active">Leave History</li>
			</ol>
		</div><!--/.row-->
		<div>&nbsp;
		</div>
		
		<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<table data-toggle="table" id="table-style" data-row-style="rowStyle" data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-search="true" data-select-item-name="toolbar1" data-pagination="true" data-sort-name="name" data-sort-order="desc">
						    <thead>
						    <tr>
						        <th data-field="id">Leave ID</th>
						        <th data-field="type" >Leave Type</th>
						        <th data-field="s_date" >Start Date</th>
						        <th data-field="e_date" >End Date</th>
						        <th data-field="comment" >Comment</th>
						        <th data-field="status" >Status</th>
						    </tr>
						    </thead>
						    <% do{ %>
						    <tr class="<%= rs.getString(6) %>">
	  							<td><%= rs.getString(1) %></td> 
	  
	 							<td><%= rs.getString(2) %></td>
	 
	  							<td><%= rs.getString(3) %></td>
	  
	  							<td><%= rs.getString(4) %></td>
	  
	 							<td><%= rs.getString(5) %></td>
	 
	 							<td><%= rs.getString(6) %></td> 
						    
						    	<% }while(rs.next()) ;%>
	  							<% con.close();} %>
	  							<% } %>
						</table>
					<!-- 	<script>
						    function rowStyle(row, index) {
						        var classes = ['active', 'success', 'info', 'warning', 'danger'];
						        var data = document.getElementById("table-style");
						        for (index = 0; index < data.rows.length; j=index++) {
						            if ( data.rows[index].cells[5].innerHTML.indexOf("Pending") >= 0) 
						            	return {classes: classes[0]};
						            if ( data.rows[index].cells[5].innerHTML.indexOf("Approved") >= 0) 
							            return {classes: classes[1]};
							        if ( data.rows[index].cells[5].innerHTML.indexOf("Rejected") >= 0)
							        	return {classes: classes[4]};
						         }
						        return {};
						    }
						</script> -->
					</div>
				</div>
			</div>
	</div>	<!--/.main-->
	
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/bootstrap-table.js"></script>
	
	<script>
		$('#calendar').datepicker({
		});

		!function ($) {
		    $(document).on("click","ul.nav li.parent > a > span.icon", function(){          
		        $(this).find('em:first').toggleClass("glyphicon-minus");      
		    }); 
		    $(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function () {
		  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function () {
		  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
		})
		
	</script>	
<!-- 	<script type="text/javascript">
	$(function(){
		  $("tr").each(function(){
		    var col_val = $(this).find("td:eq(5)").text();
		    if ((col_val == "Pending")|(col_val == "CancelPending")){
		      $(this).addClass('warning');  //the selected class colors the row green//
		    }else if ((col_val == "Approved")|(col_val == "CancelApproved")){
		      $(this).addClass('success');
		    }else if ((col_val == "Rejected")|(col_val == "CancelRejected")){
		    	$(this).addClass('danger');
		    }
		  });
		});
	</script> -->
</body>

</html>
