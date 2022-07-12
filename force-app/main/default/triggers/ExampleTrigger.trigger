trigger ExampleTrigger on Contact (after insert, after delete) {
    if (Trigger.isInsert) {
        Integer recordCount = Trigger.New.size();
        // Call a utility method from another class
        EmailManager.sendMail('dipan.ghosh@cloudkaptan.com', 'Trailhead Trigger Tutorial', 
                    recordCount + ' contact(s) were inserted.');
    }
    else if (Trigger.isDelete) {
        Integer oldRecordCount = Trigger.Old.size();
        // Process after delete
        EmailManager.sendMail('dipan.ghosh@cloudkaptan.com', 'Trailhead Trigger Tutorial', 
        oldRecordCount + ' contact(s) were deleted.');
    }
}