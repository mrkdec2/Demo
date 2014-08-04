trigger LeadTrigger on Lead (before insert,before update){

    DMOperations leadProcess = new DMOperations();
    
    
    if(trigger.isinsert)
    {
        leadProcess.leadBeforeInsert(Trigger.new);
    }
    
    if(checkRecursive.runOnce())
    {
        if(trigger.isupdate)
        {
             for(Lead newLeads: Trigger.New)
             {
                 if((Trigger.oldmap.get(newLeads.Id).OwnerId != newLeads.OwnerId) && (newLeads.Owner.Name == NULL))
                 {
                     newLeads.FirstName = '';
                 }
             }   
            
        }
    }
}