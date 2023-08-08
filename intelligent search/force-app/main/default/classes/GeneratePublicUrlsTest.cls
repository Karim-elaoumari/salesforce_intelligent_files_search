@isTest
public class GeneratePublicUrlsTest {

    @isTest
    static void testGetPublicUrls() {

        List<ContentVersion> testContentVersions = new List<ContentVersion>();

        ContentVersion supportedVersion = new ContentVersion();
        supportedVersion.Title = 'Test Document';
        supportedVersion.PathOnClient = 'test_document.docx';
        supportedVersion.VersionData = Blob.valueOf('Test content data');
        insert supportedVersion;
        testContentVersions.add(supportedVersion);

        /*ContentVersion unsupportedVersion = new ContentVersion();
        unsupportedVersion.Title = 'Test Text';
        unsupportedVersion.PathOnClient = 'test_text.txt';
        unsupportedVersion.VersionData = Blob.valueOf('Test content data');
        insert unsupportedVersion;
        testContentVersions.add(unsupportedVersion);*/

        Test.startTest();
        Map<Id, String> result = GeneratePublicUrls.getPublicUrls(testContentVersions);
        Test.stopTest();

        System.assertEquals(true, result.containsKey(supportedVersion.Id));
        //System.assertNotEquals(null, result.get(supportedVersion.Id));

        //System.assertEquals(false, result.containsKey(unsupportedVersion.Id));

        //delete testContentVersions;
    }
}