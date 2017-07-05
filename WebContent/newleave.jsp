<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.leave.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User - Dashboard</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body>
	<% 
		HttpSession sess=request.getSession();
		if(sess.getAttribute("name")==null){
			response.sendRedirect("index.jsp");
		}
		
	%>
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
			<li><a href="tables.html"><svg class="glyph stroked table"><use xlink:href="#stroked-table"></use></svg> Leave History</a></li>
			
		</ul>
	</div><!--/.sidebar-->
		
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#"><svg class="glyph stroked home"><use xlink:href="#stroked-home"></use></svg></a></li>
				<li class="active">Leave Form</li>
			</ol>
		</div><!--/.row-->
		
		<!--  <div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Dashboard</h1>
			</div>
		</div> -->
	
		<div>&nbsp;
		</div>
		<div class="row">
		<div class="col-xs-12 col-md-8">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">Apply for Leave</div>
				<%if(request.getAttribute("errorMsg")!=null){ System.out.println("error: "+request.getAttribute("errorMsg"));%>
				<h5 style="color:red;margin-left:20px">&#9888 <%=request.getAttribute("errorMsg").toString()%></h5>
				<%}else if(request.getAttribute("successMsg")!=null){%>
				<h5 style=color:green;margin-left:20px>&#10004 <%=request.getAttribute("successMsg").toString()%></h5>
				<%} %>
				<div class="panel-body">
					<form method="post" action="leaveApp">
						<fieldset>
						
							<div class="form-group">
									<label>Leave type</label>
									<select class="form-control" name="leavetype">
										<option>Planned Leave</option>
										<option>Sick/Casual leave</option>
									</select>
							</div>
							<div class="form-group">
									<label>Start Date</label>
									<input class="form-control" id="StartDate" name="startdate" placeholder="MM/DD/YYY" required>
								<div id="errorMsg1" style="display:none">
								<p style="color:red">Date Entered is lesser than Current Date</p>
								</div>
								<div id="errorMsg2" style="display:none">
								<p style="color:red">Date Entered is greater than End Date</p>
								</div>
							</div>
							
							<div class="form-group">
									<label>End Date</label>
									<input class="form-control" id="EndDate" name="enddate" placeholder="MM/DD/YYY" required>
								<div id="errorMsg3" style="display:none">
								<p style="color:red">End date should be greater than Start date</p>
								</div>
							</div>
							<div class="form-group">
									<label>Comment</label>
									<textarea class="form-control" rows="3" name="comment" required></textarea>
							</div>
							<div class="form-group">
									<select class="form-control" name="status" style="display:none;">
										<option selected="selected">Pending</option>
										<option>Approved</option>
										<option>Rejected</option>
									</select>
							</div>
							<button type="submit" class="btn btn-primary">Apply</button>&nbsp;
							<button type="reset" class="btn btn-default">Reset</button>
				
						</fieldset>
					</form>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-md-8">
		&nbsp;
		</div><!-- /.col-->
	</div><!--/.row-->
		
	</div>	<!--/.main-->

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script>
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
	
	<script>
	$("#StartDate, #EndDate").datepicker({
	    format: 'dd/mm/yyyy',
	}).on('changeDate', function(e){
	    $(this).datepicker('hide'); 
	});
	$("#StartDate").change(function () {
		var dateEntered = document.getElementById("StartDate").value; 
		if(dateEntered!=""){
	    console.log("dateEntered"+dateEntered	);
	    var date = dateEntered.substring(0, 2);
	    var month = dateEntered.substring(3, 5);
	    var year = dateEntered.substring(6, 10);
	    
	    console.log("prnting date..."+ date+" : "+month+" : "+year);

	    var dateToCompare = new Date(year, month - 1, date);
	    console.log("date to compare"+ dateToCompare);
	    var q = new Date();
	    var m = q.getMonth();
	    var d = q.getDate();
	    var y = q.getFullYear();
	 
	    var currentDate = new Date(y,m,d);
	    
	    console.log("dcurrent date"+ currentDate);
	    if ((dateToCompare < currentDate)) {
	    	document.getElementById("errorMsg1").style.display="block";
	        document.getElementById("StartDate").value = ""; 
	        
	    }else{
	    	
	    	document.getElementById("errorMsg1").style.display="none";
	    	
	    }
	    
	    var endDate = document.getElementById("EndDate").value;
	    var edate = endDate.substring(0, 2);
	    var emonth = endDate.substring(3, 5);
	    var eyear = endDate.substring(6, 10);
	    var eDate = new Date(eyear, emonth - 1, edate);
	    console.log("end date"+ eDate);
	    if ((( dateToCompare>eDate)&&(endDate!=""))) {
	    	console.log("date to compare: "+dateToCompare)
	    	console.log("End Date: "+edate)
      console.log(dateToCompare>eDate);
      console.log(document.getElementById("EndDate").value!="");
	    	console.log("Error2!!")
	        document.getElementById("errorMsg2").style.display="block";
	    	document.getElementById("StartDate").value="";
	    
	         
	        
	    }else{
	    	document.getElementById("errorMsg2").style.display="none";
	    }
		
		}
	});
	$("#EndDate").change(function () {
		
	    var startDate = document.getElementById("StartDate").value;
	    var endDate = document.getElementById("EndDate").value;
	    if(endDate!="")
	    {
	    var sdate = startDate.substring(0, 2);
	    var smonth = startDate.substring(3, 5);
	    var syear = startDate.substring(6, 10);
	    
	    var edate = endDate.substring(0, 2);
	    var emonth = endDate.substring(3, 5);
	    var eyear = endDate.substring(6, 10);
	 
	    var sDate = new Date(syear, smonth, sdate);
	    var eDate = new Date(eyear, emonth, edate);
	 
	    if (eDate < sDate) {
	    	console.log("sDate: "+sDate);
	    	console.log("eDate: "+eDate);
	    	console.log(eDate < sDate);
	    	document.getElementById("EndDate").value = ""; 
	    	document.getElementById("errorMsg3").style.display="block";
	    }else{
	    	document.getElementById("errorMsg3").style.display="none";
	    }
	    }
	   
	});
	</script>	
</body>

</html>
