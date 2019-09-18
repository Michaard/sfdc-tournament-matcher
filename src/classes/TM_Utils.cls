public class TM_Utils {
    public static final Integer MATCH_RESULT_DRAW = 0;
    public static final Integer MATCH_RESULT_WIN = 1;
    public static final Integer MATCH_RESULT_LOSE = -1;

    public static final String TOURNAMENT_TYPE_CUP = 'Cup';
    public static final String TOURNAMENT_TYPE_CWG = 'Cup (with groups)';
    public static final String TOURNAMENT_TYPE_BR = 'Battle Royale';
    public static final String TOURNAMENT_TYPE_LEAGUE = 'League';

    public static List<Object> shuffleItems(List<Object> items) {
        Integer currentIndex = items.size();
        Object tempItem;
        Integer randomIndex;

        while (currentIndex != 0) {
            randomIndex = Integer.valueOf(Math.floor(Math.random() * currentIndex));
            currentIndex--;

            tempItem = items.get(currentIndex);
            items.set(currentIndex, items.get(randomIndex));
            items.set(randomIndex, tempItem);
        }

        return items;
    }
}