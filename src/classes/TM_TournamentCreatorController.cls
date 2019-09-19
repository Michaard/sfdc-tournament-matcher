public class TM_TournamentCreatorController {
    @AuraEnabled
    public static String generateGroups(String participants, Integer numberOfGroups, Boolean withRematches) {
        try {
            List<String> itemsToGroup = participants.split('\n');
            TM_GroupGenerator generator = new TM_GroupGenerator(itemsToGroup, numberOfGroups, withRematches);
            generator.generate();
            return generator.getGroupsInJson();
        } catch (Exception ex) {
            return null;
        }
    }
}