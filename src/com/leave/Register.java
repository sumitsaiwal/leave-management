package com.leave;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		final Logger logger = LogManager.getLogger(Approval.class.getName());
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		//getting the values from the form to the jsp
		String empid=request.getParameter("id");
		String empname=request.getParameter("name");
		String email=request.getParameter("email");
		String pass=request.getParameter("pass");
		
		
        	try {
        		logger.info("User Registration Intialization: User_id= "+empid);
        		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        		String dateInString = GetCurrentDateTime.test();
        		Date date = formatter.parse(dateInString);
        		//String currDate = formatter.format(date);
        		java.sql.Date sqldate = new java.sql.Date(date.getTime());
        		Connection con=DBConnection.getConnection();
        		
        		String query="insert into emp_register values (?,?,?,?,?,?,?)";
        		PreparedStatement p=con.prepareStatement(query);
        		
        		p.setString(1,empid);
        		p.setString(2,empname);
        		p.setString(3,email);
        		p.setString(4,pass);
        		p.setDate(5, sqldate);
        		p.setInt(6, 12);
        		p.setInt(7, 15);
        		p.executeUpdate();
        		logger.trace("User Registration Successful: User_id= "+empid);
        		con.close();
        		logger.trace("DB Connection closed");
        		request.setAttribute("successMsg","Successfully Registered, LOGIN!!");
	    		request.getRequestDispatcher("index.jsp").forward(request,response);
				
					
			} 
        	
        	catch (SQLException e) {
        		request.setAttribute("errorMsg","Registeration Failed!!");
        		request.getRequestDispatcher("register.jsp").forward(request,response);
        		logger.error("Registeration Failed!!\n"+e);
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				logger.error(e);
				e.printStackTrace();
			}
		  
	}

}
