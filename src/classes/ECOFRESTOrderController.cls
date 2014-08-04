/**
 * Class Name: ECOFRESTOrderController
 * @author: Adrian Novillos / Nicole De Guzman / Christian Bolima
 * Date: 06/07/2014
 * @description Describe webservice that will be called by the shopping cart to save a completed or incompleted order.
 */
 
@RestResource(urlMapping='/Order/*')
global with sharing class ECOFRESTOrderController {

    public class MyException extends Exception{}
    
///// 1
    @HTTPPost
    global static String doPostSaveOrder()
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String requestBody = req.requestBody.toString();
        SavePoint savePoint = Database.setSavePoint();
        
        try
        {
            ECOFRestMethods.processSaveOrder(requestBody);
        }
        catch(Exception e)
        {
            //If there are any errors, rollback
            Database.rollback(savePoint);
            res.statusCode = ECOFGlobalVariableClass.RESPONSE_ERROR_CODE;
            res.responseBody = Blob.valueOf(e.getMessage());
            return null;
        }
        
        res.statusCode = ECOFGlobalVariableClass.RESPONSE_SUCCESS_CODE;
        return null;
    }


}