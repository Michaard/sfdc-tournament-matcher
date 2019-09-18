public class TM_GroupGenerator {
    private static final Integer ASCII_SEED = 65;
    private List<TM_Group> groups;
    private List<String> itemsToGroup;
    private Integer numberOfGroups;
    private Integer currentGroupIndex;

    public TM_GroupGenerator(List<String> itemsToGroup, Integer numberOfGroups) {
        this.itemsToGroup = itemsToGroup;
        this.numberOfGroups = numberOfGroups;
        this.resetCurrentGroupIndex();
    }

    public List<TM_Group> generate() {
        this.generateGroups();
        this.shuffleItems();
        this.assignItemsToGroups();
        return this.groups;
    }

    private void shuffleItems() {
        TM_Utils.shuffleItems(this.itemsToGroup);
    }

    private void generateGroups() {
        this.groups = new List<TM_Group>();
        for (Integer i = 0; i < this.numberOfGroups; i++) {
            String groupName = this.generateGroupName(i);
            this.groups.add(new TM_Group(groupName));
        }
    }

    private void assignItemsToGroups() {
        for (String item : this.itemsToGroup) {
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
}