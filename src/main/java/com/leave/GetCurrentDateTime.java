package com.leave;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class GetCurrentDateTime {
	private static final Logger logger = LogManager.getLogger(GetCurrentDateTime.class.getName());
    private static final DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    private static final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
    
    public static String test(){
    	logger.info("Function: GetCurrentDateTime.test(): Used to return the current date in dd/MM/yyyy format");
    	LocalDate localDate = LocalDate.now();
    	logger.trace("Curret date returned "+DateTimeFormatter.ofPattern("dd/MM/yyyy").format(localDate));
		return (DateTimeFormatter.ofPattern("dd/MM/yyyy").format(localDate));
    	
    }

    public static void main(String[] args) {

        Date date = new Date();
        System.out.println(sdf.format(date));

        Calendar cal = Calendar.getInstance();
        System.out.println(sdf.format(cal.getTime()));

        LocalDateTime now = LocalDateTime.now();
        System.out.println(dtf.format(now));

        LocalDate localDate = LocalDate.now();
        System.out.println(DateTimeFormatter.ofPattern("dd/MM/yyyy").format(localDate));

    }

}