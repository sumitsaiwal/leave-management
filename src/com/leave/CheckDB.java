package com.leave;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

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
		final Logger logger = LogManager.getLogger(CheckDB.class.getName());
		logger.info("---DB Connection test---");
		Connection con=DBConnection.getConnection();
		Statement stm;
		try {
			
			stm = con.createStatement();
			String query="show tables";
			ResultSet rs=((java.sql.Statement) stm).executeQuery(query);
			logger.trace("DB Connection test successfully passed");
			request.setAttribute("successMsg","Successfully Connected");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("DB Connection test failed\n"+e);
			request.setAttribute("ErrorMsg", "Connection Failed");
			e.printStackTrace();
		} finally{
			try {
				con.close();
				logger.trace("DB Connection closed");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				logger.error(e);
				request.setAttribute("ErrorMsg", "Connection Failed");
				e.printStackTrace();
			}
		}
		request.getRequestDispatcher("importdb.jsp").forward(request,response);
		
	}

}
