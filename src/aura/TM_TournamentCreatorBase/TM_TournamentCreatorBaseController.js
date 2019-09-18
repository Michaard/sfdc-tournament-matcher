({
    onInit : function(component, event, helper) {
        helper.loadTournamentData(component);
        helper.retrieveTournamentTypes(component);
    },

    onSave : function(component, event, helper) {
        helper.saveTournamentData(component);
    }
})