public class TM_TournamentType {
    @AuraEnabled public String label;
    @AuraEnabled public String value;

    public TM_TournamentType(String label, String value) {
        this.label = label;
        this.value = value;
    }

    public TM_TournamentType(Schema.PicklistEntry picklistEntry) {
        this.label = picklistEntry.label;
        this.value = picklistEntry.value;
    }

    public static List<TM_TournamentType> getPicklistValues() {
        Schema.DescribeFieldResult typeField = Tournament__c.Type__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = typeField.getPicklistValues();

        List<TM_TournamentType> result = new List<TM_TournamentType>();
        for (Schema.PicklistEntry picklistValue : picklistValues) {
            result.add(new TM_TournamentType(picklistValue));
        }

        return result;
    }
}