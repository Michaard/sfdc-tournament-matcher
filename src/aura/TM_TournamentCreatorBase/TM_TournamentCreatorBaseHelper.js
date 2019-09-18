({
    retrieveTournamentTypes : function(component) {
        let action = component.get("c.getTournamentTypePicklistValues");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let typeValues = response.getReturnValue();
                component.set("v.tournamentTypeValues", typeValues);
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    this.showToastAlert(component, "error", "Error", errors[0].message);
                }
            }
            component.set("v.showSpinner", false);
        });

        $A.enqueueAction(action);
        component.set("v.showSpinner", true);
    },

    loadTournamentData : function(component) {
        let tournamentJson = sessionStorage.getItem("tournament");
        if (tournamentJson) {
            let tournament = JSON.parse(tournamentJson);
            component.set("v.tournamentName", tournament.name);
            component.set("v.tournamentType", tournament.type);
            component.set("v.participants", tournament.participants);
        }
    },

    saveTournamentData : function(component) {
        let name = component.get("v.tournamentName");
        let type = component.get("v.tournamentType");
        let participants = component.get("v.participants");

        let tournament = {
            name: name,
            type: type,
            participants: participants
        };

        sessionStorage.setItem("tournament", JSON.stringify(tournament));
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