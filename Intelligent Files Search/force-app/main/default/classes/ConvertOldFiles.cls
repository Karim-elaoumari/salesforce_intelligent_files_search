public class ConvertOldFiles implements  Database.Batchable<sObject>{
    
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        List<String> extensions = new List<String>{'txt', 'csv', 'doc', 'docx', 'xlsx', 'xls', 'pdf'};
        String query = 'SELECT PathOnClient, Id FROM ContentVersion WHERE FileExtension IN :extensions';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<ContentVersion> files){
        List<Id> files_ids = new List<Id>();
        for(ContentVersion cont:files){
            files_ids.add(cont.Id);
        }
        if(files_ids.size()>0){
            FileUploadTriggerHandler.mainHandler(files_ids);
        }
    }    
    public void finish(Database.BatchableContext bc){
        
    }    
}