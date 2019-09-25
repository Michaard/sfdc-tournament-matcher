public class TM_CupMatch extends TM_Match {
    @AuraEnabled public Integer previousMatchANr { get; private set; }
    @AuraEnabled public Integer previousMatchBNr { get; private set; }
    @AuraEnabled public TM_StandardMatchContestant contestantA { get; private set; }
    @AuraEnabled public TM_StandardMatchContestant contestantB { get; private set; }
    @AuraEnabled public TM_StandardMatchContestant winner { get; private set; }

    public TM_CupMatch(Integer matchNr, Boolean isRematchable, TM_StandardMatchContestant contestantA, TM_StandardMatchContestant contestantB) {
        super(matchNr, isRematchable);
        this.contestantA = contestantA;
        this.contestantB = contestantB;
    }

    public TM_CupMatch(Integer matchNr, Boolean isRematchable, TM_CupMatch previousMatchA, TM_CupMatch previousMatchB) {
        super(matchNr, isRematchable);
        this.previousMatchANr = previousMatchA.matchNr;
        this.previousMatchBNr = previousMatchB.matchNr;
    }

    public void setCupMatchResult(Integer contestantAScore, Integer contestantBScore) {
        if (!this.isResolved) {
            this.setMatchResult(contestantAScore, contestantBScore);
            this.contestantA.setAccount(contestantAScore, contestantBScore);
            this.contestantB.setAccount(contestantBScore, contestantAScore);
        }

        if (this.isResolved) {
            this.determineWinner();
        }
    }

    public void setContestants(TM_StandardMatchContestant contestantA, TM_StandardMatchContestant contestantB) {
        this.setContestantA(contestantA);
        this.setContestantB(contestantB);
    }

    private void setContestantA(TM_StandardMatchContestant contestant) {
        if (contestant != null) {
            this.contestantA = contestant;
        }
    }

    private void setContestantB(TM_StandardMatchContestant contestant) {
        if (contestant != null) {
            this.contestantB = contestant;
        }
    }

    private void determineWinner() {
        Integer contestantAFinalScore = this.contestantAScore1;
        Integer contestantBFinalScore = this.contestantBScore1;

        if (this.isRematchable) {
            contestantAFinalScore += this.contestantAScore2;
            contestantBFinalScore += this.contestantBScore2;
        }

        if (contestantAFinalScore > contestantBFinalScore) {
            this.winner = this.contestantA;
        } else if (contestantAFinalScore < contestantBFinalScore) {
            this.winner = this.contestantB;
        }
    }
}