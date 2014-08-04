public class DMOperations{
    public DMOperations(){
    }
    
    public List<Lead> leadBeforeInsert(List<Lead> newLeads){
        User uInfo = [select Dealer_Name__c, Dealer_Number__c, Contact.AccountId, Contact.Account.AccountNumber, Contact.Account.IsPartner from User where Id =: UserInfo.getuserId()];
        
        if(uInfo.Contact.Account.IsPartner == true){
        for(Lead newLead: newLeads){
            newLead.Dealer_Name__c = uInfo.Contact.AccountId;
            newLead.Dealer_Number__c = uInfo.Contact.Account.AccountNumber;
        }
        }
    return newLeads;
    }
    
    public List<Lead> leadBeforeUpdate(List<Lead> newLeads){
        User uInfo = [select Dealer_Name__c, Dealer_Number__c, Contact.AccountId, Contact.Account.AccountNumber, Contact.Account.IsPartner from User where Id =: UserInfo.getuserId()];
        
        if(uInfo.Contact.Account.IsPartner == true){
        for(Lead newLead: newLeads){
            newLead.Dealer_Name__c = uInfo.Contact.AccountId;
            newLead.Dealer_Number__c = uInfo.Contact.Account.AccountNumber;
            newLead.Assignment_Date__c = system.now();
            newLead.Dealer_Agency__c = UserInfo.getuserId();
            newLead.User_Id_Checker__c = newLead.User_Id_Checker__c + ';' + UserInfo.getuserId();
        }
        }
    return newLeads;
    }
    
    public List<Lead> leadBeforeUpdateNotAccept(List<Lead> newLeads){
        Set<Id> ownerIdSet = new Set<Id>();
        for(Lead newLead: newLeads)
        {
            ownerIdSet.add(newLead.OwnerId);
        }
        
        List<User> uinfo = [select Contact.AccountId, Contact.Account.IsPartner from User where Id in:ownerIdSet];
        for(User newUser: uinfo)
        {
            if(newUser.Contact.Account.IsPartner == true)
            {
                for(Lead newLead: newLeads)
                {
                newLead.Dealer_Name__c = newUser.Contact.AccountId;
                newLead.Assignment_Date__c = system.now();
                newLead.User_Id_Checker__c += newLead.OwnerId+';';
                }
            }
        }
        
    return newLeads;
    }
    
   
}