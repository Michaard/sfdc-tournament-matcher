({
    toggleHover : function(component, event, helper) {
        let element = event.currentTarget;
        $A.util.toggleClass(element, "slds-theme_shade");
    },

    onTournamentClick : function(component, event, helper) {
        let tournament = component.get("v.tournament");
        if (!tournament.isSelected) {
            helper.fireTournamentSelectedEvent(component);
        }
    }
})