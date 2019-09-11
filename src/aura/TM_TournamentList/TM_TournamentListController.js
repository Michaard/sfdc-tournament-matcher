({
    onInit : function(component, event, helper) {
        helper.retrieveTournaments(component);
        helper.retrieveTournamentTypes(component);
    },

    onFilterFieldChange : function(component, event, helper) {
        helper.filterTournaments(component);
    },

    handleTournamentSelectedEvent : function(component, event, helper) {
        let selectedTournamentId = event.getParam("tournamentId");
        helper.setSelectedTournament(component, selectedTournamentId);
    }
})