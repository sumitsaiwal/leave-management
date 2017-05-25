package com.leave;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public Login() {
        super();
      
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		
		String id=request.getParameter("id");
		String pass2=request.getParameter("pass");
		String User=request.getParameter("useroptions");
		//out.println(User);
		//out.println(pass);

		if (User.contentEquals("employee")){
			
			try {
				
				Connection con=DBConnection.getConnection();
				Statement stm=con.createStatement();
				String query="select * from emp_register";
				ResultSet rs=((java.sql.Statement) stm).executeQuery(query);	
			
			while(rs.next())
			{
				//out.println(rs.getString(1));
				//out.println(rs.getString(4));

				String userid=rs.getString(1);
				String username=rs.getString(2);
				String pass3=rs.getString(4);

				if(id.equals(userid) &&  pass2.equals(pass3))
				{
					
					HttpSession session=request.getSession();
					session.setAttribute("name", id);
					session.setAttribute("username", username);
					out.println("Login Successful");
					response.sendRedirect("userwelcome.jsp");
	
				}
				
			}
			
				con.close();
				//out.println("Invalid Credentials");
				out.println("<script>alert('Enter The Correct Credentials')</script>");
				request.getRequestDispatcher("index.jsp").include(request,response);
				
			
		}
	
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		  }
		}
	
		else if (User.contentEquals("admin")){
			
			try {
				
				Connection con=DBConnection.getConnection();
				Statement stm=con.createStatement();
				String query="select * from admin";
				ResultSet rs=stm.executeQuery(query);

				while(rs.next())
				{
					//out.println(rs.getString(1));
					//out.println(rs.getString(2));

					String userid=rs.getString(1);
					String pass3=rs.getString(2);
					String username=rs.getString(3);

					if(id.equals(userid) &&  pass2.equals(pass3))
					{
						HttpSession session=request.getSession();
						session.setAttribute("name",id);
						session.setAttribute("username", username);
						out.println("Login Successful");
						response.sendRedirect("adminwelcome.jsp");

						
					}
					
				}
					con.close();
					//out.println("Invalid Credentials");
					out.println("<script>alert('Enter The Correct Credentials')</script>");
					request.getRequestDispatcher("index.jsp").include(request,response);
					
			}	
		
		  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		  }
		
		}
	}
}
