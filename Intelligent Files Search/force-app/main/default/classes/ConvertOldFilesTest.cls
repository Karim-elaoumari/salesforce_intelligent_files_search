@isTest
public class ConvertOldFilesTest{
    @isTest
    public static void testConvertOldFiles(){
        List<ContentVersion> files = GenerateFilesHelper.start(100);
        Id batchJobId = Database.executeBatch(new ConvertOldFiles(), 200);
     
        
        
    }

}