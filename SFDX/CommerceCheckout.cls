public with sharing class CommerceCheckout {
    @AuraEnabled(cacheable=true)
    public static string getSessionId() {
        return UserInfo.getSessionId();
    }

    @AuraEnabled(cacheable=true)
    public static string getCommerceCheckout() {
        //Make sure your Salesforce instance URL is added in remote site settings
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm(); 
        String restAPIURL = 'https://sf-mojo.my.salesforce.com/services/data/v54.0/commerce/webstores/0ZEDo000000L7GVOA0/checkouts/active';  
        
        HttpRequest httpRequest = new HttpRequest();  
        httpRequest.setMethod('GET');   
        httpRequest.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());        
        httpRequest.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); 
        httpRequest.setEndpoint(restAPIURL);  
        String response = '';
        try {  
            Http http = new Http();   
            HttpResponse httpResponse = http.send(httpRequest);  
            if (httpResponse.getStatusCode() == 200 ) {  
                response = JSON.serialize( JSON.deserializeUntyped(httpResponse.getBody()) ); 
                response = httpResponse.getBody(); 
                System.debug('##response: ' + response );   
            } else {  
                System.debug(' httpResponse ' + httpResponse.getBody() );  
                throw new CalloutException( httpResponse.getBody() );  
            } 
            return response;  
        } catch( System.Exception e) {  
            System.debug('ERROR: '+ e);  
            throw e;  
        }  
    }

    @AuraEnabled(cacheable=true)
    public static string updateCommerceCheckout(string payload) {
        System.debug('##payload: '+payload);
        CommerceRequest payloadCommerceRequest = (CommerceRequest)JSON.deserialize(payload,CommerceRequest.class);
        System.debug('##payloadCommerceRequest: '+payloadCommerceRequest);
        CommercePayload message;
        if (payloadCommerceRequest.shippingInstructions != null) {
            System.debug('##in shipping loop');
            message = new CommercePayload();
            message.shippingInstructions = payloadCommerceRequest.shippingInstructions;
        }

        //Make sure your Salesforce instance URL is added in remote site settings
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm(); 
        String restAPIURL = 'https://sf-mojo.my.salesforce.com/services/data/v54.0/commerce/webstores/0ZEDo000000L7GVOA0/checkouts/active';  
        
        HttpRequest httpRequest = new HttpRequest();  
        httpRequest.setMethod('PATCH');   
        httpRequest.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());        
        httpRequest.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); 
        httpRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        httpRequest.setEndpoint(restAPIURL);
        httpRequest.setBody(JSON.serialize(message));  

        String response = '';
        try {  
            Http http = new Http();   
            HttpResponse httpResponse = http.send(httpRequest);  
            if (httpResponse.getStatusCode() == 200 || httpResponse.getStatusCode() == 202 || httpResponse.getStatusCode() == 201) {  
                response = JSON.serialize( JSON.deserializeUntyped(httpResponse.getBody()) ); 
                response = httpResponse.getBody(); 
                System.debug('##response: ' + response );   
            } else {  
                System.debug(' httpResponse ' + httpResponse.getBody() );  
                throw new CalloutException( httpResponse.getBody() );  
            } 
            return response;  
        } catch( System.Exception e) {  
            System.debug('ERROR: '+ e);  
            throw e;  
        }  
    }

    public class CommercePayload {
        @AuraEnabled
        public String desiredDeliveryDate;

        @AuraEnabled
        public String shippingInstructions;
    }

    public class CommerceRequest {
        @AuraEnabled
        public String desiredDeliveryDate;

        @AuraEnabled
        public String shippingInstructions;
    }
}