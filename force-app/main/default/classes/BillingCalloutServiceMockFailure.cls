/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-29-2024
 * @last modified by  : Dipan Ghosh
**/
@isTest
public class BillingCalloutServiceMockFailure implements WebServiceMock {
   //Implement http mock callout failure here 
	public Void doInvoke(Object stub, Object soapRequest,
		Map<String,Object> responseMap, String endpoint,
				String soapAction, String requestName,
				String responseNamespace, String responseName,
				String responseType){
		BillingServiceProxy.billProjectResponse_element res = new BillingServiceProxy.billProjectResponse_element();
		res.status = 'Not OK';
		responseMap.put('response_x', res);
	}
}