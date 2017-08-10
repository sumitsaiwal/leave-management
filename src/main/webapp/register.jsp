<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User Registration</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

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
				<div class="panel-heading">User Registration</div>
				<%if(request.getAttribute("errorMsg")!=null){%>
				<h5 style="color:red;margin-left:20px">&#9888 <%=request.getAttribute("errorMsg").toString()%></h5>
				<%}else if(request.getAttribute("successMsg")!=null){%>
				<h5 style=color:green;margin-left:20px>&#10004 <%=request.getAttribute("successMsg").toString()%></h5>
				<%} %>
				<div class="panel-body">
					<form method="post" action="register">
						<fieldset>
							<div class="form-group">
								<input class="form-control" placeholder="User ID" name="id" type="number" min="100000" max="999999" required/>
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="User Name" name="name" type="text" required/>
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="User Email" name="email" type="email" required/>
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="Password" name="pass" type="password" required/>
							</div>
							<div>
							&nbsp;
							</div>
							<div>
							<input type="submit" name="submit" value="Create new account" class="btn btn-primary">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="index.jsp" class="btn btn-primary">Cancel</a>
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
</body>

</html>
