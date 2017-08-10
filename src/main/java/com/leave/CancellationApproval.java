package com.leave;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Servlet implementation class CancellationApproval
 */
@WebServlet("/CancellationApproval")
public class CancellationApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancellationApproval() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		final Logger logger = LogManager.getLogger(CancellationApproval.class.getName());
		HttpSession sessionName=request.getSession();
		if(sessionName.getAttribute("name")==null){
			response.sendRedirect("index.jsp");
		}
		
		String lid=request.getParameter("lid");
		String emp_id=request.getParameter("emp_id");
		String status=request.getParameter("status");
		String leavetype=request.getParameter("leave_type");
		String startdate=request.getParameter("start_date");
		String enddate=request.getParameter("end_date");
		//System.out.println("input= "+lid);
		//System.out.println("input= "+emp_id);
		//System.out.println("input= "+status);
		
		String userid=(String)sessionName.getAttribute("name");
		
		
		if (status.contentEquals("CancelApproved")){
			logger.info("If statement: status=CancelApproved, leaveid="+lid);
			Connection con=DBConnection.getConnection();
			try {
				//System.out.println("Entered in CancelApproved loop");
				int days=DateDiff.test(startdate, enddate);
				//Connection con=DBConnection.getConnection();
				
				Statement stm=con.createStatement();
				PreparedStatement p1=con.prepareStatement("update emp_leave set status=? where leave_id=?");
				p1.setString(1,status);
				p1.setString(2, lid);
				p1.executeUpdate();
				logger.trace("Updated status of leave "+lid+" as CancelApproved for user "+userid);
				
				if (leavetype.contentEquals("Planned Leave")){
					logger.info("If statement: leavetype=Planned Leave, leaveid="+lid);
					//System.out.println("If its Planned Leave");
					PreparedStatement p2=con.prepareStatement("select planned_leave from emp_register where EmpID=?");
					p2.setString(1, userid);
					ResultSet rs=p2.executeQuery();
					if(rs.first()){
						int leave_left=rs.getInt(1);
						PreparedStatement p3=con.prepareStatement("update emp_register set planned_leave=? where EmpID=?");
			    		
			    		p3.setInt(1,(leave_left+days));
			    		p3.setString(2, userid);
			    		p3.executeUpdate();
			    		logger.trace("Updated the no of planned_leave for user="+userid+", leaveid="+lid);
			    		//System.out.println("Approved and updated Planned Leave");
			    		request.setAttribute("successMsg","Successfully Approved the cancellation of the Leave");
			    		//request.getRequestDispatcher("CancellationApproval.jsp").forward(request,response);
					}
				}
				else if(leavetype.contentEquals("Sick/Casual leave")){
					logger.info("else if statement: leavetype=Sick/Casual leave, leaveid="+lid);
					//System.out.println("If its Sick/Casual Leave");
					PreparedStatement p4=con.prepareStatement("select sick_cas_leave from emp_register where EmpID=?");
					p4.setString(1, userid);
					ResultSet rs=p4.executeQuery();
					if(rs.first()){
						int leave_left=rs.getInt(1);
						PreparedStatement p5=con.prepareStatement("update emp_register set sick_cas_leave=? where EmpID=?");
			    		
			    		p5.setInt(1,(leave_left+days));
			    		p5.setString(2, userid);
			    		p5.executeUpdate();
			    		//System.out.println("Approved and updated Sick/Casual Leave");
			    		logger.trace("Updated the no of sick/casual leave for user "+userid+", leaveid="+lid);
			    		request.setAttribute("successMsg","Successfully Approved the cancellation of the Leave");
			    		//request.getRequestDispatcher("CancellationApproval.jsp").forward(request,response);
					}
				}
				//con.close();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				logger.error(e);
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error(e);
				e.printStackTrace();
			}finally{
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
		
		else if (status.contentEquals("CancelRejected")){
			logger.info("else if statement: status=CancelRejected, leaveid="+lid);
			Connection con=DBConnection.getConnection();
			try {
				//System.out.println("Entered in CancelRejected Leave loop");
				//Connection con=DBConnection.getConnection();
				Statement stm=con.createStatement();
				PreparedStatement p6=con.prepareStatement("update emp_leave set status=? where leave_id=?");
				p6.setString(1,status);
				p6.setString(2, lid);
				p6.executeUpdate();
				//con.close();
				//System.out.println("Leave status is Rejected");
				logger.trace("Updated status of leave "+lid+" as CancelRejected for user "+userid);
				request.setAttribute("successMsg","Successfully Rejected the cancellation of the Leave");
	    		//request.getRequestDispatcher("CancellationApproval.jsp").forward(request,response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
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
		
		request.getRequestDispatcher("CancellationApproval.jsp").forward(request,response);
	}

}
