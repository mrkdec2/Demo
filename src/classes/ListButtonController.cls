public with sharing class ListButtonController 
{
    private ApexPages.StandardSetController standardSetController;

    public ListButtonController(ApexPages.StandardSetController standardSetController) 
    { 
        this.standardSetController = standardSetController;
    }

    public PageReference doSomething()
    {
        // Apex code for handling records from a List View goes here
        //List<Lead> listViewRecords = (List<Lead>) standardSetController.getRecords();
        List<Lead> selectedListViewRecords = (List<Lead>) standardSetController.getSelected();
        list<lead> leadListTemp = new list<lead>();
        //Boolean hasMore = standardSetController.getHasNext();
        
        system.debug('size deb:'+selectedListViewRecords.size());
        system.debug('selectedListViewRecords deb:'+selectedListViewRecords);
        
        for( Lead selectedListViewRecord : selectedListViewRecords){
            selectedListViewRecord.NumberOfEmployees = 1234;
            selectedListViewRecord.OwnerId = UserInfo.getUserId();
            leadListTemp.add(selectedListViewRecord);
        }
        
         
        try {
            update leadListTemp;
        } catch (DmlException e) {
        
        }
        return new PageReference('https://na15.salesforce.com/00Q');
    }
}