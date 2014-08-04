/**
 * Class Name:   ECOFRestMethods
 * @author:      Adrian Novillos / Nicole De Guzman / Christian Bolima
 * Date:         06/07/2014
 * @description: Class is used for calling the REST API Methods
 */
public class ECOFRestMethods
{   
    //constructor
    public ECOFRestMethods(){}
    
    public class MyException extends Exception{}
    
    /** 
     * @description: This method parses the order data in the request body and creates order and line item objects.
     * @param requestBody String 
     * @return void 
     */ 
    public static void processSaveOrder(String requestBody)
    {
        Map<String, Object> requestJson = (Map<String, Object>) JSON.deserializeUntyped(requestBody);    //deserialize JSON to Map<String, Object>
        Map<String, Object> orderInformation = (Map<String, Object>) requestJson.get(ECOFGlobalVariableClass.JSON_ORDER_INFORMATION); //get orderInformation in deserialized JSON
        String orderId = (String)orderInformation.get(ECOFGlobalVariableClass.JSON_ORDER_ID);
        
        if(orderId != null)
        {
            Sales_Order__c orderObject = [SELECT Id,Case__c,CreatedDate,Configuration_ID__c,Oms_Order_ID__c,Call_Intent_1__c,Call_Intent_2__c,MSC__c,Total_Amount__c,Subtotal_Amount__c,Tax_Amount__c,Shipping_Amount__c,Welcome_Letter_Code__c,Make_ABP__c,ABP_Eligible__c,ABP_Required__c,PB_Required__c,Email_Required__c,Status__c,ABP_Enabled__c FROM Sales_Order__c WHERE Order_Id__c=:orderId LIMIT 1]; //Query for the records of object(Sales_Order__c)
            
            if(!(orderObject.Status__c== ECOFGlobalVariableClass.STATUS_NEW || orderObject.Status__c== ECOFGlobalVariableClass.STATUS_SAVED_INCOMPLETE)) //Verify the value of Status of the Sales_Order__c (orderObject.Status__c)
            {
                throw new MyException( ECOFGlobalVariableClass.ERROR_INVALID_STATUS_ORDER);
            }
            else //Assigns the value of Status of the Sales_Order__c (orderObject.Status__c)
            {
                if(orderInformation.get( ECOFGlobalVariableClass.JSON_ACTION) == ECOFGlobalVariableClass.JSON_VALUE_SAVE)
                {
                    orderObject.Status__c = ECOFGlobalVariableClass.STATUS_SAVED_INCOMPLETE;
                }
                else if(orderInformation.get(ECOFGlobalVariableClass.JSON_ACTION) == ECOFGlobalVariableClass.JSON_VALUE_PROVISION)
                {
                    orderObject.Status__c = ECOFGlobalVariableClass.STATUS_COMPLETED;
                }
                
                //Assigns the value of Call_Intent_1__c, Call_Intent_2__c,MSC__c, ABP_Enabled__c fields of Sales_Order__c with the received value from JSON orderInformation 
                orderObject.Call_Intent_1__c = (String)orderInformation.get(ECOFGlobalVariableClass.JSON_CI1); 
                orderObject.MSC__c = (String)orderInformation.get(ECOFGlobalVariableClass.JSON_MSC);
                orderObject.ABP_Enabled__c = Boolean.valueOf(orderInformation.get(ECOFGlobalVariableClass.JSON_ABP)); //Note that “ABP” is Y or N, set ABP_Enabled__c to B_TRUE/B_FALSE, respectively
                
                //Assigns the value of Configuration_Id__c, Oms_Order_Id__c with the value received from JSON provisioningBOM
                Map<String,Object> orderIdentifier = (Map<String,Object>) ECOFJsonHelper.navigateTo(requestJson, ECOFGlobalVariableClass.PATH_PROVBOM_IDENTIFIER, ECOFGlobalVariableClass.B_TRUE);
                orderObject.Configuration_Id__c = String.valueOf(orderIdentifier.get(ECOFGlobalVariableClass.JSON_CONFIGURATION_ID));  
                orderObject.Oms_Order_Id__c = String.valueOf(orderIdentifier.get(ECOFGlobalVariableClass.JSON_OMS_ORDER_ID));
                orderObject.Welcome_Letter_Code__c = (String) ECOFJsonHelper.navigateTo(requestJson,ECOFGlobalVariableClass.PATH_PROVBOM_WELCOMELETTERCODE, ECOFGlobalVariableClass.B_FALSE); //This can be NULL              

                Map<String, String> relatedLineItemMap = buildRelatedLineItemMap(requestJson); //Builds the Related Item Map with the given the request JSON
                
                Map<String, Object> lineItemIdMap = buildLineItemIdMap(requestJson); //Builds the Line Item Map with the given the request JSON
                
                Map<String, Object> lineItemStatusIdMap = buildStatusLineItemMap(requestJson); //Builds the Status Item Map with the given the request JSON
                
                    // Testing
                    system.debug('debug1 yes'+ relatedLineItemMap);
                    system.debug('debug2 yes'+ lineItemIdMap);
                    system.debug('debug3 yes'+ lineItemStatusIdMap);                            
                
                processOrderLineItems(requestJson, orderObject, relatedLineItemMap, lineItemIdMap, lineItemStatusIdMap); //An Order Line Item shall be created for a line item that meets all conditions
                
                update orderObject; //Updates the Database with the assigned values
                
                //Updates the Credit card address on the Account object
                Map<String, Object> creditCardBillingInfo = (Map<String, Object>) requestJson.get(ECOFGlobalVariableClass.PATH_CREDITCARDINFO);
                Case caseId = [SELECT AccountId from Case WHERE Id=: orderObject.Case__c limit 1];
                system.debug('Debug caseID: ' +caseId);
                if(creditCardBillingInfo != null)
                {
                    //Any of these fields could be NULL
                    Account account = [SELECT BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry FROM Account WHERE Id =: caseId.AccountId LIMIT 1];
                    account.BillingStreet = String.valueOf(creditCardBillingInfo.get(ECOFGlobalVariableClass.JSON_UNIT_NUM)) + String.valueOf(creditCardBillingInfo.get(ECOFGlobalVariableClass.JSON_UNIT_TYPE)) + String.valueOf(creditCardBillingInfo.get(ECOFGlobalVariableClass.JSON_ADDRESS_LINE_1)) + String.valueOf(creditCardBillingInfo.get(ECOFGlobalVariableClass.JSON_ADDRESS_LINE_2));
                    account.BillingCity = String.valueOf(creditCardBillingInfo.get(ECOFGlobalVariableClass.JSON_CITY));
                    account.BillingState = String.valueOf(creditCardBillingInfo.get(ECOFGlobalVariableClass.JSON_STATE));
                    account.BillingPostalCode = String.valueOf(creditCardBillingInfo.get(ECOFGlobalVariableClass.JSON_ZIP));
                    update account;

                }
            }
        }
        else
        {
            //Throw error when Order Id is NULL
            throw new MyException(ECOFGlobalVariableClass.ERROR_ORDER_ID_NOT_PROVIDED);
        }
    }
    
