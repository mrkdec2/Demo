trigger tryTrigger on Lead (Before Update) {

for (Lead leadsTry : Trigger.New)
{
leadsTry.Hidden_Date_Try__c = Utility.getBussinessDate(leadsTry.Assignment_Date__c,30);
}

}