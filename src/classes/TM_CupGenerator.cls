public class TM_CupGenerator extends TM_PhaseGenerator {
    private static final Set<Integer> VALID_NUMBER_OF_PARTICIPANTS = new Set<Integer> {
            2, 4, 8, 16
    };
    private List<TM_CupMatch> cupMatches;
    private integer currentMatchNr;

    public TM_CupGenerator(List<String> items, Boolean generateRematches) {
        super(items, generateRematches);
    }

    public override List<Object> generate() {
        if (this.areItemsValid()) {
            this.shuffleItems();
            this.buildMatches();
            return this.cupMatches;
        } else {
            throw new TM_CupGeneratorException(System.Label.TM_InvalidParticipantsData);
        }
    }

    public override String toJson() {
        if (this.cupMatches != null) {
            return JSON.serialize(this.cupMatches);
        } else {
            return null;
        }
    }

    protected override Boolean areItemsValid() {
        return this.isNumberInSet(this.items.size(), VALID_NUMBER_OF_PARTICIPANTS);
    }

    private void buildMatches() {
        this.currentMatchNr = 0;
        Integer participantIndex = 0;
        Integer numberOfItems = this.items.size();
        this.cupMatches = new List<TM_CupMatch>();
        while (participantIndex < numberOfItems) {
            String itemA = this.items.get(participantIndex++);
            String itemB = this.items.get(participantIndex++);
            TM_StandardMatchContestant contestantA = new TM_StandardMatchContestant(itemA);
            TM_StandardMatchContestant contestantB = new TM_StandardMatchContestant(itemB);

            this.cupMatches.add(new TM_CupMatch(this.currentMatchNr++, this.generateRematches, contestantA, contestantB));
        }

        List<TM_CupMatch> roundMatches = this.cupMatches.clone();
        while (roundMatches != null) {
            roundMatches = this.buildNextRoundMatches(roundMatches);
            if (roundMatches != null) {
                this.cupMatches.addAll(roundMatches);
            }
        }
    }

    private List<TM_CupMatch> buildNextRoundMatches(List<TM_CupMatch> previousRoundMatches) {
        List<TM_CupMatch> roundMatches = new List<TM_CupMatch>();
        Integer matchIndex = 0;
        Integer numberOfMatches = previousRoundMatches.size();
        if (numberOfMatches > 1) {
            while (matchIndex < numberOfMatches) {
                TM_CupMatch previousMatchA = previousRoundMatches.get(matchIndex++);
                TM_CupMatch previousMatchB = previousRoundMatches.get(matchIndex++);

                roundMatches.add(new TM_CupMatch(this.currentMatchNr++, this.generateRematches, previousMatchA, previousMatchB));
            }
            return roundMatches;
        } else {
            return null;
        }
    }

    public class TM_CupGeneratorException extends Exception {}
}