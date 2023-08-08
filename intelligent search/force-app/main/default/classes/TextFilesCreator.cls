public class TextFilesCreator {
    public static void create(Map<Id,String> files_text){
       List<ContentVersion> new_text_files = new List<ContentVersion>();
       List<ContentVersion> files_to_update = new List<ContentVersion>();
       List<Id> content_version_ids = new List<Id>();
        for (Id content_version_id : files_text.keySet()){
            content_version_ids.add(content_version_id);
        }
        List<ContentVersion> content_versions = [SELECT PathOnClient,Id,content_text__c,content_text_2__c,content_text_3__c FROM ContentVersion WHERE  Id IN :content_version_ids];
         for (ContentVersion content_version :content_versions){
             if(files_text.get(content_version.Id).length()>=393214){
                 ContentVersion conVer = new ContentVersion(ContentLocation = 'S',VersionData = Blob.valueof(files_text.get(content_version.Id)),SharingPrivacy = 'P',parent_id__c = content_version.Id
                 );
                 String theName = 'text_content'+String.valueOf(Math.round(Math.random() * 9000) + 1000);
                 conVer.PathOnClient = theName+'.txt';
                 conVer.Title = theName; 
                 conVer.parent_extension__c = content_version.PathOnClient.substring(content_version.PathOnClient.lastIndexOf('.') + 1);
                 new_text_files.add(conVer);
             }else{
                 List<String> fields_content = saveContent(files_text.get(content_version.Id));
                 content_version.content_text__c = fields_content[0];
                 content_version.content_text_2__c = fields_content[1];
                 content_version.content_text_3__c = fields_content[2];
                 files_to_update.add(content_version);
             }
            
         }
        
        if(new_text_files.size()>0){
            insert new_text_files;
         
        }
        if(files_to_update.size()>0){
            update files_to_update;
        }
    }
    public static List<String> saveContent(String inputString) {
       
        Integer maxCharacters = 131072;
        String[] words = inputString.split(' '); 
        String content_text = '';
        String content_text_2 = '';
        String content_text_3 = '';
        Integer feild_step = 1;
        for (String word : words) {
            Integer wordLength = word.length() + 1; 
            if (content_text.length() + wordLength <= maxCharacters && feild_step==1) {
                content_text += word + ' ';
                System.debug(content_text);
            } else {
                if (content_text_2.length() + wordLength <= maxCharacters && (feild_step==2 || content_text_2.length()==0) ) { feild_step = 2; content_text_2 += word + ' ';
                } else { if (content_text_3.length() + wordLength <= maxCharacters && (feild_step==3 || content_text_3.length()==0) ) {  feild_step = 3; content_text_3 += word + ' '; } else { feild_step = 4; }
                }
            }
        }
        
        content_text = content_text.trim();
        content_text_2 = content_text_2.trim();
        content_text_3 = content_text_3.trim();
        List<String> fields_content =  new List<String>{content_text,content_text_2,content_text_3};
        return fields_content;
    }
}