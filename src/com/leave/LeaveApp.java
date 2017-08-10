package com.leave;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.joda.time.DateTime;

import com.leave.DBConnection;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/leaveApp")
public class LeaveApp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LeaveApp() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		final Logger logger = LogManager.getLogger(LeaveApp.class.getName());
		PrintWriter out=response.getWriter();
		//out.println("ttesting123..");
		response.setContentType("text/html");
		
		int flag=0;
		//getting the parameters
		String leave_id=LeaveID.next();
		String leave_type=request.getParameter("leavetype");
		String startdate=request.getParameter("startdate");
		String enddate=request.getParameter("enddate");
		String comment=request.getParameter("comment");
		String status=request.getParameter("status");
		
		HttpSession session=request.getSession();
        String userid=(String) session.getAttribute("name");
        
        
        //Date Validation
        
		try {
			logger.info("Date Validation: user= "+userid+", startdate= "+startdate+", enddate= "+enddate);
    		String currDate = GetCurrentDateTime.test();
    		/*int currDays=DateDiff.test(currDate, startdate);
    		out.println(currDays);*/
			DateTime start = DateTime.parse(ChangeDate.test(startdate));
	        DateTime end = DateTime.parse(ChangeDate.test(enddate));
			List<DateTime> between = AllDates.getDateRange(start, end);
			Connection con=DBConnection.getConnection();
			Statement stm=con.createStatement();
			String qquery="select startdate,enddate from emp_leave where EmpID=? and enddate >= ? and status in ('Pending','Approved','CancelPending','CancelRejected')";
			PreparedStatement p=con.prepareStatement(qquery);
			p.setString(1, userid);
			p.setString(2, currDate);
			ResultSet rs=p.executeQuery();
			logger.trace("Feteched all the applied leave: user= "+userid);
			while(rs.next())
			{
				DateTime a = DateTime.parse(ChangeDate.test(rs.getString(1)));
		        DateTime b = DateTime.parse(ChangeDate.test(rs.getString(2)));
				
		        for (DateTime d : between) {
		            ////System.out.println(" " + d);
		        	if(a.compareTo(d) * d.compareTo(b) >= 0){
		        		flag=1;
		        	}
		        }
			}
			con.close();
			if(flag==1){
				logger.trace("Leave already present in DB for : user= "+userid+", startdate= "+startdate+", enddate= "+enddate);
				/*out.println("<script>alert('Sorry you have already applied for these dates.')</script>");*/
				request.setAttribute("errorMsg","Sorry you have already applied for these dates.");
				//request.getRequestDispatcher("newleave.jsp").forward(request,response);
				}
			else if(flag==0){logger.trace("No leave found in DB for : user= "+userid+", startdate= "+startdate+", enddate= "+enddate);}
			
		} catch (ParseException | SQLException e1) {
			// TODO Auto-generated catch block
			logger.error(e1);
			e1.printStackTrace();
		}
        
        //Date Validation
        
		if(leave_type.contentEquals("Planned Leave") && flag==0){
			logger.info("If statement: leave_type=Planned Leave, leaveid="+leave_id+", startdate= "+startdate+", enddate= "+enddate);
			Connection con=DBConnection.getConnection();
        	try {
        		int days=DateDiff.test(startdate, enddate);
        		//Connection con=DBConnection.getConnection();
				Statement stm=con.createStatement();
				String qquery="select planned_leave from emp_register where EmpID=?";
				PreparedStatement p=con.prepareStatement(qquery);
				p.setString(1, userid);
				ResultSet rs=p.executeQuery();
				if(rs.first()){
					
					int leave_left=rs.getInt(1);
					logger.trace("leave_type=Planned Leave, user= "+userid+", leave_left "+leave_left);
					if (days <=leave_left && days>0){
						logger.trace("If statement: No of leave days are lesser than the leave_left");
						String query="insert into emp_leave values (?,?,?,?,?,?,?,?)";
			    		p=con.prepareStatement(query);
			    		p.setString(1, leave_id);
			    		p.setString(2, leave_type);
			    		p.setString(3, startdate);
			    		p.setString(4, enddate);
			    		p.setString(5, status);
			    		p.setString(6, userid);
			    		p.setString(7, comment);
			    		p.setInt(8, days);
			    		p.executeUpdate();
			    		logger.trace("Leave status updated to "+status+" leaveid= "+leave_id);
			    		PreparedStatement ps=con.prepareStatement("update emp_register set planned_leave=? where EmpID=?");
			    		
			    		ps.setInt(1,(leave_left-days));
			    		ps.setString(2, userid);
			    		ps.executeUpdate();
			    		logger.trace("leave_left updated for user "+userid);
			    		con.close();
			    		logger.trace("DB Connection closed");
			    		/*out.println("<script>alert('Successfully Applied for Leave'</script>");
			    		response.sendRedirect("userwelcome.jsp");*/
			    		request.setAttribute("successMsg","Successfully Applied for Leave");
			    		//request.getRequestDispatcher("newleave.jsp").forward(request,response);
			    		
						
					}
					else if (days>leave_left) {
						//con.close();
						logger.trace("else If statement: No of leave days are greater than the leave_left: No operation");
						/*out.println("<script>alert('Sorry you don't have enough leave balance')</script>");*/
						request.setAttribute("errorMsg","Sorry you don't have enough leave balance");
						//request.getRequestDispatcher("newleave.jsp").forward(request,response);
						}
					else {
						//con.close();
						logger.trace("else statement: No operation: Insufficient Details provided");
						/*out.println("<script>alert('Please enter the correct details')</script>");*/
						request.setAttribute("errorMsg","Please enter the correct details");
						//request.getRequestDispatcher("newleave.jsp").forward(request,response);
						}
				}
				
			} catch (SQLException | ParseException e) {
				// TODO Auto-generated catch block
				logger.error(e);
				e.printStackTrace();
			}finally {
				try {
					con.close();
					logger.trace("DB Connection closed");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					logger.error(e);
					e.printStackTrace();
				}
			}
    		
		}
    	
		else if(leave_type.contentEquals("Sick/Casual leave")  && flag==0){
			logger.info("else If statement: leave_type=Sick/Casual leave, leaveid="+leave_id+", startdate= "+startdate+", enddate= "+enddate);
			Connection con=DBConnection.getConnection();
        	try {
        		
        		int days=DateDiff.test(startdate, enddate);
        		//Connection con=DBConnection.getConnection();
				Statement stm=con.createStatement();
				String qquery="select sick_cas_leave from emp_register where EmpID=?";
				PreparedStatement p=con.prepareStatement(qquery);
				p.setString(1, userid);
				ResultSet rs=p.executeQuery();
				if(rs.first()){ 
					
					int leave_left=rs.getInt(1);
					logger.trace("leave_type=Sick/Casual leave, user= "+userid+", leave_left "+leave_left);
					if (days<=leave_left && days>0){
						String query="insert into emp_leave values (?,?,?,?,?,?,?,?)";
			    		p=con.prepareStatement(query);
			    		p.setString(1, leave_id);
			    		p.setString(2, leave_type);
			    		p.setString(3, startdate);
			    		p.setString(4, enddate);
			    		p.setString(5, status);
			    		p.setString(6, userid);
			    		p.setString(7, comment);
			    		p.setInt(8, days);
			    		p.executeUpdate();
			    		logger.trace("Leave status updated to "+status+" leaveid= "+leave_id);
			    		PreparedStatement ps=con.prepareStatement("update emp_register set sick_cas_leave=? where EmpID=?");
			    		
			    		ps.setInt(1,(leave_left-days));
			    		ps.setString(2, userid);
			    		ps.executeUpdate();
			    		logger.trace("leave_left updated for user "+userid);
			    		//con.close();
			    		/*out.println("<script>alert('Successfully Applied for Leave'</script>");
			    		response.sendRedirect("userwelcome.jsp");*/
			    		request.setAttribute("successMsg","Successfully Applied for Leave");
			    		//request.getRequestDispatcher("newleave.jsp").forward(request,response);
						
					}
					else if (days>leave_left) {
						//con.close();
						logger.trace("else If statement: No of leave days are greater than the leave_left: No operation");
						/*out.println("<script>alert('Sorry you don't have enough leave balance')</script>");
						request.getRequestDispatcher("newleave.jsp").include(request,response);*/
						request.setAttribute("errorMsg","Sorry you don't have enough leave balance");
						//request.getRequestDispatcher("newleave.jsp").forward(request,response);
						}
					
					else {
						//con.close();
						logger.trace("else statement: No operation: Insufficient Details provided");
						/*out.println("<script>alert('Please enter the correct details')</script>");
						request.getRequestDispatcher("newleave.jsp").include(request,response);*/
						request.setAttribute("errorMsg","Please enter the correct details");
						//request.getRequestDispatcher("newleave.jsp").forward(request,response);
						}
				}
				
			} catch (SQLException | ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				logger.error(e);
			}finally {
				try {
					con.close();
					logger.trace("DB Connection closed");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					logger.error(e);
					e.printStackTrace();
				}
				
			}
    		
		}
		request.getRequestDispatcher("newleave.jsp").forward(request,response);
	}

}
