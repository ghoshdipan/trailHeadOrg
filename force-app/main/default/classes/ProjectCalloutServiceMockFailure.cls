/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-28-2024
 * @last modified by  : Dipan Ghosh
**/
public class ProjectCalloutServiceMockFailure implements HttpCalloutMock{
   //Implement http mock callout failure here 
   public HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
		res.setHeader('Content-Type', 'application/json');
		res.setBody('{"opportunityId":"0065h00000PJLZsAAP","opportunityName":"Edge Installation","accountName":"Edge Communications","closeDate":"2024-08-25","amount":50000}');
		res.setStatusCode(501);
		return res;
	}
}