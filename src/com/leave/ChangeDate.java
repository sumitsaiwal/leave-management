package com.leave;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class ChangeDate {
static SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
static SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	public static String test(String date) throws ParseException{
		Date date1 = myFormat.parse(date);
	    
		return newFormat.format(date1);
		
	}
	public static void main(String[] args) throws ParseException {
		String startdate="01/04/2017";
	    System.out.println(test(startdate));
	    
    }
}
