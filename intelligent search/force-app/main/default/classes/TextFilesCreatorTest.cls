@isTest
public class TextFilesCreatorTest{
    @isTest
    public static void test(){
        List<ContentVersion> cont_files = GenerateFilesHelper.start(1);
     
        
        String result = 'asadsddddddddddddddddddddddddddddddddddddddddddddddd';

       
        Map<Id,String> file_content = new Map<Id,String>();
        for(ContentVersion cont : cont_files){
            file_content.put(cont.Id,result);
           
          
        }
        
        Test.startTest();
        TextFilesCreator.create(file_content);
        Test.stopTest();
        ContentVersion updated_cont = [select Id,content_text__c,content_text_2__c,content_text_3__c from ContentVersion where Id = :cont_files[0].Id];
        System.Assert(updated_cont.content_text__c == result);
    }
}