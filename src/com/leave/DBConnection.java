	package com.leave;
	import java.io.FileInputStream;
	import java.io.FileNotFoundException;
	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.SQLException;
	import java.util.Properties;
	 
	public class DBConnection {
	 
	    public static Connection getConnection() {
	        Properties props = new Properties();
	        FileInputStream fis = null;
	        Connection con = null;
	        
	            try {
	            	//props.load(LeaveID.class.getResourceAsStream("/jdbc.properties"));
					fis = new FileInputStream("C:/Users/skumar81/Desktop/jdbc.properties");
					props.load(fis);
		            // load the Driver Class
					
		            Class.forName(props.getProperty("JDBC_DRIVER"));
		 
		            // create the connection now
		            con = DriverManager.getConnection(props.getProperty("JDBC_CONNECTION"),
		                    props.getProperty("JDBC_USER"),
		                    props.getProperty("JDBC_PASSWORD"));
		            		props.load(fis);
				} 
	            
	            catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            
	 
	        return con;
	    }
	    
	}


