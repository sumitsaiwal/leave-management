package com.leave;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class DateDiff {
	
	static SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
	
	public static int test(String startdate, String enddate ) throws ParseException{
		Date date1 = myFormat.parse(startdate);
	    Date date2 = myFormat.parse(enddate);
	    long diff = date2.getTime() - date1.getTime();
		return (int) (TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS))+1;
		
	}
	public static void main(String[] args) throws ParseException {
		String startdate="13/04/2017";
		String enddate="12/04/2017";
		int i=test(startdate,enddate);
	    System.out.println(i);
	    
    }
}
