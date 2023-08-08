public class SearchFilesContent {
    public static List<ContentVersion> searchContentVersionsByFields(String searchTerm, String extension) {
        List<String> searchWords = searchTerm.split(' ');
        String soslQuery = 'FIND \'' + String.join(searchWords, ' AND ') + '\' IN ALL FIELDS RETURNING ContentVersion('
                          + 'Title, ContentDocumentId, FileExtension,CreatedDate,LastModifiedDate,ContentSize,'
                          + 'content_text__c, content_text_2__c, content_text_3__c'
                          + ')';

        List<List<SObject>> searchResults = Search.query(soslQuery);
        List<ContentVersion> matchedContentVersions = new List<ContentVersion>();

        for (List<SObject> result : searchResults) {
            for (SObject obj : result) {
                ContentVersion contentVersion = (ContentVersion) obj;
                if (extension != null && extension !='all') {
                    if (contentVersion.FileExtension == extension){matchedContentVersions.add(contentVersion); }} else {matchedContentVersions.add(contentVersion);} }
        }
        return matchedContentVersions;
    }
    public static List<ContentVersion> searchContentVersionsByTxt(String searchTerm, String extension){
        List<String> searchWords = searchTerm.trim().split(' ');
     
        String query = 'SELECT Id,parent_id__c,parent_extension__c,VersionData FROM ContentVersion WHERE parent_id__c != null';
        if (extension != 'all' ) {
            query += ' AND parent_extension__c = \'' + extension + '\'';
        }
        
        List<ContentVersion> txt_files = Database.query(query);
        list<Id> files_ids = new List<Id>();
        for(ContentVersion cont :txt_files){
  
            String content = cont.VersionData != null ? cont.VersionData.toString() : '';
            
            Boolean allWordsFound = true;
            for (String word : searchWords) {
                if (!content.contains(word)) { allWordsFound = false; break; }
            }
    
            if (allWordsFound) { files_ids.add(cont.parent_id__c); }
            
        }
        if(files_ids.size()>0){ return [SELECT Title, ContentDocumentId, FileExtension,CreatedDate,LastModifiedDate,ContentSize FROM ContentVersion WHERE Id IN :files_ids ];
        }else{return new List<contentVersion>();}
        
        
    }
}