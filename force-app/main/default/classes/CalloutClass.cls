public class CalloutClass {
    @future(callout=true)
    public static void makeCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://omega13.ppsacanada.com/natomi2/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        
        // Set the body as a JSON object
        request.setBody('<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope"><soap:Header><soap:authentication xmlns:soap="https://omega13.ppsacanada.com/" xmlns="https://omega13.ppsacanada.com/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><key>BPF123:00000000-BE8792E68823-FF7B-44CC2520</key></soap:authentication></soap:Header><soap:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><create_ppsa_registration xmlns="https://omega13.ppsacanada.com/"><create_ppsa_registration><request_type><province>ON</province><subtype>PPSA</subtype></request_type><general><registration_period>2</registration_period><reference>0013I00000mk88MQAQ</reference></general><debtor><debtor><address>680 Robert Street</address><city>St Thomas</city><province>ON</province><country>CA</country><postal_code>N5R 3U8</postal_code><first_name>Harry</first_name><middle_name>X</middle_name><last_name>Houdini</last_name><birth_date>1968-03-25</birth_date></debtor></debtor><secured_party><secured_party><business_name>BridgePoint Financial Services Limited Partnership I</business_name><address>201-133 Richmond Street West</address><city>Toronto</city><province>ON</province><country>CA</country><postal_code>M5H 2L3</postal_code></secured_party></secured_party><general_collateral><general_collateral><text>ALL OF THE DEBTOR\'S RIGHT, TITLE AND INTEREST IN AND TO THE DEBTOR\'S ENTITLEMENT AS BENEFICIARY, PURSUANT TO A WILL, TO A PORTION OF THE ASSETS FORMING THE ESTATE THAT IS THE SUBJECT OF SUCH WILL, INCLUDING, BUT NOT LIMITED TO, ALL MONEY AND PROCEEDS RELATING TO OR DERIVED THEREFROM</text></general_collateral></general_collateral><registering_agent><registering_agent><business_name>BridgePoint Financial Services Limited Partnership I</business_name><address>201-133 Richmond Street West</address><city>Toronto</city><province>ON</province><country>CA</country><postal_code>M5H 2L3</postal_code></registering_agent></registering_agent><classifications><ontario><accounts>true</accounts><other>true</other><no_fixed_date>true</no_fixed_date></ontario></classifications></create_ppsa_registration></create_ppsa_registration></soap:Body></soap:Envelope>');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if(response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
    }
}