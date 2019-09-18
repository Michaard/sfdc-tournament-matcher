({
    init : function(component) {
        component.set("v.showSpinner", true);
        this.loadTournamentData(component);
        this.loadPhaseData(component);
        component.set("v.showSpinner", false);
    },

    loadTournamentData : function(component) {
        let tournamentJson = sessionStorage.getItem("tournament");
        if (tournamentJson) {
            let tournament = JSON.parse(tournamentJson);
            let participantsList = tournament.participants.split("\n");
            component.set("v.participantsList", participantsList);
            component.set("v.tournamentData", tournament);
        }
    },

    loadPhaseData : function(component) {
        let phaseJson = sessionStorage.getItem("tournamentPhase");
        if (phaseJson) {
            let phase = JSON.parse(phaseJson);
            component.set("v.phaseData", phase);
        }
    }
})