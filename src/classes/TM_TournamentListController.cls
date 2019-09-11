public class TM_TournamentListController {
    private static final String ICON_CUP = 'standard:opportunity';
    private static final String ICON_CWG = 'standard:strategy';
    private static final String ICON_BR = 'standard:environment_hub';
    private static final String ICON_LEAGUE = 'standard:action_list_component';

    private static final Map<String, String> TYPE_TO_ICON_MAP = new Map<String, String> {
            TM_Utils.TOURNAMENT_TYPE_CUP => ICON_CUP,
            TM_Utils.TOURNAMENT_TYPE_CWG => ICON_CWG,
            TM_Utils.TOURNAMENT_TYPE_BR => ICON_BR,
            TM_Utils.TOURNAMENT_TYPE_LEAGUE => ICON_LEAGUE
    };

    @AuraEnabled
    public static List<TM_TournamentListController.TournamentType> getTournamentTypePicklistValues() {
        Schema.DescribeFieldResult typeField = Tournament__c.Type__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = typeField.getPicklistValues();

        List<TM_TournamentListController.TournamentType> result = new List<TM_TournamentListController.TournamentType>();
        for (Schema.PicklistEntry picklistValue : picklistValues) {
            result.add(new TM_TournamentListController.TournamentType(picklistValue));
        }

        return result;
    }

    @AuraEnabled
    public static List<TM_TournamentListController.Tournament> getTournaments() {
        List<Tournament__c> tournaments = getTournamentsData();
        return fetchTournamentData(tournaments);
    }

    private static List<TM_TournamentListController.Tournament> fetchTournamentData(List<Tournament__c> tournaments) {
        List<TM_TournamentListController.Tournament> result = new List<TM_TournamentListController.Tournament>();
        for (Tournament__c tournament : tournaments) {
            result.add(new TM_TournamentListController.Tournament(tournament));
        }

        return result;
    }

    private static List<Tournament__c> getTournamentsData() {
        return [
                SELECT Id, Name, Type__c
                FROM Tournament__c
        ];
    }

    private class Tournament {
        @AuraEnabled public String id;
        @AuraEnabled public String name;
        @AuraEnabled public String type;
        @AuraEnabled public String iconName;
        @AuraEnabled public Boolean isSelected;

        public Tournament(Tournament__c tournament) {
            this.id = tournament.Id;
            this.name = tournament.Name;
            this.type = tournament.Type__c;
            this.iconName = TYPE_TO_ICON_MAP.get(tournament.Type__c);
            this.isSelected = false;
        }
    }

    private class TournamentType {
        @AuraEnabled public String label;
        @AuraEnabled public String value;

        public TournamentType(Schema.PicklistEntry picklistEntry) {
            this.label = picklistEntry.label;
            this.value = picklistEntry.value;
        }
    }
}