package com.leave;
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.SQLException;
	import java.util.Properties;
	
	import org.apache.logging.log4j.Logger;
	import org.apache.logging.log4j.LogManager;
	 
	public class DBConnection {
		private static final Logger logger = LogManager.getLogger(DBConnection.class.getName());
		
		/*static String host ="localhost:3306" ;
		static String database = "leavedb";
		static String user = "root";
		static String password = "admin@123";*/
		
		/*static String host ="leavedbserver.mysql.database.azure.com:3306" ;
		static String database = "leavedb";
		static String user = "dbuser@leavedbserver";
		static String password = "passport@123";*/
		
		static String host = System.getenv("db_host");
		static String database = System.getenv("db_name");
		static String user = System.getenv("db_user");
		static String password = System.getenv("db_pass");
		
	    public static Connection getConnection() {
	    	
	        /*Properties props = new Properties();
	        FileInputStream fis = null;*/
	        Connection con = null;
	        
	        try {

	            	
	            	/*//props.load(LeaveID.class.getResourceAsStream("/jdbc.properties"));
					fis = new FileInputStream("C:/Users/skumar81/Desktop/jdbc.properties");
					props.load(fis);
		            // load the Driver Class
					
		            Class.forName(props.getProperty("JDBC_DRIVER"));
		 
		            // create the connection now
		            con = DriverManager.getConnection(props.getProperty("JDBC_CONNECTION"),
		                    props.getProperty("JDBC_USER"),
		                    props.getProperty("JDBC_PASSWORD"));
		            		props.load(fis);*/
	        		logger.trace("---Trying to establish DB connection---");
	        		logger.trace("Host="+host+", DB="+database+", User="+user+", Password=******");
	        		String url = String.format("jdbc:mysql://%s/%s", host, database);

	        		// Set connection properties.
	        		Properties properties = new Properties();
	        		properties.setProperty("user", user);
	        		properties.setProperty("password", password);
	        		/*properties.setProperty("useSSL", "true");
	        		properties.setProperty("verifyServerCertificate", "true");
	        		properties.setProperty("requireSSL", "false");*/
    			
	        		Class.forName("com.mysql.jdbc.Driver");
	 
	        		// create the connection now
	        		con = DriverManager.getConnection(url, properties);
	        		logger.trace("DB Connection Established");
				} 
	            
	            catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
	            	logger.error(e);
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					logger.error(e);
					e.printStackTrace();
				}
	 
	        return con;
	    }
	    
	}
