public with sharing class DetailButtonController 
{
    public DetailButtonController() {
    }
    public PageReference doSomething()
    {
        // Apex code for handling record from a Detail page goes here
        //Id recordId = standardController.getId();
        //Lead record = (Lead) standardController.getRecord();
        string leadId = Apexpages.currentPage().getParameters().get('id');
        string userId = Apexpages.currentPage().getParameters().get('uid');
        Lead lInfo = [select OwnerId,User_Id_Checker__c from Lead where Id =:leadId];
        lInfo.OwnerId = userId;
        //concatinate user checker ID
        if(lInfo.User_Id_Checker__c != NULL)
        {
            lInfo.User_Id_Checker__c += userId+';'; 
        }
        else
        {
            lInfo.User_Id_Checker__c = userId+';';
        }
        try 
        {
            update lInfo;
        }catch (DmlException e)
        {    
        }
            return new PageReference('/'+leadId);
     }
}