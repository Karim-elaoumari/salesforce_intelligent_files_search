public class FilesIntelligentSearchController {
    @AuraEnabled(cacheable=true)
    public static List<ContentVersion> intelligentSearch(String searchString, String searchBy, String extension) {
        if (searchBy == 'title') {
            return searchFilesByTitle(searchString, extension);
        } else{
            String indexed_search = FileUploadTriggerHandler.indexOneString(searchString);
            List<ContentVersion> cont_by_fields = SearchFilesContent.searchContentVersionsByFields(indexed_search,extension);
            List<ContentVersion> cont_by_txt = SearchFilesContent.searchContentVersionsByTxt(indexed_search,extension);
            if(!cont_by_txt.isEmpty()){
                cont_by_fields.addAll(cont_by_txt);
          }  
            return cont_by_fields;
           
        }
    }

    public static List<ContentVersion> searchFilesByTitle(String searchString, String extension) {
        if (extension == 'all') {
            return [
                SELECT Title, ContentDocumentId, FileExtension,CreatedDate,LastModifiedDate,ContentSize
                FROM ContentVersion
                WHERE Title LIKE :'%'+searchString+'%'
            ];
        } else {
            return [
                SELECT Id, Title, ContentDocumentId, FileExtension,CreatedDate,LastModifiedDate,ContentSize
                FROM ContentVersion
                WHERE Title LIKE :'%'+searchString+'%' AND FileExtension = :extension
            ];
        }
    }
}