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
		
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		//getting the values from the form to the jsp
		String empid=request.getParameter("id");
		String empname=request.getParameter("name");
		String email=request.getParameter("email");
		String pass=request.getParameter("pass");
		
		
        	try {
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
        		
        		con.close();
        		
				out.println("<script>alert('Successfully Registered !!!')</script>");
				response.sendRedirect("index.jsp");
					
			} 
        	
        	catch (SQLException e) {
        		out.println("<script>alert('Registeration Failed!!')</script>");
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		  
	}

}
