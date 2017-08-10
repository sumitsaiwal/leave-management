<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="log" uri="http://logging.apache.org/log4j/tld/log" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cancel Leave</title>
<script src="js/jquery-1.11.1.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/bootstrap-table.css" rel="stylesheet">
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
		String userid=(String)sess.getAttribute("name");
		Connection con =DBConnection.getConnection();
		Statement stm=con.createStatement();
		//PreparedStatement p=con.prepareStatement("select leave_id,leavetype,startdate,enddate,comment,status from emp_leave where EmpID=? and status in ('Pending','Approved')");
		PreparedStatement p=con.prepareStatement("select leave_id,leavetype,startdate,enddate,comment,status from emp_leave where EmpID=? AND (status='Pending' OR status='Approved')");
		p.setString(1, userid);
		//p.setString(2,GetCurrentDateTime.test());
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
				<li class="active">Cancel Leave</li>
			</ol>
		</div><!--/.row-->
			<%if(request.getAttribute("errorMsg")!=null){%>
				<h5 style="color:red;margin-left:20px">&#9888 <%=request.getAttribute("errorMsg").toString()%></h5>
				<%}else if(request.getAttribute("successMsg")!=null){%>
				<h5 style=color:green;margin-left:20px>&#10004 <%=request.getAttribute("successMsg").toString()%></h5>
				<%} %>
			
			<%if(!rs.first()){%>
			<h5 style="color:red;margin-left:20px">&#9888 Sorry you don't any have leave to cancel</h5>
			<%}
			else{%>
		
				
		
		<div>&nbsp;
		</div>
		
		<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<table data-toggle="table" id="table-style" data-row-style="rowStyle" data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-search="true" data-select-item-name="toolbar1" data-pagination="true" data-sort-name="name" data-sort-order="desc">
						    <thead>
						    <tr>
						        <th data-field="id" >Leave ID</th>
						        <th data-field="type" >Leave Type</th>
						        <th data-field="name"  data-sortable="true" >Start Date</th>
						        <th data-field="e_date" >End Date</th>
						        <th data-field="comment" >Comment</th>
						        <th data-field="status" >Status</th>
						    </tr>
						    </thead>
						    <% 
						       java.util.Date date2=ChangeDate.returnDate(GetCurrentDateTime.test());
						    %>
						    <% do{ if(rs.getString(6).equals("Pending") ||  ChangeDate.returnDate(rs.getString(4)).compareTo(date2)>=0){ %>
						    <tr>
	  							<td><%= rs.getString(1) %></td> 
	  
	 							<td><%= rs.getString(2) %></td>
	 
	  							<td><%= rs.getString(3) %></td>
	  
	  							<td><%= rs.getString(4) %></td>
	  
	 							<td><%= rs.getString(5) %></td>
	 
	 							<td><%= rs.getString(6) %></td>
	 							 
						    	<td>
						    	<!--  <input type="button" name="submit" value="Submit" class="btn btn-primary"></td>-->
						    	<button type="button" class="use-address">Cancel</button></td>
						    	
						    </tr>
						    	<% }}while(rs.next()) ;%>
	  							<% con.close();} %>
	  							<log:info message="DB Connection closed" />
	  							<% } %>
						</table>
					</div>
				</div>
			</div>
	</div>	<!--/.main-->
	
	</c:catch>
	<c:if test="${myException != null}">
    <log:catching exception="${myException}" />
	</c:if>
	
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/bootstrap-table.js"></script>
	
	<script type="text/javascript">
		$(".use-address").click(function() {
    		var address = [];
    	$(this).closest('tr').find('td').not(':last').each(function() {
        	var textval = $(this).text(); // this will be the text of each <td>
       		address.push(textval);
   });
    	console.log('Approved Loop');
    	address[0] = address[0].toString().replace(/^\s+|\s+$/g, '');
		address[1] = address[1].toString().replace(/^\s+|\s+$/g, '');
		address[2] = address[2].toString().replace(/^\s+|\s+$/g, '');
		address[3] = address[3].toString().replace(/^\s+|\s+$/g, '');
		address[5] = address[5].toString().replace(/^\s+|\s+$/g, '');
    	
    	    var form = document.createElement("form");
    	    var element1 = document.createElement("input"); 
    	    var element2 = document.createElement("input"); 
    	    var element3 = document.createElement("input"); 
    	    var element4 = document.createElement("input"); 
    	    var element5 = document.createElement("input"); 

    	    form.method = "POST";
    	    form.action = "CancelLeave";   

    	    element1.value=address[0].toString();
    	    element1.name="lid";
    	    form.appendChild(element1);  

    	    element2.value=address[1].toString();
    	    element2.name="leave_type";
    	    form.appendChild(element2);
    	    
    	    element3.value=address[2].toString();
    	    element3.name="start_date";
    	    form.appendChild(element3);
    	    
    	    element4.value=address[3].toString();
    	    element4.name="end_date";
    	    form.appendChild(element4);
    	    
    	    element5.value=address[5].toString();
    	    element5.name="status";
    	    form.appendChild(element5);

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
