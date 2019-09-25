({
    init : function(component) {
        component.set("v.showSpinner", true);
        this.loadTournamentData(component);
        this.loadPhaseData(component);
        this.determineMaxNumberOfGroups(component);
        component.set("v.showSpinner", false);
    },

    determineMaxNumberOfGroups : function(component) {
        let numberOfGroups = [{label: "2", value: "2"}];
        let numberOfParticipants = component.get("v.numberOfParticipants");
        if (numberOfParticipants >= 8) {
            numberOfGroups.push({label: "4", value: "4"});
        }
        if (numberOfParticipants >= 16) {
            numberOfGroups.push({label: "8", value: "8"});
        }
        if (numberOfParticipants >= 32) {
            numberOfGroups.push({label: "16", value: "16"});
        }

        component.set("v.numberOfGroupsList", numberOfGroups);
    },

    loadTournamentData : function(component) {
        let tournamentJson = sessionStorage.getItem($A.get("$Label.c.TM_TournamentSessionKey"));
        if (tournamentJson) {
            let tournament = JSON.parse(tournamentJson);
            component.set("v.tournamentType", tournament.type);
            component.set("v.numberOfParticipants", tournament.participants.split("\n").length);
        }
    },

    loadPhaseData : function(component) {
        let tournamentPhaseJson = sessionStorage.getItem($A.get("$Label.c.TM_TournamentPhaseSessionKey"));
        if (tournamentPhaseJson) {
            let tournamentPhase = JSON.parse(tournamentPhaseJson);
            component.set("v.allowDraws", tournamentPhase.allowDraws);
            component.set("v.withRematches", tournamentPhase.withRematches);
            component.set("v.thirdPlaceMatch", tournamentPhase.thirdPlaceMatch);
            component.set("v.pointsPerVictory", tournamentPhase.pointsPerVictory);
            component.set("v.pointsPerDraw", tournamentPhase.pointsPerDraw);
            component.set("v.pointsPerLose", tournamentPhase.pointsPerLose);
            component.set("v.numberOfGroups", tournamentPhase.numberOfGroups);
        }
    },

    savePhaseData : function(component) {
        let allowDraws = component.get("v.allowDraws");
        let withRematches = component.get("v.withRematches");
        let thirdPlaceMatch = component.get("v.thirdPlaceMatch");
        let pointsPerVictory = component.get("v.pointsPerVictory");
        let pointsPerDraw = component.get("v.pointsPerDraw");
        let pointsPerLose = component.get("v.pointsPerLose");
        let numberOfGroups = component.get("v.numberOfGroups");

        let tournamentPhase = {
            allowDraws: allowDraws,
            withRematches: withRematches,
            thirdPlaceMatch: thirdPlaceMatch,
            pointsPerVictory: pointsPerVictory,
            pointsPerDraw: pointsPerDraw,
            pointsPerLose: pointsPerLose,
            numberOfGroups: numberOfGroups
        };

        sessionStorage.setItem($A.get("$Label.c.TM_TournamentPhaseSessionKey"), JSON.stringify(tournamentPhase));
    }
})