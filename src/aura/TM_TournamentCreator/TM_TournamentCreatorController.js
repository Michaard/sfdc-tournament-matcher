({
    onInit : function(component, event, helper) {
        helper.init(component);
    },

    onNextClick : function(component, event, helper) {
        helper.incrementStage(component);
    },

    onBackClick : function(component, event, helper) {
        helper.decrementStage(component);
    },

    onCancelClick : function(component, event, helper) {
        sessionStorage.clear();
        component.set("v.stage", "1");
        alert("Closing the window and clearing storage data");
    }
})