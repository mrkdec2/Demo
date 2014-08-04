/**
 * Class Name: ECOFGlobalVariableClass
 * @author: Adrian Novillos / Nicole De Guzman / Christian Bolima
 * Date: 06/07/2014
 * @description Class is used for static variables that can be reused.
 */

Global class ECOFGlobalVariableClass
{
    //Universal Global Variables
    global static final boolean B_TRUE = true;
    global static final boolean B_FALSE = false;

    //JSON Path
    global static final string PATH_PROVBOM_IDENTIFIER = 'provisioningBOM/identifier';
    global static final string PATH_PROVBOM_ORDERTYPE = 'provisioningBOM/orderType';
    global static final string PATH_PROVBOM_WELCOMELETTERCODE = 'provisioningBOM/customer/profile/welcomeLetterCode';
    global static final string PATH_CREDITCARDINFO = 'creditCardInformation';
    global static final string PATH_PROVBOM_LINEITEM = 'provisioningBOM/lineItemList';
    global static final string PATH_LINEITEMIDEN_LINEITEMID = 'lineItemIdentifier/lineItemId';
    global static final string PATH_RELLIST_RELATIONSHIPSET = 'relationshipList/relationshipSet';
    global static final string PATH_RELTO = 'relatedTo';
    global static final string PATH_STAT_LINEITEMSTATUSLIST = 'status/lineitemStatusList';
    global static final string PATH_LINEITEMIDEN = 'lineItemIdentifier';
    global static final string PATH_LINEITEMIDEN_PRODUCTNAME = 'lineItemIdentifier/productName';
    global static final string PATH_ADDOFFINFO_AUTOBILLPAYFLAG = 'additionalOfferInformation/offerTakenRequiresAutoBillPayFlag';
    global static final string PATH_LINEITEMDET_PRICECODE = 'lineItemDetail/programming/priceCode';
    global static final string PATH_LINEITEMDET_AGREEMENTPRICECODE = 'lineItemDetail/agreement/agreementPriceCode';
    global static final string PATH_PRICE_RECURRINGPRICE = 'price/recurringPriceList/recurringPrice';
    global static final string PATH_LINEITEMDET_PRODUCTDESCRIPTION = 'lineItemIdentifier/productDescription';
    global static final string PATH_PROVBOM_LINEITEM2 = 'provisioningBOM/lineItemList/lineItem';
    
    //Response Code Global Variables
    global static final integer RESPONSE_ERROR_CODE = 500;
    global static final integer RESPONSE_SUCCESS_CODE = 200;
    
    //JSON Global Variables
    global static final string JSON_ORDER_INFORMATION = 'orderInformation';
    global static final string JSON_ORDER_ID = 'orderId';
    global static final string JSON_ACTION = 'action';
    global static final string JSON_CI1 = 'ci1';
    global static final string JSON_CI2 = 'ci2';
    global static final string JSON_MSC = 'msc';
    global static final string JSON_ABP = 'abp';
    global static final string JSON_CONFIGURATION_ID = 'configurationId';
    global static final string JSON_OMS_ORDER_ID = 'omsOrderId';
    global static final string JSON_UNIT_NUM = 'unitNum';
    global static final string JSON_UNIT_TYPE = 'unitType';
    global static final string JSON_ADDRESS_LINE_1 = 'addressLine1';
    global static final string JSON_ADDRESS_LINE_2 = 'addressLine2';
    global static final string JSON_CITY = 'city';
    global static final string JSON_STATE = 'state';
    global static final string JSON_ZIP = 'zip';
    global static final string JSON_LINE_ITEM = 'lineItem';
    global static final string JSON_LINE_ITEM_IDENTIFIER = 'lineItemIdentifier';
    global static final string JSON_LINE_ITEM_ID = 'lineItemId';
    global static final string JSON_RELATIONSHIP_TYPE = 'relationshipType';
    global static final string JSON_LINE_ITEM_TYPE = 'lineItemType';
    global static final string JSON_VISIBLE_FLAG = 'visibleFlag';
    global static final string JSON_OFFER = 'offer';
    global static final string JSON_OFFER_DETAIL = 'offerDetail';
    global static final string JSON_ORDER_TYPE = 'orderType';
    global static final string JSON_PRODUCT_ID = 'productId';
    global static final string JSON_PRODUCT_NAME = 'productName';
    global static final string JSON_PRODUCT_DESCRIPTION = 'productDescription';
    global static final string JSON_OMS_PRODUCT_ID = 'omsProductId';
    //global static final string JSON_OFFER_LINE_ITEM_ID = 'offerLineItemId';
    global static final string JSON_RECURRING = 'Recurring';
    global static final string JSON_CONDITIONS = 'Conditions';
    global static final string JSON_OMS_PRODUCT_TYPE_ID = 'omsProductTypeId';
    global static final string JSON_BUNDLE_OFFER = 'bundleOffer';
    global static final string JSON_OFFER_ID = 'offerId';
    global static final string JSON_OFFER_TYPE = 'offerType';
    global static final string JSON_OFFER_DESCRIPTION = 'offerDescription';
    global static final string JSON_PROGRAMMING = 'programming';
    global static final string JSON_AGREEMENT = 'agreement';
    global static final string JSON_MONTHLY = 'monthly';
    global static final string JSON_PRICE = 'price';
    global static final string JSON_FREQUENCY_OF_CHANGE = 'frequencyOfCharge';
    global static final string JSON_NUMBER_OF_CHANGES = 'numberOfCharges';
    global static final string JSON_MESSAGE_STATUS = 'messageStatus';
    global static final string JSON_PROVIDER = 'provider';
    global static final string JSON_TARGET_SYSTEM = 'targetSystem';
    global static final string JSON_RELATIONSHIPLIST = 'relationshipList';
    global static final string JSON_RELATIONSET = 'relationSet';
    global static final string JSON_STATUS = 'status';
    global static final string JSON_MESSAGE_TEXT = 'messageText';
    global static final string JSON_LINE_ITEM_STATUS_LIST = 'lineitemStatusList';
    global static final string JSON_UNDS_OFFER_DETAIL = '__offerDetail';
    global static final string JSON_UNDS_OFFER = '__offer';
    
    //JSON Global Variable Values
    global static final string JSON_VALUE_SAVE = 'save';
    global static final string JSON_VALUE_PROVISION = 'provision';
    
    //Order Status Variables
    global static final string STATUS_NEW = 'New';
    global static final string STATUS_SAVED_INCOMPLETE = 'Saved-Incomplete';
    global static final string STATUS_COMPLETED = 'Completed';
    
    //Error Messages Global Variables
    global static final string ERROR_INVALID_STATUS_ORDER = 'Invalid Order Status';
    global static final string ERROR_ORDER_ID_NOT_PROVIDED = 'Order Id not provided';
    
}