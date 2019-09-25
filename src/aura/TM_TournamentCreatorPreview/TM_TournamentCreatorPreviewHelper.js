({
    init : function(component) {
        component.set("v.showSpinner", true);
        this.loadTournamentData(component);
        this.loadPhaseData(component);
        this.generatePreview(component);
        component.set("v.showSpinner", false);
    },

    generatePreview : function(component) {
        let tournamentType = component.get("v.tournamentData").type;
        let tournamentData = component.get("v.tournamentData");
        let phaseData = component.get("v.phaseData");

        let action = component.get("c.generatePreview");
        action.setParams({
            tournamentType: tournamentType,
            participants: tournamentData.participants,
            numberOfGroups: Number(phaseData.numberOfGroups),
            withRematches: phaseData.withRematches
        });

        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let resultJson = response.getReturnValue();
                if (resultJson) {
                    component.set("v.previewData", JSON.parse(resultJson));
                }
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    this.showToastAlert(component, "error", $A.get("$Label.c.Label_Error"), errors[0].message);
                }
            }
            component.set("v.showSpinner", false);
        });

        $A.enqueueAction(action);
        component.set("v.showSpinner", true);
    },

    loadTournamentData : function(component) {
        let tournamentJson = sessionStorage.getItem($A.get("$Label.c.TM_TournamentSessionKey"));
        if (tournamentJson) {
            let tournament = JSON.parse(tournamentJson);
            let participantsList = tournament.participants.split("\n");
            component.set("v.participantsList", participantsList);
            component.set("v.tournamentData", tournament);
        }
    },

    loadPhaseData : function(component) {
        let phaseJson = sessionStorage.getItem($A.get("$Label.c.TM_TournamentPhaseSessionKey"));
        if (phaseJson) {
            let phase = JSON.parse(phaseJson);
            component.set("v.phaseData", phase);
        }
    },

    showToastAlert : function(component, variant, title, message) {
        let notifLib = component.find("notifLib");
        if (notifLib) {
            notifLib.showToast({
                "variant": variant,
                "title": title,
                "message": message
            });
        }
    }
})