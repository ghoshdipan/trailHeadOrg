@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substringBetween('Accounts/', '/contacts');
        return [SELECT Id, Name, ( SELECT Id, Name FROM Contacts ) FROM Account WHERE Id =: accId];
    }
}