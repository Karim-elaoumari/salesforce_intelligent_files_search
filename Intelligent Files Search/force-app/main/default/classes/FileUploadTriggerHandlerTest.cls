@isTest
private class FileUploadTriggerHandlerTest {
    @isTest
    static void testMainHandler() {
        
        List<ContentVersion> testContentVersions = new List<ContentVersion>();
        for (Integer i = 0; i < 5; i++) {
            testContentVersions.add(new ContentVersion(
                Title = 'Test File ' + i,
                PathOnClient = 'Test/File' + i + '.txt',
                VersionData = blob.valueOf('hello worlds')
            ));
        }
        insert testContentVersions;

     
        Test.startTest();
        List<Id> contentVersionIds = new List<Id>();
        for (ContentVersion cv : testContentVersions) {
            contentVersionIds.add(cv.Id);
        }
        FileUploadTriggerHandler.mainHandler(contentVersionIds);
        Test.stopTest();
    }
    @isTest
     static void testDetectLanguage() {
        String mockResponseJson = '{"data": {"detections": [{"language": "en"}]}}';
        Integer statusCode = 200;
        Test.setMock(HttpCalloutMock.class, new IntelligentFilesSearchMock(statusCode, mockResponseJson));
        String testText = 'Hello, this is a test.';
        String detectedLanguage = FileUploadTriggerHandler.detectLanguage(testText);
        System.assertEquals('en', detectedLanguage, 'Detected language should be "en"');
    }
    @isTest 
    static void testRemoveDuplicates(){
        String before = 'hello hello ';
        String after  = FileUploadTriggerHandler.removeDuplicates(before);
         System.assertEquals('hello',after, 'the duplication didnt handled ');
    }
    @isTest 
    static void testRemoveStopWords(){
        String mockResponseJson = '{"data": {"detections": [{"language": "en"}]}}';
        Integer statusCode = 200;
        Test.setMock(HttpCalloutMock.class, new IntelligentFilesSearchMock(statusCode, mockResponseJson));
        String before = 'hello i am karim and';
        String after = FileUploadTriggerHandler.removeStopWords(before);
        System.assertEquals('hello karim',after, 'the stopwords didnt handled');
    }
    @isTest 
    static void testIndexingStrings(){
        String mockResponseJson = '{"data": {"detections": [{"language": "en"}]}}';
        Integer statusCode = 200;
        Test.setMock(HttpCalloutMock.class, new IntelligentFilesSearchMock(statusCode, mockResponseJson));
        List<ContentVersion> files = GenerateFilesHelper.start(2);
        Map<Id,String> file_text = new  Map<Id,String>();
        for(ContentVersion file:files){
            file_text.put(file.Id, 'hello i am karim i');
        }
        Test.startTest();
        Map<Id,String> files_indexed = FileUploadTriggerHandler.indexingStrings(file_text);
        Test.stopTest();
        System.assertEquals(2,files_indexed.size(), 'number returned of files missed');
    }
}