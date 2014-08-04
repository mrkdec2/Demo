global class myClass 
{ 
  webService static boolean validateLead(String leadId, String userId) 
  {
        boolean c = true;
        Lead lInfo = [select User_Id_Checker__c from Lead where Id =:leadId];
        String textArea = lInfo.User_Id_Checker__c;
        if(!(String.isEmpty(textArea)))
        {
            if(textArea.contains(String.valueOf(userId)))
            {
            c = false;
            }
        }
        return c; 
  }
}