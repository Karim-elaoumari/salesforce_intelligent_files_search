public class GeneratePublicUrls{
    public static Map<Id,String> getPublicUrls(List<ContentVersion> contentVersions){
        Map<Id, String> publicUrls = new Map<Id, String>();
        List<ContentDistribution> contentDistributionsToInsert = new List<ContentDistribution>();
        for (ContentVersion contentVersion : contentVersions){
            String extension = contentVersion.PathOnClient.substring(contentVersion.PathOnClient.lastIndexOf('.') + 1);
            if (extension.equals('pdf') || extension.equals('docx') || extension.equals('doc') || extension.equals('xlsx') || extension.equals('xls') ) {
      
                ContentDistribution cd = new ContentDistribution();
                cd.Name = 'Test';
                cd.ContentVersionId = contentVersion.Id;
                cd.PreferencesAllowViewInBrowser = true;
                cd.PreferencesLinkLatestVersion = true;
                cd.PreferencesNotifyOnVisit = false;
                cd.PreferencesPasswordRequired = false;
                cd.PreferencesAllowOriginalDownload = true;
                contentDistributionsToInsert.add(cd);  
            }
            else if(extension.equals('txt') || extension.equals('csv')){
                publicUrls.put(contentVersion.Id, null);
            }
            
        }
        if (!contentDistributionsToInsert.isEmpty()) {
            insert contentDistributionsToInsert;
            List<Id> content_distribution_ids = new List<Id>();
            for(ContentDistribution cd : contentDistributionsToInsert){
                content_distribution_ids.add(cd.Id);
            }
            List<ContentDistribution> new_contentDisribution = [SELECT Id, ContentDownloadUrl,ContentVersionId  FROM ContentDistribution WHERE Id IN :content_distribution_ids];
            for (ContentDistribution cd : new_contentDisribution) {
                System.debug('in the url generator ');
                System.debug('url '+cd.ContentDownloadUrl);
                publicUrls.put(cd.ContentVersionId, String.valueOf(cd.ContentDownloadUrl));
            }
        }
        else{
            System.debug('extention not supported');
        }
       
        return publicUrls;
    }

}