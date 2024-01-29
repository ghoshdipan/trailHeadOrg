/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-29-2024
 * @last modified by  : Dipan Ghosh
**/
@isTest
private class BillingCalloutServiceTest {
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

		Project__c proj = new Project__c();
		proj.Name = 'Test Project';
		proj.Opportunity__c = opp.Id;
		proj.Start_Date__c = Date.today();
		proj.End_Date__c = Date.today().addDays(180);
		proj.Billable_Amount__c = 1500;
		proj.ProjectRef__c = 'https://trailhead.salesforce.com/content/learn/sup';
		insert proj;

		ServiceCredentials__c servCreds = new ServiceCredentials__c();
		servCreds.Name = 'BillingServiceCredential';	
		servCreds.Username__c = 'testuserName';
		servCreds.Password__c = 'testPass';
		insert servCreds;
	}

	@isTest
	static void testSuccess() {
		// Test data setup
		Project__c proj = [SELECT Id FROM Project__c LIMIT 1];
		proj.Status__c = 'Billable';

		// Actual test
		Test.startTest();
		Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
		update proj;
		Test.stopTest();
	
		// Asserts
		Project__c projUpdated = [SELECT Id,Status__c FROM Project__c LIMIT 1];
		System.assertEquals('Billable', projUpdated.Status__c, 'error');
	}

	@isTest
	static void testFailure() {
		// Test data setup
		Project__c proj = [SELECT Id FROM Project__c LIMIT 1];
		proj.Status__c = 'Running';

		// Actual test
		Test.startTest();
		Test.setMock(WebServiceMock.class, new BillingCalloutServiceMockFailure());
		update proj;
		Test.stopTest();
	
		// Asserts
		Project__c projUpdated = [SELECT Id,Status__c FROM Project__c LIMIT 1];
		System.assertEquals('Running', projUpdated.Status__c, 'error');
	}
}