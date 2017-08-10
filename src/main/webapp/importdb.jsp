<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="log" uri="http://logging.apache.org/log4j/tld/log" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Database Tasks</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">

</head>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.jsp"><span>Easy</span>Leave</a>
			</div>
							
		</div><!-- /.container-fluid -->
	</nav>
	<div>
	&nbsp;
	</div>
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">Database Tasks</div>
				
				<%if(request.getAttribute("ErrorMsg")!=null){%>
				<h5 style="color:red">&#9888 <%=request.getAttribute("ErrorMsg").toString()%></h5>
				<%}else if(request.getAttribute("successMsg")!=null){%>
				<h5 style=color:green;margin-left:20px>&#10004 <%=request.getAttribute("successMsg").toString()%></h5>
				<%} %><%if(request.getAttribute("successMsg1")!=null){%>
				<h5 style=color:green;margin-left:20px>&#10004 <%=request.getAttribute("successMsg1").toString()%></h5><%} %>
				<div class="panel-body">
					<form method="post" action="CheckDB">
						<fieldset>
							
							<div>
								<input type="submit" name="submit" value="Click here to check Database Connectivity" class="btn btn-primary">
							</div>
						</fieldset>
					</form>
					<form method="post" action="ImportDB" enctype="multipart/form-data">
						<fieldset>
							<div>
							&nbsp;
							</div>
							<div class="form-group">
									<label>File input</label>
									<input name='file' type="file">
									 <p class="help-block">Choose a .SQL file.</p>
								
								<input type="submit" name="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click here to Import Data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" class="btn btn-primary">
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div><!-- /.col-->
	</div><!-- /.row -->	
	
		

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
		
</body>

</html>
