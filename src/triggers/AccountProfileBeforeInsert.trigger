trigger AccountProfileBeforeInsert on Account_Profile__c (Before Insert) {  
   Map<Id,String> accountProfileMap = new Map<Id,String>();
   Set<Id> apId = new Set<Id>();
       for(Account_Profile__c newAP: trigger.new){
       apId.add(newAP.Account__c);
       }
   List<Account> accountList = [Select Name from Account where Id in: apId];
       for(Account newAccount: accountList){
       accountProfileMap.put(newAccount.Id,newAccount.Name);
       }
           for(Account_Profile__c newAP: trigger.new){
           newAP.Name = accountProfileMap.get(newAP.Account__c) + ' Account Profile';
           }
}