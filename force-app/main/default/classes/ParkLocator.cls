public class ParkLocator {
    public static String[] country(String cou) {
        ParkService.ParksImplPort country = new ParkService.ParksImplPort();
        return country.byCountry(cou);
    }
}