({
    packItem: function(component, event, helper) {
        let btnClicked = event.getSource();

        component.set("v.Packed__c", true);
        component.set("v.disabled", true);
    }
})