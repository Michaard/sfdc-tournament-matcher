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
                    this.showToastAlert(component, "error", $A.get("$Label.c.Label_Error"), errors[0].message);
                }
            }
            component.set("v.showSpinner", false);
        });

        $A.enqueueAction(action);
        component.set("v.showSpinner", true);
    },

    retrieveTournaments : function(component) {
        let tournamentNameFilter = component.get("v.tournamentNameFilter");
        let tournamentTypeFilter = component.get("v.tournamentTypeFilter");

        let action = component.get("c.getTournaments");
        action.setParams({
            "tournamentName": tournamentNameFilter,
            "tournamentType": tournamentTypeFilter
        });

        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let tournaments = response.getReturnValue();
                component.set("v.tournaments", tournaments);
                let selectedTournamentId = component.get("v.selectedTournamentId");
                this.setSelectedTournament(component, selectedTournamentId);
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

    setSelectedTournament : function(component, selectedTournamentId) {
        component.set("v.selectedTournamentId", selectedTournamentId);
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