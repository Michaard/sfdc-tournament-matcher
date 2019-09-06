public abstract class TM_MatchContestant {
    @AuraEnabled public String name { get; private set; }
    @AuraEnabled public Integer account { get; private set; }

    public TM_MatchContestant(String name) {
        this.name = name;
        this.account = 0;
    }

    public String toJson() {
        return JSON.serialize(this);
    }

    public void setAccount(Integer winPoints, Integer losePoints) {
        this.account += winPoints - losePoints;
    }
}