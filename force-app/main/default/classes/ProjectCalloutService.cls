/**
 * @description       : 
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-27-2024
**/
public class ProjectCalloutService {
    public static Map<String, Object> bodyMap;
    //Complete the implementation for business and callout logic
    @InvocableMethod(label='' 
            description='' 
            category='Opportunity')
	public static void postOpportunityToPMS(List<Id> oppIdsList){
        List<id> jobIdLists = new List<id>();
        List<Opportunity> oppList = [SELECT Id,
                                                Name,
                                                Account.Name,
                                                CloseDate,
                                                Amount
                                            FROM Opportunity
                                            WHERE Id IN:oppIdsList
                                            WITH SECURITY_ENFORCED];

        for(Opportunity opp:oppList){
            bodyMap = new Map<String, Object>();
            bodyMap.put('opportunityId', opp.Id);
            bodyMap.put('opportunityName', opp.Name);
            bodyMap.put('accountName', opp.Account.Name);
            bodyMap.put('closeDate', opp.CloseDate);
            bodyMap.put('amount', opp.Amount);

            Id jobId = System.enqueueJob(new QueueablePMSCall());
            jobIdLists.add(jobId);
        }


        for(AsyncApexJob jobInfo:[SELECT Status, NumberOfErrors FROM AsyncApexJob WHERE Id=:jobIdLists]){
            if(jobInfo.Status != 'Queued'){
                System.debug(jobInfo);
            }
        }
    }
    class QueueablePMSCall implements Queueable, Database.AllowsCallouts {
        private Map<String, Object> bodyMap = ProjectCalloutService.bodyMap;
        public void execute(QueueableContext qc) {
            //do callout, build body and keep incremental count
            //if you hit 100, enqueue another job to run to finish the rest
            //Pass in maps and where you left off
            ServiceTokens__c servToken = ServiceTokens__c.getValues('ProjectServiceToken');

            //Define the callout
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            System.debug(JSON.serialize(bodyMap));
            req.setBody(JSON.serialize(bodyMap));
            req.setEndpoint('callout:ProjectService');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('token', servToken.Token__c);
            req.setTimeout(120000);
            System.debug(req);

            //Make the callout
            HttpResponse res = http.send(req);

            Opportunity opp = new Opportunity(Id=(Id) bodyMap.get('opportunityId'));
            if(res.getStatusCode() != 200){
                System.debug('Something went wrong - '+res.getStatus());
                System.debug('StatusCode - '+res.getStatusCode());
                System.debug('Body - '+res.getBody());
                opp.StageName = 'Resubmit Project';
            }else{
                opp.StageName = 'Submitted Project';
            }
            update opp;
        }
    }
}