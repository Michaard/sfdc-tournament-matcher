public abstract class TM_Match {
    @AuraEnabled public Integer matchNr { get; private set; }
    @AuraEnabled public Boolean isRematchable { get; private set; }
    @AuraEnabled public Boolean isResolved { get; private set; }
    @AuraEnabled public Integer contestantAScore1 { get; private set; }
    @AuraEnabled public Integer contestantAScore2 { get; private set; }
    @AuraEnabled public Integer contestantBScore1 { get; private set; }
    @AuraEnabled public Integer contestantBScore2 { get; private set; }

    public TM_Match(Integer matchNr, Boolean isRematchable) {
        this.matchNr = matchNr;
        this.isRematchable = isRematchable;
        this.isResolved = false;
    }

    protected void setMatchResult(Integer contestantAScore, Integer contestantBScore) {
        if (contestantAScore != null && contestantBScore != null) {
            if (this.contestantAScore1 == null || this.contestantBScore1 == null) {
                this.setFirstMatchScore(contestantAScore, contestantBScore);
            } else {
                this.setSecondMatchScore(contestantAScore, contestantBScore);
            }
        }
    }

    private void setFirstMatchScore(Integer contestantAScore, Integer contestantBScore) {
        if (!this.isResolved) {
            this.contestantAScore1 = contestantAScore;
            this.contestantBScore1 = contestantBScore;
            if (!this.isRematchable) {
                this.isResolved = true;
            }
        }
    }

    private void setSecondMatchScore(Integer contestantAScore, Integer contestantBScore) {
        if (!this.isResolved && this.isRematchable) {
            this.contestantAScore2 = contestantAScore;
            this.contestantBScore2 = contestantBScore;
            this.isResolved = true;
        }
    }

    public String toJson() {
        return JSON.serialize(this);
    }
}