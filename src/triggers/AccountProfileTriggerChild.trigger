trigger AccountProfileTriggerChild on Account_Profile__c (after insert, after update, after delete, after undelete) {
  Map<Id,Account> parents = new Map<Id,Account>();
  if(Trigger.new<>null)
    for(Account_Profile__c c:Trigger.new)
      if(c.Account__c<>null)
        parents.put(c.Account__c,new Account(id=c.Account__c));
  if(Trigger.old<>null)
    for(Account_Profile__c c:Trigger.old)
      if(c.Account__c<>null)      
        parents.put(c.Account__c,new Account(id=c.Account__c));
  update parents.values();
}