    /** 
     * @description: This method returns a Map providing look up for line item ID to the line item object. For example { “600”  {..line item object..} }
     * @param requestJson Map<String, Object>
     * @return Map<String, Object>
     */ 
    private static Map<String, Object> buildLineItemIdMap(Map<String, Object> requestJson)
    {
        Map<String,Object> lineItemIdMap = new Map<String,Object>(); //create new Map<String, Object> to put JSON elements
        Map<String, Object> orderLineItem = (Map<String, Object>)ECOFJsonHelper.navigateTo(requestJson,ECOFGlobalVariableClass.PATH_PROVBOM_LINEITEM,ECOFGlobalVariableClass.B_TRUE); // required, orderLineItem should be List<Map<String,Object>>
        List<Object> lineItem = (List<Object>)orderLineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM);//Assign the orderLineItem to a List
       
        //Traverse each LineItem to get the LineItem Id and Map it to each lineItem List
        for(Object lineItemObj: lineItem)
        {
            Map<String, Object> lineItemIdentifier = (Map<String,Object>)lineItemObj;
            Map<String,Object> lineItemIdentifier2 = (Map<String,Object>)lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_IDENTIFIER);
            lineItemIdMap.put(String.valueOf(lineItemIdentifier2.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_ID)),lineItemObj);
        }
        system.debug('debug4: '+ lineItemIdMap);
        return lineItemIdMap;
    }
    
    /** 
     * @description: This method returns a Map providing relationship between a line item and its related line item. The key of the map will be in the format 
     *               “<lineItemId>__<relationship type>” and value is the related line item ID. For example {“600_offerDetail”  “200”, “200_offer”  “10” }
     * @param requestJson Map<String, Object>
     * @return Map<String, Object>
     */
    private static Map<String, String> buildRelatedLineItemMap(Map<String, Object> requestJson)
    {
        Map<String,String> relatedLineItemMap = new Map<String,String> ();  //create new Map<String, String> to put JSON elements
        Map<String, Object> orderLineItem = (Map<String, Object>)ECOFJsonHelper.navigateTo(requestJson,ECOFGlobalVariableClass.PATH_PROVBOM_LINEITEM,ECOFGlobalVariableClass.B_TRUE); // required, orderLineItem should be List<Map<String,Object>>
        List<Object> listOfLineItem = (List<Object>)orderLineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM); //Assign the orderLineItem to a List
        
        for(Object objOfLineItem: listOfLineItem)
        {
            Map<String, Object> mapOfLineItem = (Map<String, Object>)objOfLineItem; 
            Map<String, Object> mapOfLineItemIdentifier = (Map<String, Object>)mapOfLineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_IDENTIFIER);
            if(String.valueOf(mapOfLineItem.get(ECOFGlobalVariableClass.JSON_RELATIONSHIPLIST)) != null)
            {
            Map<String, Object> mapOfRelationshipList = (Map<String, Object>)mapOfLineItem.get(ECOFGlobalVariableClass.JSON_RELATIONSHIPLIST);
            List<Object> listOfRelationshipSet = (List<Object>)mapOfRelationshipList.get(ECOFGlobalVariableClass.JSON_RELATIONSET);  //Assign mapOfRelationshipList values to a List
            for(Object relationSet: listOfRelationshipSet)
            {
                Map<String, Object> mapOfRelationshipSet = (Map<String, Object>)relationSet;
                List<Object> listOfRelatedTo = (List<Object>)mapOfRelationshipSet.get(ECOFGlobalVariableClass.PATH_RELTO);  //Assign mapOfRelationshipSet to a List
                for(Object relatedTo: listOfRelatedTo)
                {
                    Map<String, Object> mapOfRelatedTo = (Map<String, Object>)relatedTo;
                    relatedLineItemMap.put(String.valueOf(mapOfLineItemIdentifier.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_ID))+'_'+ String.valueOf(mapOfRelatedTo.get(ECOFGlobalVariableClass.JSON_RELATIONSHIP_TYPE)),String.valueOf(mapOfRelatedTo.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_ID)));
                }
            }
            
            }
        }
        return relatedLineItemMap;   
    }

    /** 
     * @description: This method returns a Map providing look up for line item ID to status JSON object
     * @param requestJson Map<String, Object>
     * @return Map<String, Object>
     */ 
    private static Map<String, Object> buildStatusLineItemMap(Map<String, Object> requestJson)
    {
        Map<String,String> lineItemIdMap = new Map<String,String>();  //create new Map<String, String> to put JSON elements
        Map<String, Object> status = (Map<String, Object>) requestJson.get(ECOFGlobalVariableClass.JSON_STATUS); //get orderInformation in deserialized JSON
        List<Object> lineItemStatusList = (List<Object>)status.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_STATUS_LIST);  //Convert and assign status to a list

        if(lineItemStatusList.size() != 0)
        {
        for(Object lineItemStatus: lineItemStatusList)
        {
            Map<String, Object> mapOfLineItemStatus = (Map<String, Object>)lineItemStatus;
            lineItemIdMap.put(String.valueOf(mapOfLineItemStatus.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_ID)),String.valueOf(mapOfLineItemStatus.get(ECOFGlobalVariableClass.JSON_MESSAGE_TEXT)));
        }
        }
        return lineItemIdMap;

    }
    
    /** 
     * @description: This method processes the order data structure and create necessary order line items. An Order Line Item will be created for a line item that meets all these conditions:
     *                 1)   Not of type “offer” or “offerDetail”
     *                 2)    Line item Visible flag is TRUE
     *                 3)    Must be “recurring” or “condition” (in the future, it will include “today”)
     * @param requestJson Map<String, Object>
     * @param orderObject Sales_Order__c
     * @param relatedLineItemMap Map<String, String>
     * @param lineItemIdMap Map<String, Object>
     * @param lineItemStatusIdMap Map<String, Object>
     * @return List<Order_Line_Item__c>
     */
    private static List<Order_Line_Item__c> processOrderLineItems(Map<String, Object> requestJson, Sales_Order__c orderObject, Map<String, String> relatedLineItemMap, Map<String, Object> lineItemIdMap, Map<String, Object> lineItemStatusIdMap)
    {
        Map<String, Object> orderLineItem = (Map<String, Object>)ECOFJsonHelper.navigateTo(requestJson,ECOFGlobalVariableClass.PATH_PROVBOM_LINEITEM,ECOFGlobalVariableClass.B_TRUE);
        List<Object> lineItem = (List<Object>)orderLineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM);//Assign the orderLineItem to a List
        //create a map for tracking Line Item ID for easy organization later
        //Map<String, Order_Line_Item__c> lineItemIdMap = new Map<String, Order_Line_Item__c>();
        List<Order_Line_Item__c> lineItemObject = new List<Order_Line_Item__c>();
        String lineItemType;
        Boolean visibleFlag;
        String lineItemId;
        String offerDetailLineItemId;
        //Delete all existing Order line items and associated objects
        if([SELECT Sales_Order__c FROM Order_Line_Item__c WHERE Sales_Order__c =: orderObject.Id].size() > 0)
        {
            delete [SELECT Sales_Order__c FROM Order_Line_Item__c WHERE Sales_Order__c =: orderObject.Id];
        }
        if([SELECT Sales_Order__c FROM Order_Conditions__c WHERE Sales_Order__c =: orderObject.Id].size() > 0)
        {
            delete [SELECT Sales_Order__c FROM Order_Conditions__c WHERE Sales_Order__c =: orderObject.Id];
        }
        
        //loop through each order line item
        for(Object lnItem: lineItem)
        {
            Map<String, Object> mapOfLineItem = (Map<String,Object>)lnItem; //Create a map for tracking Line Item ID
            lineItemType = String.valueOf(mapOfLineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_TYPE)); //Convert output to string
            visibleFlag = Boolean.valueOf(mapOfLineItem.get(ECOFGlobalVariableClass.JSON_VISIBLE_FLAG));
            if((lineItemType == 'offer' || lineItemType == ECOFGlobalVariableClass.JSON_OFFER_DETAIL) && visibleFlag == ECOFGlobalVariableClass.B_TRUE) //Not of type 'offer' or 'offerDetail' and visible flag to 'B_TRUE'
            {
                Map<String, Object> mapOfLineItemIdentifier = (Map<String,Object>)mapOfLineItem.get(ECOFGlobalVariableClass.PATH_LINEITEMIDEN);
                Order_Line_Item__c objectOrderLineItem = new Order_Line_Item__c();
                //determine whether this line item is a RECURRING or CONDITION item
                objectOrderLineItem.Sales_Order__c = orderObject.Id;
                objectOrderLineItem.Order_Type__c = String.valueOf(mapOfLineItem.get(ECOFGlobalVariableClass.JSON_ORDER_TYPE));
                objectOrderLineItem.Line_Item_Type__c = String.valueOf(mapOfLineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_TYPE));
                objectOrderLineItem.Action__c = String.valueOf(mapOfLineItem.get(ECOFGlobalVariableClass.JSON_ACTION));
                objectOrderLineItem.Product_Id__c = String.valueOf(mapOfLineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_ID));
                objectOrderLineItem.Product_Name__c = String.valueOf(mapOfLineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_NAME));
                objectOrderLineItem.Product_Description__c = String.valueOf(mapOfLineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_DESCRIPTION));
                objectOrderLineItem.OMS_Product_Id__c = (Integer)mapOfLineItemIdentifier.get(ECOFGlobalVariableClass.JSON_OMS_PRODUCT_ID);
                lineItemObject.add(objectOrderLineItem);
                
                lineItemId = String.valueOf(mapOfLineItemIdentifier.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_ID));
                String offerDetailLineItemIds = relatedLineItemMap.get(lineItemId + ECOFGlobalVariableClass.JSON_UNDS_OFFER_DETAIL);
                if(offerDetailLineItemIds != null)
                {
                String offerLineItemIds = relatedLineItemMap.get(offerDetailLineItemIds + ECOFGlobalVariableClass.JSON_UNDS_OFFER);
                    if(offerLineItemIds != null)
                    {
                        String offerLineItem = String.valueOf(lineItemIdMap.get(offerLineItemIds));  //Retrieve offerLineItemIds then convert it to a string.
                        String offerProductName = String.valueOf(mapOfLineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_NAME));
                        if(offerProductName != null)
                        {
                            if(offerProductName == ECOFGlobalVariableClass.JSON_RECURRING)
                            {
                                //processRecurringOrderLineItem(lineItem, requestJson, lineItemStatusIdMap);
                                processRecurringOrderLineItem(mapOfLineItem, orderObject, lineItemStatusIdMap);
                            }
                            else if(offerProductName == ECOFGlobalVariableClass.JSON_CONDITIONS)
                            {
                                //processCondition(mapOfLineItem, requestJson);
                               processCondition(mapOfLineItem,orderObject);
                            }
                        }
                    }
                }
            //insert hard logic  
            }
        }

        insert lineItemObject;
        
        return null;
    }
    
    /** 
     * @description: This method process recurring line item from provided JSON line item object then create an order line item
     * @param lineItem Map<String, Object>
     * @param orderObject Sales_Order__c
     * @param lineItemStatusIdMap 
     * @return void
     */ 
    private static void processRecurringOrderLineItem(Map<String, Object> lineItem, Sales_Order__c orderObject, Map<String, Object> lineItemStatusIdMap)
    {
        Order_Line_Item__c lineItemObject = new Order_Line_Item__c();  //Instantiates the object (Order_Line_Item__c)
        lineItemObject.Sales_Order__c = orderObject.id;  // Set value of Sales_Order__c from id
        lineItemObject.Order_Type__c = (String) lineItem.get(ECOFGlobalVariableClass.JSON_ORDER_TYPE); 
        lineItemObject.Line_Item_Type__c = (String) lineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_TYPE); // Typecast the get string from lineItem to matched it with Line_Item_Type__c
        lineItemObject.Action__c = (String) lineItem.get(ECOFGlobalVariableClass.JSON_ACTION); // Typecast the get string from lineItem to matched it with Action__c
        
        Map<String,String> lineItemIdentifier = (Map<String,String>) ECOFJsonHelper.navigateTo(lineItem, ECOFGlobalVariableClass.PATH_LINEITEMIDEN, ECOFGlobalVariableClass.B_TRUE);  //Assign output as a Map
        //Assign lineItemIdentifier get values to lineItemObject specified fields
        lineItemObject.Product_Id__c = lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_ID);
        lineItemObject.Product_Name__c = lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_NAME);
        lineItemObject.Product_Description__c = lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_DESCRIPTION);
        lineItemObject.OMS_Product_Id__c = Decimal.valueOf(lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_OMS_PRODUCT_ID));
        lineItemObject.OMS_Product_Type_Id__c = lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_OMS_PRODUCT_TYPE_ID);
        
        Boolean abpRequired = (Boolean) ECOFJsonHelper.navigateTo(lineItem, ECOFGlobalVariableClass.PATH_ADDOFFINFO_AUTOBILLPAYFLAG, ECOFGlobalVariableClass.B_FALSE);
        if(abpRequired != null)
        {
            lineItemObject.Offer_Requires_ABP__c = abpRequired;
        }
        
        Map<String,String> bundleOffer = (Map<String,String>) lineItem.get(ECOFGlobalVariableClass.JSON_BUNDLE_OFFER);
        if(bundleOffer != null)
        {
            //Assign bundleOffer get values to lineItemObject specified fields
            lineItemObject.Bundle_offer_Id__c = bundleOffer.get(ECOFGlobalVariableClass.JSON_OFFER_ID);
            lineItemObject.Bundle_offer_type__c = bundleOffer.get(ECOFGlobalVariableClass.JSON_OFFER_TYPE);
            lineItemObject.Bundle_offer_Description__c = bundleOffer.get(ECOFGlobalVariableClass.JSON_OFFER_DESCRIPTION);
        }
        
        //product type is the first character for productId, product code is the remaining digits
        //for example, B1234 = product type “B” and product code 1234
        lineItemObject.Product_Type__c = lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_ID).subString(0,1);
        lineItemObject.Product_Code__c = Decimal.valueOf(lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_PRODUCT_ID).subString(1));
        
        String lineItemType = (String) lineItem.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_TYPE); // Typecast the get string from lineItem to matched it with lineItemType
        String priceCode = '';
        if(lineItemType == ECOFGlobalVariableClass.JSON_PROGRAMMING)
        {
            priceCode = (String) ECOFJsonHelper.navigateTo(lineItem, ECOFGlobalVariableClass.PATH_LINEITEMDET_PRICECODE, ECOFGlobalVariableClass.B_FALSE); //typecast navigateTo method output to a string and assign it to a variable
        }
        else if(lineItemType == ECOFGlobalVariableClass.JSON_AGREEMENT)
        {
            priceCode = (String) ECOFJsonHelper.navigateTo(lineItem, ECOFGlobalVariableClass.PATH_LINEITEMDET_AGREEMENTPRICECODE, ECOFGlobalVariableClass.B_FALSE);  //typecast navigateTo method output to a string and assign it to a variable
        }
        lineItemObject.Price_Code__c = priceCode;
        
        //get monthly from the first element in recurring prices
        List<Map<String,String>> recurringPriceList = (List<Map<String,String>>) ECOFJsonHelper.navigateTo(lineItem, ECOFGlobalVariableClass.PATH_PRICE_RECURRINGPRICE, ECOFGlobalVariableClass.B_FALSE);
        
        for(Map<String,String> recurringPrice: recurringPriceList)
        {
            if(recurringPrice.get(ECOFGlobalVariableClass.JSON_FREQUENCY_OF_CHANGE) == ECOFGlobalVariableClass.JSON_MONTHLY)
            {
                //Set values of lineItemObject fields
                lineItemObject.Price__c = Decimal.valueOf(recurringPrice.get(ECOFGlobalVariableClass.JSON_PRICE));
                lineItemObject.Frequency__c = recurringPrice.get(ECOFGlobalVariableClass.JSON_FREQUENCY_OF_CHANGE);
                lineItemObject.Number_of_Charges__c = Decimal.valueOf(recurringPrice.get(ECOFGlobalVariableClass.JSON_NUMBER_OF_CHANGES));
            }
        }
        
        //update provisioning status
        String lineItemId = lineItemIdentifier.get(ECOFGlobalVariableClass.JSON_LINE_ITEM_ID);
        Map<String,String> lineItemStatus = (Map<String,String>) lineItemStatusIdMap.get(lineItemId);
        //Set values of lineItemObject fields based from lineItemStatus fields
        lineItemObject.Status_Message__c = lineItemStatus.get(ECOFGlobalVariableClass.JSON_MESSAGE_STATUS);
        lineItemObject.Provider__c = lineItemStatus.get(ECOFGlobalVariableClass.JSON_PROVIDER);
        lineItemObject.Target_System__c = lineItemStatus.get(ECOFGlobalVariableClass.JSON_TARGET_SYSTEM);
        
        insert lineItemObject;
    }

    /** 
     * @description: This method process condition line item from provided JSON line item object then create a Condition record
     * @param lineItem Map<String, Object>
     * @param orderObject Sales_Order__c
     * @return void
     */ 
    private static void processCondition(Map<String, Object> lineItem, Sales_Order__c orderObject)
    {
        Order_Conditions__c conditionObject = new Order_Conditions__c();  //Instantiates the object (Order_Conditions__c)
        //Assign values to conditionObject fields 
        conditionObject.Sales_Order__c = orderObject.Id;
        conditionObject.Condition__c = (String) ECOFJsonHelper.navigateTo(lineItem, ECOFGlobalVariableClass.PATH_LINEITEMDET_PRODUCTDESCRIPTION, ECOFGlobalVariableClass.B_TRUE);
        conditionObject.Name = String.valueOf(system.now());
        insert conditionObject;
    }
}