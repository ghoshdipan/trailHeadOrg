/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-28-2024
 * @last modified by  : Dipan Ghosh
**/

@isTest
private class ProjectCalloutServiceTest {
  	//Implement mock callout tests here
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

		ServiceTokens__c servToken = new ServiceTokens__c();
		servToken.Name = 'ProjectServiceToken';	
		servToken.Token__c = '906a6b85-64a9-4f16-a416-d4604e3d75c8';
		insert servToken;
	}

	@isTest
	static void calloutSuccessTest(){
		List<Opportunity> oppList = [SELECT Id FROM Opportunity];

		Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
		Test.startTest();
		ProjectCalloutService.postOpportunityToPMS(new List<Id>{oppList[0].Id});
		Test.stopTest();
	
		List<Opportunity> oppCheckList = [SELECT Id,StageName FROM Opportunity];
		System.assertEquals('Submitted Project', oppCheckList[0].StageName, 'Invalid Opp!');
	}

	@isTest
	static void calloutFailureTest(){
		List<Opportunity> oppList = [SELECT Id FROM Opportunity];

		Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
		Test.startTest();
		ProjectCalloutService.postOpportunityToPMS(new List<Id>{oppList[0].Id});
		Test.stopTest();
	
		List<Opportunity> oppCheckList = [SELECT Id,StageName FROM Opportunity];
		System.assertEquals('Resubmit Project', oppCheckList[0].StageName, 'Invalid Opp!');
	}
}