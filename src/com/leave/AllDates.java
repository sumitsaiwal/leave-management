package com.leave;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.joda.time.DateTime;


public class AllDates {

    public static List<DateTime> getDateRange(DateTime start, DateTime end) {

        List<DateTime> ret = new ArrayList<DateTime>();
        DateTime tmp = start;
        while(tmp.isBefore(end) || tmp.equals(end)) {
            ret.add(tmp);
            tmp = tmp.plusDays(1);
        }
        return ret;
    }

    public static void main(String[] args) throws ParseException {
    	String startdate="14/04/2017";
    	String enddate="15/04/2017";
		//String currDate = GetCurrentDateTime.test();
    	String currDate = "14/04/2017";
    	System.out.println(currDate);
		int currDays=DateDiff.test(currDate, startdate);
		System.out.println(currDays);
		int flag=0;
		DateTime start = DateTime.parse(ChangeDate.test(startdate));
        DateTime end = DateTime.parse(ChangeDate.test(enddate));
		List<DateTime> between = AllDates.getDateRange(start, end);
		if(currDays>0){
			
				DateTime a = DateTime.parse(ChangeDate.test("16/04/2017"));
		        DateTime b = DateTime.parse(ChangeDate.test("19/04/2017"));
				
		        for (DateTime d : between) {
		        	if(a.compareTo(d) * d.compareTo(b) >= 0){
		        		flag=1;
		        		//System.out.println(" " + d);
		        	}
		        }
			}
		if(flag==1){
			System.out.println("Sorry you have already applied for these dates.");
			
			}
		else if (currDays<=0) {
			
			System.out.println("Please choose start date as todays or later");
		}
		/*
        DateTime start = DateTime.parse("2017-04-12");
        //System.out.println("Start: " + start);

        DateTime end = DateTime.parse("2017-04-18");
        //System.out.println("End: " + end);
        
        DateTime a = DateTime.parse("2017-04-10");
        DateTime b = DateTime.parse("2017-04-15");
        
        List<DateTime> between = getDateRange(start, end);
        for (DateTime d : between) {
            //System.out.println(" " + d);
        	if(a.compareTo(d) * d.compareTo(b) >= 0){
        		System.out.println("Already Applied for leave on this date" + d);
        	}
        }
        
        /*SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
        String startdate="01/04/2017";
        String enddate="13/04/2017";
        String midledate="14/04/2017";
        Date date1 = myFormat.parse(startdate);
        Date a=myFormat.parse(startdate), b=myFormat.parse(enddate);   // assume these are set to something
        Date d=myFormat.parse(midledate);      // the date in question

       	System.out.println(a.compareTo(d) * d.compareTo(b) >= 0); */
    }
}