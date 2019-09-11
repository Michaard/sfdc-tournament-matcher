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

    retrieveTournaments : function(component) {
        let action = component.get("c.getTournaments");

        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let tournaments = response.getReturnValue();
                component.set("v.allTournaments", tournaments);
                component.set("v.filteredTournaments", tournaments);
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

    filterTournaments : function(component) {
        let tournamentNameFilter = component.get("v.tournamentNameFilter");
        let tournamentTypeFilter = component.get("v.tournamentTypeFilter");
        let tournaments = component.get("v.allTournaments");

        let nameRegex = new RegExp("\\b" + tournamentNameFilter, "i");
        tournaments = tournaments.filter(row => nameRegex.test(row.name));
        if (tournamentTypeFilter) {
            let typeRegex = new RegExp("^" + tournamentTypeFilter.replace(/\(|\)/g, ""), "g");
            tournaments = tournaments.filter(row => typeRegex.test(row.type.replace(/\(|\)/g, "")));
        }
        component.set("v.filteredTournaments", tournaments);
    },

    setSelectedTournament : function(component, selectedTournamentId) {
        component.set("v.showSpinner", true);
        let tournaments = component.get("v.allTournaments");
        let tournamentsNumber = tournaments.length;
        for (let i = 0; i < tournamentsNumber; i++) {
            if (tournaments[i].id == selectedTournamentId) {
                tournaments[i].isSelected = true;
            } else {
                tournaments[i].isSelected = false;
            }
        }

        component.set("v.allTournaments", tournaments);
        this.filterTournaments(component);
        component.set("v.showSpinner", false);
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