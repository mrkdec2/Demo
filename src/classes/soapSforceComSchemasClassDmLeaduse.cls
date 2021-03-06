//Generated by wsdl2apex

public class soapSforceComSchemasClassDmLeaduse {
    public class AllowFieldTruncationHeader_element {
        public Boolean allowFieldTruncation;
        private String[] allowFieldTruncation_type_info = new String[]{'allowFieldTruncation','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'allowFieldTruncation'};
    }
    public class CallOptions_element {
        public String client;
        private String[] client_type_info = new String[]{'client','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'client'};
    }
    public class checkIfExternalResponse_element {
        public Boolean result;
        private String[] result_type_info = new String[]{'result','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
    public class SessionHeader_element {
        public String sessionId;
        private String[] sessionId_type_info = new String[]{'sessionId','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'sessionId'};
    }
    public class checkIfUserCanDelete_element {
        public String userId;
        private String[] userId_type_info = new String[]{'userId','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'userId'};
    }
    public class checkIfUserCanDeleteResponse_element {
        public Boolean result;
        private String[] result_type_info = new String[]{'result','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
    public class LogInfo {
        public String category;
        public String level;
        private String[] category_type_info = new String[]{'category','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','false'};
        private String[] level_type_info = new String[]{'level','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'category','level'};
    }
    public class DebuggingHeader_element {
        public soapSforceComSchemasClassDmLeaduse.LogInfo[] categories;
        public String debugLevel;
        private String[] categories_type_info = new String[]{'categories','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'0','-1','false'};
        private String[] debugLevel_type_info = new String[]{'debugLevel','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'categories','debugLevel'};
    }
    public class checkPreviousLeadOwnerResponse_element {
        public Boolean result;
        private String[] result_type_info = new String[]{'result','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
    public class checkIfExternal_element {
        public String userId;
        private String[] userId_type_info = new String[]{'userId','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'userId'};
    }
    public class deleteLead_element {
        public String leadId;
        private String[] leadId_type_info = new String[]{'leadId','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'leadId'};
    }
    public class DebuggingInfo_element {
        public String debugLog;
        private String[] debugLog_type_info = new String[]{'debugLog','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'debugLog'};
    }
    public class deleteLeadResponse_element {
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class checkPreviousLeadOwner_element {
        public String leadId;
        public String userId;
        private String[] leadId_type_info = new String[]{'leadId','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] userId_type_info = new String[]{'userId','http://soap.sforce.com/schemas/class/DM_LeadUserChecker',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker','true','false'};
        private String[] field_order_type_info = new String[]{'leadId','userId'};
    }
    public class DM_LeadUserChecker {
        public String endpoint_x = 'https://cs18.salesforce.com/services/Soap/class/DM_LeadUserChecker';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        public soapSforceComSchemasClassDmLeaduse.DebuggingInfo_element DebuggingInfo;
        public soapSforceComSchemasClassDmLeaduse.SessionHeader_element SessionHeader;
        public soapSforceComSchemasClassDmLeaduse.CallOptions_element CallOptions;
        public soapSforceComSchemasClassDmLeaduse.AllowFieldTruncationHeader_element AllowFieldTruncationHeader;
        public soapSforceComSchemasClassDmLeaduse.DebuggingHeader_element DebuggingHeader;
        private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/schemas/class/DM_LeadUserChecker';
        private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/schemas/class/DM_LeadUserChecker';
        private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/schemas/class/DM_LeadUserChecker';
        private String AllowFieldTruncationHeader_hns = 'AllowFieldTruncationHeader=http://soap.sforce.com/schemas/class/DM_LeadUserChecker';
        private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/schemas/class/DM_LeadUserChecker';
        private String[] ns_map_type_info = new String[]{'http://soap.sforce.com/schemas/class/DM_LeadUserChecker', 'soapSforceComSchemasClassDmLeaduse'};
        public void deleteLead(String leadId) {
            soapSforceComSchemasClassDmLeaduse.deleteLead_element request_x = new soapSforceComSchemasClassDmLeaduse.deleteLead_element();
            request_x.leadId = leadId;
            soapSforceComSchemasClassDmLeaduse.deleteLeadResponse_element response_x;
            Map<String, soapSforceComSchemasClassDmLeaduse.deleteLeadResponse_element> response_map_x = new Map<String, soapSforceComSchemasClassDmLeaduse.deleteLeadResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'deleteLead',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'deleteLeadResponse',
              'soapSforceComSchemasClassDmLeaduse.deleteLeadResponse_element'}
            );
            response_x = response_map_x.get('response_x');
        }
        public Boolean checkIfUserCanDelete(String userId) {
            soapSforceComSchemasClassDmLeaduse.checkIfUserCanDelete_element request_x = new soapSforceComSchemasClassDmLeaduse.checkIfUserCanDelete_element();
            request_x.userId = userId;
            soapSforceComSchemasClassDmLeaduse.checkIfUserCanDeleteResponse_element response_x;
            Map<String, soapSforceComSchemasClassDmLeaduse.checkIfUserCanDeleteResponse_element> response_map_x = new Map<String, soapSforceComSchemasClassDmLeaduse.checkIfUserCanDeleteResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'checkIfUserCanDelete',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'checkIfUserCanDeleteResponse',
              'soapSforceComSchemasClassDmLeaduse.checkIfUserCanDeleteResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
        public Boolean checkIfExternal(String userId) {
            soapSforceComSchemasClassDmLeaduse.checkIfExternal_element request_x = new soapSforceComSchemasClassDmLeaduse.checkIfExternal_element();
            request_x.userId = userId;
            soapSforceComSchemasClassDmLeaduse.checkIfExternalResponse_element response_x;
            Map<String, soapSforceComSchemasClassDmLeaduse.checkIfExternalResponse_element> response_map_x = new Map<String, soapSforceComSchemasClassDmLeaduse.checkIfExternalResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'checkIfExternal',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'checkIfExternalResponse',
              'soapSforceComSchemasClassDmLeaduse.checkIfExternalResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
        public Boolean checkPreviousLeadOwner(String leadId,String userId) {
            soapSforceComSchemasClassDmLeaduse.checkPreviousLeadOwner_element request_x = new soapSforceComSchemasClassDmLeaduse.checkPreviousLeadOwner_element();
            request_x.leadId = leadId;
            request_x.userId = userId;
            soapSforceComSchemasClassDmLeaduse.checkPreviousLeadOwnerResponse_element response_x;
            Map<String, soapSforceComSchemasClassDmLeaduse.checkPreviousLeadOwnerResponse_element> response_map_x = new Map<String, soapSforceComSchemasClassDmLeaduse.checkPreviousLeadOwnerResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'checkPreviousLeadOwner',
              'http://soap.sforce.com/schemas/class/DM_LeadUserChecker',
              'checkPreviousLeadOwnerResponse',
              'soapSforceComSchemasClassDmLeaduse.checkPreviousLeadOwnerResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
    }
}