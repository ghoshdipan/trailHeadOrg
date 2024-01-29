/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-29-2024
 * @last modified by  : Dipan Ghosh
**/
public class BillingCalloutService {
    private static List<Project__c> projList = new List<Project__c>();
    private final static ServiceCredentials__c BILLING_SERVICE_CREDS = ServiceCredentials__c.getValues('BillingServiceCredential');

    //Implement business and callout logic methods here
    public static void callBillingService(Map <id,Project__c> oldMap, Map <id,Project__c> newMap){
        for(Project__c project:newMap.values()){
            if(oldMap.containsKey(project.Id) && project.Status__c.equals('Billable')){
                projList.add(project);
            }
        }
        if(projList.size() > 0){
            createInvoice();
        }
    }

    @future(callout=true)
    public static void createInvoice() {
        List<Project__c> billableProjList = new List<Project__c>();
        for(Project__c project:projList){
            BillingServiceProxy.project apiInstance = new BillingServiceProxy.project();
            apiInstance.username = BILLING_SERVICE_CREDS.Username__c;
            apiInstance.password = BILLING_SERVICE_CREDS.Password__c;
            apiInstance.projectid = project.Id;
            apiInstance.billAmount = project.Billable_Amount__c;

            BillingServiceProxy.InvoicesPortSoap11 invAPI = new BillingServiceProxy.InvoicesPortSoap11();
            String resStatus = invAPI.billProject(apiInstance);
            if(resStatus == 'OK'){
                Project__c newProject = new Project__c(Id=project.Id);
                newProject.Status__c = 'Billed';
                billableProjList.add(newProject);
            }
        }
        if(billableProjList.size() > 0){
            Database.update(billableProjList, false);
        }
    }
}