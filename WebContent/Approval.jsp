<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Approval History</title>
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
		Connection con =DBConnection.getConnection();
		Statement stm=con.createStatement();
		PreparedStatement p=con.prepareStatement("select emp_leave.leave_id, emp_leave.EmpID, emp_register.EmpName, emp_leave.leavetype, emp_leave.startdate, emp_leave.enddate, emp_leave.comment from emp_leave join emp_register on  emp_leave.EmpID=emp_register.EmpID where emp_leave.status='Pending'");
		ResultSet rs =p.executeQuery();
			if(!rs.first()){
			request.setAttribute("ErrorMsg", "Soryy you dont have any leave to approve");
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
		
			<li class="active"><a href="adminwelcome.jsp"><svg class="glyph stroked dashboard-dial"><use xlink:href="#stroked-dashboard-dial"></use></svg> Dashboard</a></li>
			<li><a href="Approval.jsp"><svg class="glyph stroked calendar"><use xlink:href="#stroked-calendar"></use></svg>Leave Approvals</a></li>
			<li><a href="CancellationApproval.jsp"><svg class="glyph stroked table"><use xlink:href="#stroked-table"></use></svg>Cancellation Approvals</a></li>
			<li><a href="ApprovalHistory.jsp"><svg class="glyph stroked line-graph"><use xlink:href="#stroked-line-graph"></use></svg>Approval History</a></li>
			
		</ul>
	</div><!--/.sidebar-->
		
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#"><svg class="glyph stroked home"><use xlink:href="#stroked-home"></use></svg></a></li>
				<li class="active">Approvals</li>
			</ol>
		</div><!--/.row-->
		
		<%if(request.getAttribute("errorMsg")!=null){%>
				<h5 style="color:red;margin-left:20px">&#9888 <%=request.getAttribute("errorMsg").toString()%></h5>
				<%}else if(request.getAttribute("successMsg")!=null){%>
				<h5 style=color:green;margin-left:20px>&#10004 <%=request.getAttribute("successMsg").toString()%></h5>
				<%} %>
		
		<div>&nbsp;
		</div>
		
		<script>
				function submitter(btn) {
    			var param = btn.parentElement.parentElement.id;
    			var myForm = document.forms["myForm"];
    			myForm.elements["param"].value = param;
    			myForm.submit();
				}
		</script>
						
		<form method="post" action="Approval" id="myForm">
		<input type="hidden" name="param" />
		<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<table data-toggle="table" id="table-style" data-row-style="rowStyle" data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-search="true" data-select-item-name="toolbar1" data-pagination="true" data-sort-name="name" data-sort-order="desc">
						    <thead>
						    <tr>
						        <th data-field="id" >Leave ID</th>
						        <th data-field="empid" >Employee ID</th>
						        <th data-field="empname" >Employee Name</th>
						        <th data-field="type" >Leave Type</th>
						        <th data-field="name"  data-sortable="true">Start Date</th>
						        <th data-field="e_date" >End Date</th>
						        <th data-field="comment" >Comment</th>
						        <th data-field="status" >Status</th>
						    </tr>
						    </thead>
						    <% do{ %>
						     <tr>
	  							<td><%= rs.getString(1) %>
	  							<input type="hidden" name="lid" value="<%= rs.getString(1) %>"></td> 
	  
	 							<td><%= rs.getString(2) %>
	 							<input type="hidden" name="emp_id" value="<%= rs.getString(2) %>"></td>
	 							
	 							<td><%= rs.getString(3) %></td>
	 							
	 							<td><%= rs.getString(4) %>
	  							<input type="hidden" name="leave_type" value="<%= rs.getString(4) %>"></td>
	 							
	  							<td><%= rs.getString(5) %>
	  							<input type="hidden" name="start_date" value="<%= rs.getString(5) %>"></td>
	  
	  							<td><%= rs.getString(6) %>
	  							<input type="hidden" name="end_date" value="<%= rs.getString(6) %>"></td>
	  
	 							<td><%= rs.getString(7) %></td>
	 							 
	 							<td>
	 							<select name="status">
								<option>Approved</option>
								<option>Rejected</option>
								</select>
								
						    	<input type="button" name="submit" value="Submit" onclick="submitter(this)" class="btn btn-primary"></td>
						    </tr>
						    
						    	<% }while(rs.next()) ;%>
	  							<% con.close();} %>
	  							<% } %>
						</table>
						
						<!-- <script>
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
		</form>
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
</body>

</html>
