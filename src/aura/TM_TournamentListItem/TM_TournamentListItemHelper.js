({
    fireTournamentSelectedEvent : function(component) {
        let tournamentSelectedEvent = $A.get("e.c:TM_TournamentSelectedEvent");
        if (tournamentSelectedEvent) {
            let tournamentId = component.get("v.tournament").id;
            tournamentSelectedEvent.setParam("tournamentId", tournamentId);
            tournamentSelectedEvent.fire();
        }
    }
})