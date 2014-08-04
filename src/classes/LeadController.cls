public with sharing class LeadController
{

    string HOSTURL = ApexPages.currentPage().getHeaders().get('host');
    
    public string param1 = '';
    string returnURL = '';

    
    public LeadController(ApexPages.StandardController controller) 
    {
        param1 = Apexpages.currentPage().getParameters().get('accountid');

        returnURL = Apexpages.currentPage().getParameters().get('returnURL');
        if(returnURL != null)
        {
          returnURL = String.escapeSingleQuotes(returnURL);
        }
        if(HOSTURL != null)
        {
          HOSTURL = String.escapeSingleQuotes(HOSTURL);
        }
    }
    
    public PageReference init()
    {

        PageReference leadPage;
        
        try
        {
            leadPage = new PageReference('https://'+HOSTURL+'/00Q/e?00N90000001K5Y8=test');
            leadPage.setRedirect(true);
        }
        catch(Exception e)
        {
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact your system administrator.');
            ApexPages.addMessage(message);
        }
        
        return leadPage;
     }
    
}