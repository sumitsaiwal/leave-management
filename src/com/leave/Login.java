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

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public Login() {
        super();
      
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		final Logger logger = LogManager.getLogger(Login.class.getName());
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		
		String id=request.getParameter("id");
		String pass2=request.getParameter("pass");
		String User=request.getParameter("useroptions");
		//out.println(User);
		//out.println(pass);
		int flag=0;
		
		if (User.contentEquals("employee")){
			logger.info("If statement: User=employee");
			Connection con=DBConnection.getConnection();
			try {
				
				//Connection con=DBConnection.getConnection();
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
					flag=1;
					HttpSession session=request.getSession();
					session.setAttribute("name", id);
					session.setAttribute("username", username);
					/*response.sendRedirect("userwelcome.jsp");*/
					logger.trace("Login successful for user= "+id);
					request.getRequestDispatcher("userwelcome.jsp").forward(request,response);
					break;
	
				}
				
			}
				if (flag==0){
				logger.trace("Login failed for entered user= "+id);
				//con.close();
				//logger.trace("DB Connection closed");
				//out.println("Invalid Credentials");
				/*out.println("<script>alert('Enter The Correct Credentials')</script>");*/
				request.setAttribute("ErrorMsg", "Enter The Correct Credentials");
				request.getRequestDispatcher("index.jsp").forward(request,response);}
				
			
		}
	
		catch (SQLException e) {
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
	
		else if (User.contentEquals("admin")){
			logger.info("If statement: User=admin");
			Connection con=DBConnection.getConnection();
			try {
				
				//Connection con=DBConnection.getConnection();
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
						flag=1;
						HttpSession session=request.getSession();
						session.setAttribute("name",id);
						session.setAttribute("username", username);
						logger.trace("Login successful for admin= "+id);
						//out.println("Login Successful");
						request.getRequestDispatcher("adminwelcome.jsp").forward(request,response);
						//response.sendRedirect("adminwelcome.jsp");
						break;

						
					}
					
				}	
					if (flag==0){
					logger.trace("Login failed for entered admin= "+id);
					//con.close();
					//out.println("Invalid Credentials");
					/*out.println("<script>alert('Enter The Correct Credentials')</script>");*/
					request.setAttribute("ErrorMsg", "Enter The Correct Credentials");
					request.getRequestDispatcher("index.jsp").forward(request,response);}
					
			}	
		
		  catch (SQLException e) {
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
		//request.getRequestDispatcher("index.jsp").forward(request,response);
	}
}