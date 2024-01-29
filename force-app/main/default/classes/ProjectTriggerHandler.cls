/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-29-2024
**/

public with sharing class ProjectTriggerHandler {
    public void createInvoice(List<Project__c> projectList){
        List<Invoice> invList = new List<Invoice>();
        for(Project__c project:projectList){
            if(project.Status__c.equals('Billable')){
                Invoice inv = new Invoice();
                inv.InvoiceDate = project.Start_Date__c;
                inv.DueDate = project.End_Date__c;
                inv.Description = project.ProjectRef__c;
                // inv.Balance = project.Billable_Amount__c;
                invList.add(inv);
            }
        }
        Database.insert(invList, false, AccessLevel.USER_MODE);
    }
}