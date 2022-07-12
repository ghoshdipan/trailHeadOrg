@isTest
public with sharing class AccountTriggerTest {
    @isTest
    static void testTestCase() {
        // Test data setup
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=200;i++){
            Account acc = new Account(
                Name = 'Test Acc'+i,
                BillingState = 'CA'
            );
            accList.add(acc);
        }

        // Actual test
        Test.startTest();
        insert accList;
        Test.stopTest();

        // Asserts
        List<Account> verifyAccts = [SELECT Id,ShippingState FROM Account];
        System.assertEquals(200, verifyAccts.size(),'ERROR'); 
        for(Account acc : verifyAccts){
            System.assertEquals('CA', acc.ShippingState,'ERROR'); 
        }   
    }
}