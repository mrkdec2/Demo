public with sharing class ECOFJsonHelper
{
    public class MyException extends Exception{}
    public String omsOrderId {get; set;} 
    public String configurationId {get; set;}
    
    public static Object navigateTo(Map<String, Object> mapObject, String path, Boolean required) 
    {  
        List<String> keys = path.split('/');
        Map<String, Object> currentMap = mapObject;
        Object value = NULL;    //type Object

        for(String key: keys) 
        {
            value = currentMap.get(key);
            if(value == NULL && required == TRUE)
            {
                throw new MyException(key+' is not found');
            }
            else if(value == NULL)
            {
                return NULL;
            }

            if(!(value instanceOf Map<String, Object>))
            {
                throw new MyException('Invalid type');
            }
            else
            {
                currentMap = (Map<String, Object>) value;
            }       
        }
        
        return value;
    }
}