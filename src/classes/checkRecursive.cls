public Class checkRecursive{
    private static boolean run = true;
    
    public static boolean runOnce(){
    if(run){
     run=false;
     return true;
    }else{
        return run;
    }
    }
    
    public boolean checkIfNotAccept(List<Lead> newLeads)
    {
        Boolean exist = false;
        for(Lead newLead: newLeads)
        {
            String textArea = newLead.User_Id_Checker__c;
            if(!(String.isEmpty(textArea)))
            {
                if((textArea).contains(String.valueOf(newLead.OwnerId)))
                {
                    exist = true;
                }
                else
                {
                    exist = false;
                }
            }
            
        }
        return exist;
    }
}