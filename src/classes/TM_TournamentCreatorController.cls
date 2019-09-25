public class TM_TournamentCreatorController {
    private static final String PARTICIPANTS_SEPARATOR = '\n';

    @AuraEnabled
    public static List<TM_TournamentType> getTournamentTypePicklistValues() {
        return TM_TournamentType.getPicklistValues();
    }

    @AuraEnabled
    public static String generatePreview(String tournamentType, String participants, Integer numberOfGroups, Boolean withRematches) {
        List<String> items = parseParticipants(participants);
        TM_PhaseGenerator generator = TM_PhaseGeneratorFactory.getGenerator(tournamentType, items, numberOfGroups, withRematches);
        return generateResult(generator);
    }

    private static String generateResult(TM_PhaseGenerator generator) {
        generator.generate();
        return generator.toJson();
    }

    private static List<String> parseParticipants(String participants) {
        return participants.split(PARTICIPANTS_SEPARATOR);
    }
}