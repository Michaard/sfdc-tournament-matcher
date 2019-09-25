public class TM_TournamentCreatorController {
    @AuraEnabled
    public static List<TM_TournamentType> getTournamentTypePicklistValues() {
        return TM_TournamentType.getPicklistValues();
    }

    @AuraEnabled
    public static String generateGroups(String participants, Integer numberOfGroups, Boolean withRematches) {
        List<String> itemsToGroup = participants.split('\n');
        TM_GroupGenerator generator = new TM_GroupGenerator(itemsToGroup, numberOfGroups, withRematches);
        generator.generate();
        return generator.toJson();
    }
}