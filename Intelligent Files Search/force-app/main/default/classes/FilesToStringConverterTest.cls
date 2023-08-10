@isTest
public class FilesToStringConverterTest {

    @isTest
    static void testStartConvert() {

        List<ContentVersion> testContentVersions = new List<ContentVersion>();


        ContentVersion pdfVersion = new ContentVersion();
        pdfVersion.Title = 'Test PDF';
        pdfVersion.PathOnClient = 'test_document.pdf';
        pdfVersion.VersionData = Blob.valueOf('PDF content data');
        insert pdfVersion;
        testContentVersions.add(pdfVersion);

        ContentVersion csvVersion = new ContentVersion();
        csvVersion.Title = 'Test CSV';
        csvVersion.PathOnClient = 'test_data.csv';
        csvVersion.VersionData = Blob.valueOf('Field1,Field2\nValue1,Value2');
        insert csvVersion;
        testContentVersions.add(csvVersion);

        // mock callout
        Test.setMock(HttpCalloutMock.class, new FilesToStringConverterMock());

        // Prepare data 
        Map<Id, String> contentVersionsUrls = new Map<Id, String>();
        contentVersionsUrls.put(pdfVersion.Id, 'mocked_pdf_url');
        contentVersionsUrls.put(csvVersion.Id, null);

        // Call 
        Test.startTest();
        Map<Id, String> result = FilesToStringConverter.startConvert(contentVersionsUrls);
        Test.stopTest();

        // Verify 
        System.assertEquals('Mocked response body', result.get(pdfVersion.Id));

        // csv
        List<List<String>> expectedCsvData = new List<List<String>>();
        expectedCsvData.add(new List<String>{ 'Field1', 'Field2' });
        expectedCsvData.add(new List<String>{ 'Value1', 'Value2' });
        String expectedCsvString = String.valueOf(expectedCsvData);
        System.assertEquals(expectedCsvString, result.get(csvVersion.Id));


    }

    // Mock class 
    
    private class FilesToStringConverterMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody('Mocked response body');
            return response;
        }
    }
}