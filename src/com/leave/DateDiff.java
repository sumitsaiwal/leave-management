package com.leave;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class DateDiff {
	private static final Logger logger = LogManager.getLogger(DateDiff.class.getName());
	static SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
	
	public static int test(String startdate, String enddate ) throws ParseException{
		logger.info("Function: DateDiff.test(): Used to get no of days between \'startdate\' to \'startdate\'");
    	logger.trace("Function: DateDiff.test(): startdate="+startdate+", enddate="+enddate);
		Date date1 = myFormat.parse(startdate);
	    Date date2 = myFormat.parse(enddate);
	    long diff = date2.getTime() - date1.getTime();
	    logger.trace("No of days returned between "+startdate+" and "+enddate+" = "+(int)(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS))+1);
		return (int) (TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS))+1;
		
	}
	public static void main(String[] args) throws ParseException {
		String startdate="13/04/2017";
		String enddate="12/04/2017";
		int i=test(startdate,enddate);
	    System.out.println(i);
	    
    }
}
