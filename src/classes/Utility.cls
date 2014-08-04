/**
 * Class Name: Utility
 * @author: Wilson Cheng
 * Date: 02/13/2013
 * Requirement/Project Name: DirecTV Dealer Management
 * @Description: Class that is used for all common methods that is used by multiple components.
 * History: 
 */
public with sharing class Utility
{
    /**
     * @description: This method returns the exact date base on the number business days 
     * @param: Integer - date origin, could be date today 
     * @param: Integer - number of business days you want to add
     * @return: DateTime - returns the datetime value base on the business days excluding weekends.
     */ 
    public static Datetime getBussinessDate(Datetime startDate, Integer iDays)
    {
         //Datetime endDate = startDate.addDays(iDays);
         //Integer iOffDays = addDaysOff(startDate,endDate);
         //return endDate.addDays(iOffDays);
         Integer countDayInt = 0;
         if (startDate.format('E') == 'Sat')
             startDate = startDate.addDays(-1);
         else if (startDate.format('E') == 'Sun')
             startDate = startDate.addDays(-2);
         
         while(countDayInt < iDays)
         {
            if ((startDate.format('E') == 'Mon') || (startDate.format('E') == 'Tue') || (startDate.format('E') == 'Wed') || (startDate.format('E') == 'Thu') || (startDate.format('E') == 'Fri'))
            {
                countDayInt = countDayInt + 1;
            }            
            startDate = startDate.addDays(1);  
         }
         
         if (startDate.format('E') == 'Sat')
             startDate = startDate.addDays(2);
         else if (startDate.format('E') == 'Sun')
             startDate = startDate.addDays(1);
         
         return startDate;
    }
    
    /**
     * @description: This method returns the number of days (Weekends) that needs to be added to the
     *               end date specified 
     * @param: Integer - start date 
     * @param: Integer - end date
     * @return: Integer - total of numbers that falls on weekends.
     */
    /*private static Integer addDaysOff(Datetime sdate, Datetime edate)
    {
        Integer countDayInt = 0;
        
        //This loop is used for adding saturday and sunday on top of the current start date
        while (sdate < edate) 
        {
            //determines if the current start date falls either on saturday or sunday
            if (sdate.format('E') == 'Sat' | sdate.format('E') == 'Sun')
            {
                countDayInt = countDayInt + 1;
            }
            //add 1 day to the start day to traverse all the days between the start and end date
            sdate = sdate.addDays(1);
        }
        
        return countDayInt;
        
    }*/
}