public class TM_CupMatch extends TM_Match {
    @AuraEnabled public TM_CupMatch previousMatchA { get; private set; }
    @AuraEnabled public TM_CupMatch previousMatchB { get; private set; }
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
        this.previousMatchA = previousMatchA;
        this.previousMatchB = previousMatchB;
        this.setContestants();
    }

    public void setCupMatchResult(Integer contestantAScore, Integer contestantBScore) {
        this.setMatchResult(contestantAScore, contestantBScore);

        if (this.isResolved) {
            this.determineWinner();
        }
    }

    public void setContestants() {
        this.setContestantA();
        this.setContestantB();
    }

    private void setContestantA() {
        if (this.previousMatchA != null && this.previousMatchA.winner != null) {
            this.contestantA = this.previousMatchA.winner;
        }
    }

    private void setContestantB() {
        if (this.previousMatchB != null && this.previousMatchB.winner != null) {
            this.contestantB = this.previousMatchB.winner;
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