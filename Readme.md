DB Server Parameters:

character_set_server: UTF8
time_zone: +05:30

Application Settings:

db_host="<DB_Server_name>.mysql.database.azure.com:3306"
db_name="leavedb"
db_user="dbuser@<DB_Server_name>.mysql.database.azure.com"
db_pass="passport@123"

-------------------------KUDU Console----------------------------

https://<App_Service_name>.scm.azurewebsites.net/

Install 'phpMyAdmin' from Kudu extensions for DBA.
https://<App_Service_name>.scm.azurewebsites.net/phpMyAdmin

-----------------------------------------------------------------
Trying to write logs into :${jvmrunargs:site.logdir}

Log file location: D:/home/LogFiles/

Log4J Configuration location: file:///D:/home/site/wwwroot/webapps/Leave Management/WEB-INF/classes/log4j2.xml

-----------------------------------------------------------------

Application Insights:

Application Insights SDK looks for the instrumentation key in this order:
System property: -DAPPLICATION_INSIGHTS_IKEY=your_ikey
Environment variable: APPLICATION_INSIGHTS_IKEY
Configuration file: ApplicationInsights.xml