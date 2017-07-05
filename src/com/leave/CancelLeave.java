package com.leave;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CancelLeave
 */
@WebServlet("/CancelLeave")
public class CancelLeave extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancelLeave() {
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
		HttpSession sessionName=request.getSession();
		if(sessionName.getAttribute("name")==null){
			response.sendRedirect("index.jsp");
		}
		String input=request.getParameter("input");
		System.out.println("input= "+input);
		String userid=(String)sessionName.getAttribute("name");
		Connection con=DBConnection.getConnection();
		PreparedStatement prepStmt1;
		PreparedStatement prepStmt2;
		try {
			prepStmt1 = con.prepareStatement("update emp_leave set status='CancelPending' where startdate=? and status='Approved'");
			prepStmt2 = con.prepareStatement("update emp_leave set status='Canceled' where startdate=? and status='Pending'");
		
		prepStmt1.setString(1, input);
		prepStmt2.setString(1, input);
		prepStmt1.execute();
		prepStmt1.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*doGet(request, response);*/
	}

}
