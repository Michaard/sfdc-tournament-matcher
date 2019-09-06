public class TM_GroupMatchContestant extends TM_MatchContestant {
    @AuraEnabled public Integer score { get; private set; }
    @AuraEnabled public Integer wins { get; private set; }
    @AuraEnabled public Integer loses { get; private set; }
    @AuraEnabled public Integer draws { get; private set; }
    @AuraEnabled public Integer matchesTaken { get; private set; }

    public TM_GroupMatchContestant(String name) {
        super(name);
        this.score = 0;
        this.wins = 0;
        this.loses = 0;
        this.draws = 0;
        this.matchesTaken = 0;
    }

    public void setMatchResult(Integer scoreIncrementation, Integer result) {
        if (scoreIncrementation != null && result != null) {
            this.score += scoreIncrementation;
            this.incrementStatsBasedOnResult(result);
            this.matchesTaken++;
        }
    }

    private void incrementStatsBasedOnResult(Integer result) {
        if (result == TM_Utils.MATCH_RESULT_WIN) {
            this.wins++;
        } else if (result == TM_Utils.MATCH_RESULT_LOSE) {
            this.loses++;
        } else if (result == TM_Utils.MATCH_RESULT_DRAW) {
            this.draws++;
        }
    }
}