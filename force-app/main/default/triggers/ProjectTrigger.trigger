/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-29-2024
**/

trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here
    BillingCalloutService.callBillingService(Trigger.oldMap, Trigger.newMap);
}