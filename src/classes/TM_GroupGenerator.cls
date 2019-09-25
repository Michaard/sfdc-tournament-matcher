public class TM_GroupGenerator extends TM_PhaseGenerator {
    private static final Integer ASCII_SEED = 65;
    private List<TM_Group> groups;
    private Integer numberOfGroups;
    private Integer currentGroupIndex;

    public TM_GroupGenerator(List<String> items, Integer numberOfGroups, Boolean generateRematches) {
        super(items, generateRematches);
        this.numberOfGroups = numberOfGroups;
        this.resetCurrentGroupIndex();
    }

    public override List<Object> generate() {
        if (this.areItemsValid()) {
            this.generateGroups();
            this.shuffleItems();
            this.assignItemsToGroups();
            return this.groups;
        } else {
            throw new TM_GroupGeneratorException(System.Label.TM_InvalidParticipantsData);
        }
    }

    public override String toJson() {
        if (this.groups != null) {
            return JSON.serialize(this.groups);
        } else {
            return null;
        }
    }

    protected override Boolean areItemsValid() {
        Integer numberOfItems = this.items.size();
        if (numberOfItems < 4 || numberOfItems > 64) {
            return false;
        } else if (numberOfItems/this.numberOfGroups < 2) {
            return false;
        }

        return true;
    }

    private void generateGroups() {
        this.groups = new List<TM_Group>();
        for (Integer i = 0; i < this.numberOfGroups; i++) {
            String groupName = this.generateGroupName(i);
            this.groups.add(new TM_Group(groupName, this.generateRematches));
        }
    }

    private void assignItemsToGroups() {
        for (String item : this.items) {
            TM_Group currentGroup = this.getCurrentGroup();
            if (currentGroup != null) {
                currentGroup.addContestant(new TM_GroupMatchContestant(item));
            }
        }
    }

    private String generateGroupName(Integer letterSequence) {
        String groupLetter = String.fromCharArray(new List<Integer> {ASCII_SEED + letterSequence});
        return String.format(System.Label.TM_GroupNamePrefix, new List<String> {groupLetter});
    }

    private TM_Group getCurrentGroup() {
        if (this.groups != null) {
            if (this.currentGroupIndex >= this.numberOfGroups) {
                this.resetCurrentGroupIndex();
            }
            return this.groups.get(this.currentGroupIndex++);
        } else {
            return null;
        }
    }

    private void resetCurrentGroupIndex() {
        this.currentGroupIndex = 0;
    }

    public class TM_GroupGeneratorException extends Exception {}
}