<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.leave.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">
<link href='css/fullcalendar.min.css' rel='stylesheet' />
<link href='css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='js/moment.min.js'></script>
<script src='js/jquery.min.js'></script>
<script src='js/fullcalendar.min.js'></script>
<style>
.fc-time{
   display : none;
}
</style>
<script>

	$(document).ready(function() {
		var leaveType=null;
		var startDate=null;
		var endDate=null
		var eventData=null;
		$.ajax({
           url : "DateClient",
           type : "POST",
           success : function(responseJson) {
              console.log(responseJson);  
              
                leaveType=responseJson["leaveType"];
                startDate=responseJson["startDate"];
                endDate=responseJson["endDate"];
                $.each(leaveType,function(i,item){
                	var sdate=startDate[i];
                	var newdate = sdate.split("/").reverse().join("/");
                	console.log("NewDate="+newdate);
                	var edate=endDate[i];
                	var newEndDate=edate.split("/").reverse().join("/");
                     var l = leaveType[i];
                     var s= new Date(newdate);
                     var e= new Date(newEndDate);
                     e.setDate(e.getDate() + 1);
                     console.log("New end date="+e);
                     console.log(l);
                     console.log("startdate "+s);
                     console.log("enddate"+newEndDate);
                eventData= {
        				title: l,
        				start: newdate,
        				end: e,
        				allDay: false
        				
        			};
                console.log(eventData);
                
                
                $('#calendar').fullCalendar('renderEvent', eventData, true);
                } );
           },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert(jqXHR+" - "+textStatus+" - "+errorThrown);
                   }
                   
            });
           
                $('#calendar').fullCalendar({
                	header: {
                		left: 'prev,next today',
        				center: 'title',
        				right: 'month,agendaWeek,agendaDay,listWeek'
        			},
        			navLinks: true,
        			selectable:true,
        			selectHelper:true,
        			editable:true,
        			eventLimit:true,
        			eventClick: function(calEvent, jsEvent, view) {
     				   var dt = calEvent.start;
     				  var start = $.fullCalendar.formatDate(calEvent._start, 'DD/MM/YYYY');
     				   console.log("EVENT DATE:"+start)
     				   console.log("Title"+calEvent.title )
     				    //alert('Event Clicked on : ' + dt);
     				    var r = confirm("Delete " + calEvent.title + "\n" + start);
     				    if (r === true) {
     				       $('#calendar').fullCalendar('removeEvents', calEvent._id);
     				      $.ajax({
     				           url : "CancelLeave",
     				           type : "POST",
     				          data : {
     	                           input : start,
     	                             },
     				           success : function(responseJson) {
     				              console.log(responseJson);
     				           },
     				          error: function(jqXHR, textStatus, errorThrown) {
     			                    alert(jqXHR+" - "+textStatus+" - "+errorThrown);
     			                   }
     				    });
     				}
        			},
        			select: function(start,end){
        				document.getElementById("submit").style.display="block";
        				$('#leavedate').val(moment(start).format("YYYY-MM-DD"));
        				console.log(moment(start).format("YYYY-MM-DD"));
        			}
        			
        		
        		});
                
               
                 
                 //$('textarea#output').attr('value',responseText);
         


	});
	
</script>
</head>
<body>
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
	</div>
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#"><svg class="glyph stroked home"><use xlink:href="#stroked-home"></use></svg></a></li>
				<li class="active">Leave Form</li>
			</ol>
		</div>
		
		
		
<input type="hidden" id="leavedate" value=""/>
<div id="submit" style="display:none">

<button style="background-color:#30a5ff;float:right;margin-left:50px;border-radius:5px;width:100px;height:30px">Cancel Leave</button>
</div>
<div id='calendar' style="margin-to:50px"></div>
</div>
</body>
</html>