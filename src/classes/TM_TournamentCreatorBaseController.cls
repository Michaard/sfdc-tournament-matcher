public class TM_TournamentCreatorBaseController {
    @AuraEnabled
    public static List<TM_TournamentType> getTournamentTypePicklistValues() {
        return TM_TournamentType.getPicklistValues();
    }
}