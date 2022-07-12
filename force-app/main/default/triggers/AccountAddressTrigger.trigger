trigger AccountAddressTrigger on Account (before insert, before update) {
    System.debug(Trigger.New);
    for(Account acc:Trigger.New){
        if(acc.Match_Billing_Address__c){
            acc.ShippingStreet = acc.BillingStreet;
            acc.ShippingCity = acc.BillingCity;
            acc.ShippingState = acc.BillingState;
            acc.ShippingPostalCode = acc.BillingPostalCode;
            acc.ShippingCountry = acc.BillingCountry;
        }
    }
}