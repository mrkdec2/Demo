trigger TaskBeforeInsert on Task (before insert, before update) {

    Set<Id> parentIds = new Set<Id>();
    
    for(Task newTask: trigger.new)
    {
        parentIds.add(newTask.WhatId);    
    }
   // Get a map of all Parents with field information
    Map<Id, Account> parentsById = new Map<Id, Account>();
    parentsById.putAll([SELECT Id, Parent_Id__c FROM Account WHERE Id IN :parentIds]);
    Set<Id> grandParentIds = new Set<Id>();
    
    for(Task newTask: trigger.new)
    {
        newTask.Account_Id__c = parentsById.get(newTask.WhatId).Parent_Id__c;
        grandParentIds.add(parentsById.get(newTask.WhatId).Parent_Id__c);
    }
    
    Account accountRec =  [SELECT Id, Name FROM Account where ID IN :grandParentIds limit 1];
    for(Task newTask: trigger.new)
    {
        newTask.Account_Name__c = accountRec.Name;
    }
}