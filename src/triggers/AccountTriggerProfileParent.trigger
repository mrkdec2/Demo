trigger AccountTriggerProfileParent on Account (before insert, before update) {
  for(Account p:Trigger.new)
    p.AccountProfileCounter__c = 0;
  for(Account_Profile__c c:[select id,Account__c from Account_Profile__c where Account__c in :Trigger.new])
    Trigger.newMap.get(c.Account__c).AccountProfileCounter__c++;
}