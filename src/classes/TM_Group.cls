public class TM_Group {
    @AuraEnabled public String name { get; private set; }
    @AuraEnabled public List<TM_GroupMatchContestant> contestants { get; private set; }
    @AuraEnabled public TM_GroupMatchContestant firstPlace { get; private set; }
    @AuraEnabled public TM_GroupMatchContestant secondPlace { get; private set; }
    @AuraEnabled public Boolean isResolved { get; private set; }
    @AuraEnabled public Boolean isRematchable { get; private set; }
    public Integer numberOfMatchesPerContestant { get; private set; }

    public TM_Group(String name, Boolean isRematchable) {
        this.name = name;
        this.contestants = new List<TM_GroupMatchContestant>();
        this.isResolved = false;
        this.isRematchable = isRematchable;
        this.calculateNumberOfMatchesPerContestant();
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setContestants(List<TM_GroupMatchContestant> contestants) {
        if (contestants != null) {
            this.contestants = contestants;
        }
    }

    public void addContestant(TM_GroupMatchContestant contestant) {
        this.contestants.add(contestant);
        this.calculateNumberOfMatchesPerContestant();
    }

    public Boolean isGroupResolved() {
        this.isResolved = this.getIsGroupResolved();
        return this.isResolved;
    }

    private Boolean getIsGroupResolved() {
        for (TM_GroupMatchContestant contestant : contestants) {
            if (contestant.matchesTaken != this.numberOfMatchesPerContestant) {
                return false;
            }
        }
        return true;
    }

    public String toJson() {
        return JSON.serialize(this);
    }

    private void calculateNumberOfMatchesPerContestant() {
        if (this.contestants != null) {
            Integer numberOfContestants = contestants.size();
            this.numberOfMatchesPerContestant = (numberOfContestants > 0) ? (numberOfContestants - 1) : 0;
            if (this.isRematchable) {
                this.numberOfMatchesPerContestant *= 2;
            }
        }
    }
}