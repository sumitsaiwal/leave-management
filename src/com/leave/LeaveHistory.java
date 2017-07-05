package com.leave;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;


/**
 * Servlet implementation class DateClient
 */
@WebServlet("/DateClient")
public class LeaveHistory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LeaveHistory() {
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
		
/*		String leaveType=null;
		String startDate=null;
	    String endDate=null;*/
	    ArrayList<String> leaveType=new ArrayList<>();
	    ArrayList<String> startDate=new ArrayList<>();
	    ArrayList<String> endDate=new ArrayList<>();
		HttpSession sessionName=request.getSession();
		if(sessionName.getAttribute("name")==null){
			response.sendRedirect("index.jsp");
		}
		/*String input=request.getParameter("input");
		System.out.println("input= "+input);
		System.out.println("input1= "+request.getParameter("input"));*/
		 try {
		String userid=(String)sessionName.getAttribute("name");
		Connection con=DBConnection.getConnection();
        PreparedStatement prepStmt=con.prepareStatement("select * from emp_leave where EmpId=? AND status='Pending' OR status='CancelPending' OR status='Approved'");
        prepStmt.setString(1, userid);
        ResultSet rs=prepStmt.executeQuery();
        while (rs.next()){
        	leaveType.add(rs.getString("leavetype"));
        	startDate.add(rs.getString("startdate"));
        	endDate.add(rs.getString("enddate"));
        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 JSONObject json = new JSONObject();
		    try {
		    	System.out.println("leaveType= "+leaveType);
		    	System.out.println("startDate= "+startDate);
		    	System.out.println("endDate= "+endDate);
				json.put("leaveType", leaveType);
			    json.put("startDate", startDate);
			    json.put("endDate", endDate);
			    response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json.toString());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		
		
	}

}
