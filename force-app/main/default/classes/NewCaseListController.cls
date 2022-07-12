public with sharing class NewCaseListController {
    private List<Case> caseList {get; set;}
    public List<Case> getNewCases(){
        caseList = [SELECT Id,CaseNumber FROM Case WHERE Status='New'];
        return caseList;
    }
}