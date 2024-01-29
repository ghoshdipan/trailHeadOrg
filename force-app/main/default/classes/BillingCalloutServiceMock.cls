/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-29-2024
 * @last modified by  : Dipan Ghosh
**/
@isTest
public class BillingCalloutServiceMock  implements WebServiceMock{
   //Implement mock callout here
	public Void doInvoke(Object stub, Object soapRequest,
			Map<String,Object> responseMap, String endpoint,
			String soapAction, String requestName,
			String responseNamespace, String responseName,
			String responseType){
		BillingServiceProxy.billProjectResponse_element res = new BillingServiceProxy.billProjectResponse_element();
		res.status = 'OK';
		responseMap.put('response_x', res);
	}
}