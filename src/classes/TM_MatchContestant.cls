public abstract class TM_MatchContestant {
    @AuraEnabled public String name { get; private set; }

    public TM_MatchContestant(String name) {
        this.name = name;
    }

    public String toJson() {
        return JSON.serialize(this);
    }
}