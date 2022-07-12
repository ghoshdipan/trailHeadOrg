trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> taskList = new List<Task>();

    for(Opportunity o : [SELECT Id,OwnerId FROM Opportunity 
                                    WHERE StageName ='Closed Won' 
                                    AND Id IN: Trigger.New]){
        taskList.add(new Task(Subject='Follow Up Test Task',
                            WhatId=o.Id, OwnerId=o.OwnerId,
                            Status='In Progress'));
    }

    if(taskList.size() > 0){
        insert taskList;
    }
}