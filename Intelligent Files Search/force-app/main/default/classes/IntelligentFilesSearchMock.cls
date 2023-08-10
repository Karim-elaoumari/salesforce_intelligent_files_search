@isTest
public class IntelligentFilesSearchMock implements HttpCalloutMock {
    private Integer statusCode;
    private String responseBody;
    public IntelligentFilesSearchMock(Integer statusCode, String responseBody) {
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }

    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(statusCode);
        response.setBody(responseBody);
        return response;
    }
}