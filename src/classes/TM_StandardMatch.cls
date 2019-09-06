public class TM_StandardMatch extends TM_Match {
    @AuraEnabled public TM_StandardMatchContestant contestantA { get; private set; }
    @AuraEnabled public TM_StandardMatchContestant contestantB { get; private set; }

    public TM_StandardMatch(Integer matchNr, Boolean isRematchable, TM_StandardMatchContestant contestantA, TM_StandardMatchContestant contestantB) {
        super(matchNr, isRematchable);
        this.contestantA = contestantA;
        this.contestantB = contestantB;
    }

    public void setStandardMatchResult(Integer contestantAScore, Integer contestantBScore) {
        if (!this.isResolved) {
            this.setMatchResult(contestantAScore, contestantBScore);
            this.contestantA.setAccount(contestantAScore, contestantBScore);
            this.contestantB.setAccount(contestantBScore, contestantAScore);
        }
    }
}