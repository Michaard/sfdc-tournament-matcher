public class TM_GroupMatch extends TM_Match {
    @AuraEnabled public TM_GroupMatchContestant contestantA { get; private set; }
    @AuraEnabled public TM_GroupMatchContestant contestantB { get; private set; }

    public TM_GroupMatch(Integer matchNr, Boolean isRematchable, TM_GroupMatchContestant contestantA, TM_GroupMatchContestant contestantB) {
        super(matchNr, isRematchable);
        this.contestantA = contestantA;
        this.contestantB = contestantB;
    }

    public void setGroupMatchResult(Integer contestantAScore, Integer contestantBScore, Integer winPoints, Integer drawPoints, Integer losePoints) {
        if (!this.isResolved) {
            this.setMatchResult(contestantAScore, contestantBScore);
            this.contestantA.setAccount(contestantAScore, contestantBScore);
            this.contestantB.setAccount(contestantBScore, contestantAScore);
            if (contestantAScore != null && contestantBScore != null) {
                if (contestantAScore > contestantBScore) {
                    contestantA.setMatchResult(winPoints, TM_Utils.MATCH_RESULT_WIN);
                    contestantB.setMatchResult(losePoints, TM_Utils.MATCH_RESULT_LOSE);
                } else if (contestantAScore < contestantBScore) {
                    contestantA.setMatchResult(losePoints, TM_Utils.MATCH_RESULT_LOSE);
                    contestantB.setMatchResult(winPoints, TM_Utils.MATCH_RESULT_WIN);
                } else {
                    contestantA.setMatchResult(drawPoints, TM_Utils.MATCH_RESULT_DRAW);
                    contestantB.setMatchResult(drawPoints, TM_Utils.MATCH_RESULT_DRAW);
                }
            }
        }
    }
}