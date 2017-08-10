<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="log" uri="http://logging.apache.org/log4j/tld/log" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cancellation Approvals</title>
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

	<c:catch var="myException">
	
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
		PreparedStatement p=con.prepareStatement("select emp_leave.leave_id, emp_leave.EmpID, emp_register.EmpName, emp_leave.leavetype, emp_leave.startdate, emp_leave.enddate, emp_leave.comment from emp_leave join emp_register on  emp_leave.EmpID=emp_register.EmpID where emp_leave.status='CancelPending'");
		ResultSet rs =p.executeQuery();%>
			
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="adminwelcome.jsp"><span>Easy</span>Leave</a>
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
				<li class="active">Cancellation Approvals</li>
			</ol>
		</div><!--/.row-->
		<%if(request.getAttribute("errorMsg")!=null){%>
				<h5 style="color:red;margin-left:20px">&#9888 <%=request.getAttribute("errorMsg").toString()%></h5>
				<%}else if(request.getAttribute("successMsg")!=null){%>
				<h5 style=color:green;margin-left:20px>&#10004 <%=request.getAttribute("successMsg").toString()%></h5>
				<%} %>
				
		<% if(!rs.first()){%>
		<h5 style=color:red;margin-left:20px">&#9888 Sorry you dont have any Cancellation to approve</h5>
		<%}
			else{%>
			
				
			
		<div>&nbsp;
		</div>
		
		<!-- <script>
				function submitter(btn) {
    			var param = btn.parentElement.parentElement.id;
    			var myForm = document.forms["myForm"];
    			myForm.elements["param"].value = param;
    			myForm.submit();
				}
		</script>-->
						
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
	  							<td><%= rs.getString(1) %></td> 
	  
	 							<td><%= rs.getString(2) %></td>
	 							
	 							<td><%= rs.getString(3) %></td>
	 							
	 							<td><%= rs.getString(4) %></td>
	 							
	  							<td><%= rs.getString(5) %></td>
	  
	  							<td><%= rs.getString(6) %></td>
	  
	 							<td><%= rs.getString(7) %></td>
	 							 
	 							<!--  <td>
	 							<select name="status">
								<option>Approved</option>
								<option>Rejected</option>
								</select>
								</td>-->
								
								<td>
						    	<!--  <input type="button" name="submit" value="Submit" class="btn btn-primary"></td>-->
						    	<button type="button" class="use-address">Approve</button></td>
						    	<td><button type="button" class="rej-address">Reject</button></td>
						    	
						    </tr>
						    
						    	<% }while(rs.next()) ;%>
	  							<% con.close();} %>
	  							<log:info message="DB Connection closed" />
	  							<% } %>
						</table>

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
	
	</c:catch>
	<c:if test="${myException != null}">
    <log:catching exception="${myException}" />
	</c:if>
	
	<script type="text/javascript">
		$(".use-address").click(function() {
    		var myForm = document.forms["myForm"];
    		var address = [];
    	$(this).closest('tr').find('td').not(':last').each(function() {
        	var textval = $(this).text(); // this will be the text of each <td>
       		address.push(textval);
   });
    	console.log('Approved Loop');
    	address[0] = address[0].toString().replace(/^\s+|\s+$/g, '');
		address[1] = address[1].toString().replace(/^\s+|\s+$/g, '');
		address[3] = address[3].toString().replace(/^\s+|\s+$/g, '');
		address[4] = address[4].toString().replace(/^\s+|\s+$/g, '');
		address[5] = address[5].toString().replace(/^\s+|\s+$/g, '');
		address[6] = "CancelApproved";
    	
    	    var form = document.createElement("form");
    	    var element1 = document.createElement("input"); 
    	    var element2 = document.createElement("input"); 
    	    var element3 = document.createElement("input"); 
    	    var element4 = document.createElement("input"); 
    	    var element5 = document.createElement("input"); 
    	    var element6 = document.createElement("input"); 

    	    form.method = "POST";
    	    form.action = "CancellationApproval";   

    	    element1.value=address[0].toString();
    	    element1.name="lid";
    	    form.appendChild(element1);  

    	    element2.value=address[1].toString();
    	    element2.name="emp_id";
    	    form.appendChild(element2);
    	    
    	    element3.value=address[3].toString();
    	    element3.name="leave_type";
    	    form.appendChild(element3);
    	    
    	    element4.value=address[4].toString();
    	    element4.name="start_date";
    	    form.appendChild(element4);
    	    
    	    element5.value=address[5].toString();
    	    element5.name="end_date";
    	    form.appendChild(element5);
    	    
    	    element6.value=address[6].toString();
    	    element6.name="status";
    	    form.appendChild(element6);

    	    document.body.appendChild(form);

    	    form.submit();
	});
</script>

<script type="text/javascript">
		$(".rej-address").click(function() {
    		var myForm = document.forms["myForm"];
    		var address = [];
    	$(this).closest('tr').find('td').not(':last').each(function() {
        	var textval = $(this).text(); // this will be the text of each <td>
       		address.push(textval);
   });
    	console.log('Rejected Loop');
    	
    	address[0] = address[0].toString().replace(/^\s+|\s+$/g, '');
		address[1] = address[1].toString().replace(/^\s+|\s+$/g, '');
		address[3] = address[3].toString().replace(/^\s+|\s+$/g, '');
		address[4] = address[4].toString().replace(/^\s+|\s+$/g, '');
		address[5] = address[5].toString().replace(/^\s+|\s+$/g, '');
		address[6] = "CancelRejected";
    	
    	    var form = document.createElement("form");
    	    var element1 = document.createElement("input"); 
    	    var element2 = document.createElement("input"); 
    	    var element3 = document.createElement("input"); 
    	    var element4 = document.createElement("input"); 
    	    var element5 = document.createElement("input"); 
    	    var element6 = document.createElement("input"); 

    	    form.method = "POST";
    	    form.action = "CancellationApproval";   

    	    element1.value=address[0].toString();
    	    element1.name="lid";
    	    form.appendChild(element1);  

    	    element2.value=address[1].toString();
    	    element2.name="emp_id";
    	    form.appendChild(element2);
    	    
    	    element3.value=address[3].toString();
    	    element3.name="leave_type";
    	    form.appendChild(element3);
    	    
    	    element4.value=address[4].toString();
    	    element4.name="start_date";
    	    form.appendChild(element4);
    	    
    	    element5.value=address[5].toString();
    	    element5.name="end_date";
    	    form.appendChild(element5);
    	    
    	    element6.value=address[6].toString();
    	    element6.name="status";
    	    form.appendChild(element6);

    	    document.body.appendChild(form);

    	    form.submit();
    	
	});
</script>
	
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
