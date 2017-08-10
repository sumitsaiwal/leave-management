package com.leave;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Logout() {
        super();
  
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		final Logger logger = LogManager.getLogger(Logout.class.getName());
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html"); 
		HttpSession session=request.getSession(true); 
		String user_id=(String) session.getAttribute("name");
		session.invalidate(); 
		logger.trace("Successfully logged out for user_id= "+user_id);
		request.getRequestDispatcher("index.jsp").forward(request, response); 

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			
	}

}
