/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-28-2024
**/
@RestResource(urlMapping='/Project/*')
global class ProjectRESTService {
    @HttpPost    
    global static String postProjectData(String projectRef, String projectName,
            String opportunityId, Date startDate, Date endDate, Double amount, String status){
        Savepoint saveRes = Database.setSavepoint();
        String response = 'OK';
        try {
            Opportunity opp = new Opportunity(Id=opportunityId);
            opp.DeliveryInstallationStatus__c = 'In progress';
            
            Project__c proj = new Project__c();
            proj.ProjectRef__c = projectRef;
            proj.Name = projectName;
            proj.Opportunity__c = opportunityId;
            proj.Start_Date__c = startDate;
            proj.End_Date__c = endDate;
            proj.Billable_Amount__c = amount;
            proj.Status__c = status;
            
            if(opportunityId != null){
                update opp;
                upsert proj;
            }
        } catch (Exception e) {
            response = e.getMessage();
            Database.rollback(saveRes);
        }
        return response;
    }
}