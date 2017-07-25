package com.leave;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class ImportDB
 */
@WebServlet("/ImportDB")
@MultipartConfig
public class ImportDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImportDB() {
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
		try {
			Part s_file=request.getPart("file");
			File uploads = new File(System.getProperty("user.dir")+"/script.sql");
			//File d_file = new File(uploads, "script.sql");

			try (InputStream input = s_file.getInputStream()) {
			    Files.copy(input, uploads.toPath(),StandardCopyOption.REPLACE_EXISTING);
			    request.setAttribute("successMsg","Uploaded Successfully");
			}
			
			ScriptRunner runner = new ScriptRunner(con, false, false);
			//String file = "/script.sql";
			runner.runScript(new BufferedReader(new FileReader(uploads)));
			request.setAttribute("successMsg1","Imported Successfully");
		}  catch (Exception e) {
			request.setAttribute("ErrorMsg", "Import Failed");
		    System.err.println("Unable to connect to server: " + e);
		}finally{
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}}
		request.getRequestDispatcher("importdb.jsp").forward(request,response);
	}

}
