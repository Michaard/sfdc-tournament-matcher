public class TM_PhaseGeneratorFactory {
    public static TM_PhaseGenerator getGenerator(String generatorType, List<String> items, Integer numberOfGroups, Boolean withRematches) {
        if (generatorType == System.Label.TM_Label_Cup) {
            return new TM_CupGenerator(items, withRematches);
        } else if (generatorType == System.Label.TM_Label_Cup_Groups) {
            return new TM_GroupGenerator(items, numberOfGroups, withRematches);
        } else {
            return null;
        }
    }
}