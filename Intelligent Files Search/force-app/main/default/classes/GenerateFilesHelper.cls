public class GenerateFilesHelper {
    public static List<ContentVersion> start(Integer count){
        List<ContentVersion> files = new List<ContentVersion>();
        for(Integer i=0;i<count;i++){
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; 
            String theName = 'file'+i;
            conVer.PathOnClient = theName+'.txt';
            conVer.Title = theName;
            conVer.VersionData = Blob.valueof('text here'); 
            conVer.SharingPrivacy = 'P';
            
            files.add(conVer);
        }
        insert files;
        return files;
        
        
    }

}