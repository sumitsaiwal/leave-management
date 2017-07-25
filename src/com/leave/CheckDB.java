package com.leave;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CheckDB
 */
@WebServlet("/CheckDB")
public class CheckDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckDB() {
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
		Connection con=DBConnection.getConnection();
		Statement stm;
		try {
			stm = con.createStatement();
			String query="show tables";
			ResultSet rs=((java.sql.Statement) stm).executeQuery(query);
			request.setAttribute("successMsg","Successfully Connected");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			request.setAttribute("ErrorMsg", "Connection Failed");
			e.printStackTrace();
		} finally{
			try {
				con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				request.setAttribute("ErrorMsg", "Connection Failed");
				e.printStackTrace();
			}
		}
		request.getRequestDispatcher("importdb.jsp").forward(request,response);
		
	}

}
