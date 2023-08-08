@isTest
private class FilesIntelligentSearchControllerTest {
    @isTest
    static void testIntelligentSearchByTitle() {
        // data
        List<ContentVersion> testContentVersions = new List<ContentVersion>{
            new ContentVersion(
                Title = 'Test File 1',
                VersionData = Blob.valueOf('Test file content'),
                PathOnClient = 'test_file_1.txt'
            ),
            new ContentVersion(
                Title = 'Another Test File',
                VersionData = Blob.valueOf('Another test file content'),
                PathOnClient = 'test_file_2.txt'
            )
        };
        insert testContentVersions;

        // mock response for http
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Start 
        Test.startTest();
        
        // Call intelligentSearch 
        List<ContentVersion> results = FilesIntelligentSearchController.intelligentSearch('Test', 'title', 'all');
        
        // Stop test
        Test.stopTest();

        System.assertEquals(2, results.size());
    }

    @isTest
    static void testIntelligentSearchByFieldsWithIndexedSearch() {
        // mock response for http
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Start 
        Test.startTest();
        
        // intelligentSearch 
        List<ContentVersion> results = FilesIntelligentSearchController.intelligentSearch('Test', 'fields', 'txt');
        
        // Stop
        Test.stopTest();

    }

    @isTest
    static void testIntelligentSearchByTitleAndExtension() {
        // mock response for http
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Start 
        Test.startTest();
        
        // Call the intelligentSearch 
        List<ContentVersion> results = FilesIntelligentSearchController.intelligentSearch('Test', 'some_other_case', 'pdf');
        
        // Stop test
        Test.stopTest();

    }

    // Mock HttpResponse generator
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            
            // Simulate the response from FileUploadTriggerHandler
            Map<String, Object> mockResponse = new Map<String, Object>{

            };
            
            res.setBody(JSON.serialize(mockResponse));
            res.setStatusCode(200);
            return res;
        }
    }
}