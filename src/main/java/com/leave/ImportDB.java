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


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
		final Logger logger = LogManager.getLogger(ImportDB.class.getName());
		Connection con=DBConnection.getConnection();
		
		try {
			Part s_file=request.getPart("file");
			File uploads = new File(System.getProperty("user.dir")+"/script.sql");
			logger.trace("FIle Upload Intialization, File Path: "+System.getProperty("user.dir")+"/script.sql");
			//File d_file = new File(uploads, "script.sql");

			try (InputStream input = s_file.getInputStream()) {
			    Files.copy(input, uploads.toPath(),StandardCopyOption.REPLACE_EXISTING);
			    request.setAttribute("successMsg","Uploaded Successfully");
			    logger.trace("Upload Successful");
			    //System.out.println(uploads.getAbsolutePath());
			}
			
			ScriptRunner runner = new ScriptRunner(con, false, false);
			logger.trace("DB import intialised");
			//String file = "/script.sql";
			runner.runScript(new BufferedReader(new FileReader(uploads)));
			request.setAttribute("successMsg1","Imported Successfully");
			logger.trace("DB import Successful");
		}  catch (Exception e) {
			logger.error("Import Failed "+e);
			request.setAttribute("ErrorMsg", "Import Failed");
		    //System.err.println("Unable to connect to server: " + e);
		}finally{
			try {
				con.close();
				logger.trace("DB Connection Closed");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error(e);
				e.printStackTrace();
			}}
		request.getRequestDispatcher("importdb.jsp").forward(request,response);
	}

}
