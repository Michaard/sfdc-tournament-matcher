public class TM_TournamentListController {
    private static final String ICON_CUP = 'standard:opportunity';
    private static final String ICON_CWG = 'standard:strategy';
    private static final String ICON_BR = 'standard:environment_hub';
    private static final String ICON_LEAGUE = 'standard:action_list_component';

    private static final Map<String, String> TYPE_TO_ICON_MAP = new Map<String, String> {
            System.Label.TM_Label_Cup => ICON_CUP,
            System.Label.TM_Label_Cup_Groups => ICON_CWG,
            System.Label.TM_Label_Battle_Royale => ICON_BR,
            System.Label.TM_Label_League => ICON_LEAGUE
    };

    @AuraEnabled
    public static List<TM_TournamentType> getTournamentTypePicklistValues() {
        List<TM_TournamentType> tournamentTypes = TM_TournamentType.getPicklistValues();
        List<TM_TournamentType> result = new List<TM_TournamentType>();
        result.add(new TM_TournamentType(System.Label.Value_All, ''));
        result.addAll(tournamentTypes);
        return result;
    }

    @AuraEnabled
    public static List<TM_TournamentListController.Tournament> getTournaments(String tournamentName, String tournamentType) {
        List<Tournament__c> tournaments = getTournamentsData(tournamentName, tournamentType);
        return fetchTournamentData(tournaments);
    }

    private static List<TM_TournamentListController.Tournament> fetchTournamentData(List<Tournament__c> tournaments) {
        List<TM_TournamentListController.Tournament> result = new List<TM_TournamentListController.Tournament>();
        for (Tournament__c tournament : tournaments) {
            result.add(new TM_TournamentListController.Tournament(tournament));
        }

        return result;
    }

    private static List<Tournament__c> getTournamentsData(String tournamentName, String tournamentType) {
        String query = 'SELECT Id, Name, Type__c FROM Tournament__c';
        Boolean isWhereAdded = false;
        if (String.isNotBlank(tournamentName)) {
            isWhereAdded = true;
            query += ' WHERE (Name LIKE \'' + String.escapeSingleQuotes(tournamentName) + '%\'';
            query += ' OR Name LIKE \'% ' + String.escapeSingleQuotes(tournamentName) + '%\')';
        }
        if (String.isNotBlank(tournamentType) && tournamentType != System.Label.Value_All) {
            query += isWhereAdded ? ' AND ' : ' WHERE ';
            query += 'Type__c = \'' + tournamentType + '\'';
        }
        return Database.query(query);
    }

    private class Tournament {
        @AuraEnabled public String id;
        @AuraEnabled public String name;
        @AuraEnabled public String type;
        @AuraEnabled public String iconName;

        public Tournament(Tournament__c tournament) {
            this.id = tournament.Id;
            this.name = tournament.Name;
            this.type = tournament.Type__c;
            this.iconName = TYPE_TO_ICON_MAP.get(tournament.Type__c);
        }
    }
}