({
    onInit : function(component, event, helper) {
        helper.retrieveTournaments(component);
        helper.retrieveTournamentTypes(component);
    },

    onEnterPress : function(component, event, helper) {
        let enterPressed = event.keyCode === 13;
        if (enterPressed) {
            helper.retrieveTournaments(component);
        }
    },

    onFilterFieldClear : function(component, event, helper) {
        let tournamentNameFilter = component.get("v.tournamentNameFilter");
        if (!tournamentNameFilter) {
            helper.retrieveTournaments(component);
        }
    },

    onFilterFieldChange : function(component, event, helper) {
        helper.retrieveTournaments(component);
    },

    handleTournamentSelectedEvent : function(component, event, helper) {
        let selectedTournamentId = event.getParam("tournamentId");
        helper.setSelectedTournament(component, selectedTournamentId);
    }
})