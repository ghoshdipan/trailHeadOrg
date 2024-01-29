/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-28-2024
 * @last modified by  : Dipan Ghosh
**/
@isTest
private class ProjectRESTServiceTest {
	@TestSetup
	static void testSetup(){
		Account acc = new Account(Name='Test Acc');
		insert acc;

		Opportunity opp = new Opportunity();
		opp.Name = 'Test class Opp';
		opp.StageName = 'Qualification';
		opp.AccountId = acc.Id;
		opp.CloseDate = Date.today().addDays(150);
		opp.Amount = 2040;
		insert opp;
	}

	@isTest
	static void tesSuccess() {
		// Test data setup
		List<Opportunity> oppList = [SELECT Id FROM Opportunity];

		RestRequest request = new RestRequest();
        request.httpMethod = 'POST';
        request.requestURI = '/services/apexrest/project';
        
        RestContext.request = request;

		// Actual test
		String res;
		Test.startTest();
		res = ProjectRESTService.postProjectData('ref test', 'test project name', oppList[0].Id, Date.today(), Date.today().addDays(150), 1000, 'Billable');
		Test.stopTest();
	
		// Asserts
		List<Project__c> projList = [SELECT Id FROM Project__c];
		System.assertEquals(1, projList.size(), 'Error!');
		System.assertEquals('OK', res, 'Error!');
	}

	@isTest
	static void tesFail() {
		// Test data setup
		RestRequest request = new RestRequest();
        request.httpMethod = 'POST';
        request.requestURI = '/services/apexrest/project';
        
        RestContext.request = request;

		String res;
		// Actual test
		Test.startTest();
		res=ProjectRESTService.postProjectData('ref test', 'test project name', 'null', Date.today(), Date.today().addDays(150), 1000, 'Billable');
		Test.stopTest();
	
		// Asserts
		System.assertEquals('Invalid id: null', res, 'Error!');
	}
}