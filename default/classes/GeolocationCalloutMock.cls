@isTest
public class GeolocationCalloutMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"place_id":"240388264","osm_type":"node","osm_id":"3401391999","boundingbox":["12.8167936","13.1367936","77.430082","77.750082"],"lat":"12.9767936","lon":"77.590082","display_name":"Bengaluru, Bangalore North, Bengaluru Urban, Karnataka, 560001, India","class":"place","type":"city","importance":0.7492415344580502}]');
       	res.setStatus('Ok');
        return res;
    }
}