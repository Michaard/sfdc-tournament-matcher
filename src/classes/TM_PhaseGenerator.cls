public abstract class TM_PhaseGenerator {
    protected List<String> items;
    protected Boolean generateRematches;

    public TM_PhaseGenerator(List<String> items, Boolean generateRematches) {
        this.items = items;
        this.generateRematches = generateRematches;
    }

    public abstract List<Object> generate();
    public abstract String toJson();

    protected List<String> shuffleItems() {
        Integer currentIndex = this.items.size();
        String tempItem;
        Integer randomIndex;

        while (currentIndex != 0) {
            randomIndex = Integer.valueOf(Math.floor(Math.random() * currentIndex));
            currentIndex--;

            tempItem = this.items.get(currentIndex);
            this.items.set(currentIndex, this.items.get(randomIndex));
            this.items.set(randomIndex, tempItem);
        }

        return this.items;
    }

    protected Boolean isNumberInSet(Integer numberToValidate, Set<Integer> validNumbersSet) {
        for (Integer validNumber : validNumbersSet) {
            if (numberToValidate == validNumber) {
                return true;
            }
        }
        return false;
    }

    protected abstract Boolean areItemsValid();
}