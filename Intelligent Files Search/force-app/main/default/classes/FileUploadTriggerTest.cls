@isTest
private class FileUploadTriggerTest {
    @isTest
    static void testFileUploadTrigger() {
        // Create test 
        List<ContentVersion> testContentVersions = new List<ContentVersion>{
            new ContentVersion(
                Title = 'Test File 1',
                VersionData = Blob.valueOf('Test file content'),
                PathOnClient = 'test_file_1.txt',
                parent_id__c = null
            ),
            new ContentVersion(
                Title = 'Another Test File',
                VersionData = Blob.valueOf('Another test file content'),
                PathOnClient = 'test_file_2.txt',
                parent_id__c = 'SomeParentId'
            )
        };
        insert testContentVersions;

        // mock response for http
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Start test
        Test.startTest();

        // Insert CV records

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