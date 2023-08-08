@isTest
public class SearchFilesContentTest {
    @isTest
    public static void testSearchContentVersionsByFields(){
        List<ContentVersion> cont_files  =  GenerateFilesHelper.start(6);
        cont_files[0].parent_id__c = cont_files[4].Id;
        cont_files[1].parent_id__c = cont_files[5].Id;
        cont_files[2].content_text__c = 'hello my name is api';
        cont_files[3].content_text__c = 'hello my name is apex';
        update cont_files;
        test.startTest();
        List<ContentVersion> returned  = SearchFilesContent.searchContentVersionsByFields('hello my name is api','all');
        List<ContentVersion> returned2 = SearchFilesContent.searchContentVersionsByTxt('text here', 'all');
        test.stopTest();
        System.assertEquals(2,returned2.size());
        System.assertEquals(0, returned.size());
        
    }

}