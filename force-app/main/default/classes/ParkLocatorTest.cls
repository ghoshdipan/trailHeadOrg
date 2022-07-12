@isTest
public class ParkLocatorTest {
    @isTest
    static void testCallout() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        String[] result = ParkLocator.country('India');
        // Verify that a fake result is returned
        System.assertEquals(new String[]{'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Park'}, result, 'Invalid o/p'); 
    }
}