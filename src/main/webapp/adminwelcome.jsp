<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="log" uri="http://logging.apache.org/log4j/tld/log" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin - Dashboard</title>

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
		int no_Pending=0,no_Approved=0,no_Rejected=0,no_CancelPending=0,no_CancelApproved=0,no_CancelRejected=0;
		Connection con =DBConnection.getConnection();
		Statement stm=con.createStatement();
		//PreparedStatement p=con.prepareStatement("select status from emp_leave");
		ResultSet rs =stm.executeQuery("select status from emp_leave");
		while (rs.next()){
			
			if (rs.getString(1).contentEquals("Pending")){
				++no_Pending;
			}
			else if (rs.getString(1).contentEquals("Approved")){
				++no_Approved;
			}
			else if (rs.getString(1).contentEquals("Rejected")){
				++no_Rejected;
			}
			else if (rs.getString(1).contentEquals("CancelPending")){
				++no_CancelPending;
			}
			else if (rs.getString(1).contentEquals("CancelApproved")){
				++no_CancelApproved;
			}
			else if (rs.getString(1).contentEquals("CancelRejected")){
				++no_CancelRejected;
			}
			
		}%>
		<% con.close(); %>
		<log:info message="DB Connection closed" />

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
				<li class="active">Admin Dashboard</li>
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
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-default">
					<div class="panel-body easypiechart-panel">
						<h4>Pending Leave</h4>
						<div class="easypiechart" id="easypiechart-blue" data-percent="100" ><span class="percent"><%=no_Pending%>&nbsp;</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-default">
					<div class="panel-body easypiechart-panel">
						<h4>Approved Leave</h4>
						<div class="easypiechart" id="easypiechart-orange" data-percent="100" ><span class="percent"><%=no_Approved%>&nbsp;</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-default">
					<div class="panel-body easypiechart-panel">
						<h4>Rejected Leave</h4>
						<div class="easypiechart" id="easypiechart-teal" data-percent="100" ><span class="percent"><%=no_Rejected%>&nbsp;</span>
						</div>
					</div>
				</div>
			</div>
			</div><!--/.row-->
			
<!--  			<div class="row">
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-default">
					<div class="panel-body easypiechart-panel">
						<h4>Cancellation Pending</h4>
						<div class="easypiechart" id="easypiechart-red" data-percent="100" ><span class="percent"><%=no_CancelPending%>&nbsp;</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-default">
					<div class="panel-body easypiechart-panel">
						<h4>Cancellation Approved</h4>
						<div class="easypiechart" id="easypiechart-blue" data-percent="100" ><span class="percent"><%=no_CancelApproved%>&nbsp;</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-default">
					<div class="panel-body easypiechart-panel">
						<h4>Cancellation Rejected</h4>
						<div class="easypiechart" id="easypiechart-orange" data-percent="100" ><span class="percent"><%=no_CancelRejected%>&nbsp;</span>
						</div>
					</div>
				</div>
			</div>
		</div><!--/.row-->
		
		
		
<div class="row">
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-blue panel-widget ">
					<div class="row no-padding">
						<div class="col-sm-3 col-lg-5 widget-left">
							<svg class="glyph stroked bag"><use xlink:href="#stroked-dashboard-dial"></use></svg>
						</div>
						<div class="col-sm-9 col-lg-7 widget-right">
							<div class="large"><%=no_CancelPending%></div>
							<div class="text-muted">Cancellation Pending</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-orange panel-widget">
					<div class="row no-padding">
						<div class="col-sm-3 col-lg-5 widget-left">
							<svg class="glyph stroked empty-message"><use xlink:href="#stroked-checkmark"></use></svg>
						</div>
						<div class="col-sm-9 col-lg-7 widget-right">
							<div class="large"><%=no_CancelApproved%></div>
							<div class="text-muted">Cancellation Approved</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-md-4">
				<div class="panel panel-red panel-widget">
					<div class="row no-padding">
						<div class="col-sm-3 col-lg-5 widget-left">
							<svg class="glyph stroked app-window-with-content"><use xlink:href="#stroked-cancel"></use></svg>
						</div>
						<div class="col-sm-9 col-lg-7 widget-right">
							<div class="large"><%=no_CancelRejected%>
							</div>
							<div class="text-muted">Cancellation Rejected</div>
						</div>
					</div>
				</div>
			</div>
		</div><!--/.row-->
		
		
	</div>	<!--/.main-->
<% } %>

</c:catch>
<c:if test="${myException != null}">
    <log:catching exception="${myException}" />
</c:if>

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
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
