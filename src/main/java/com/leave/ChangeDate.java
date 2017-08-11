package com.leave;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;


public class ChangeDate {
static SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
static SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
private static final Logger logger = LogManager.getLogger(ChangeDate.class.getName());
	
	public static String test(String date) throws ParseException{
		logger.info("Function: ChangeDate.test(): Used to parse the date from dd/MM/yyyy to yyyy-MM-dd");
		logger.trace("Function: ChangeDate.test(): date="+date);
		Date date1 = myFormat.parse(date);
		logger.trace("Date parsed : "+date+" to "+newFormat.format(date1));
		return newFormat.format(date1);
		
	}
	
	public static Date returnDate(String date) throws ParseException{
		Date date1 = myFormat.parse(date);
		return date1;
		
	}
	public static void main(String[] args) throws ParseException {
		String startdate="01/04/2017";
	    System.out.println(test(startdate));
	    
    }
}
