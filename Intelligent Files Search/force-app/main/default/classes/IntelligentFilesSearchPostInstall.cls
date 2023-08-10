global class IntelligentFilesSearchPostInstall implements InstallHandler {
    global void onInstall(InstallContext context) {
        if(context.previousVersion() == null) {
            // This means the package is being installed for the first time
            // Perform required activities for the first time install
             Id batchJobId = Database.executeBatch(new ConvertOldFiles(), 200);
          
        }
        else if(context.previousVersion().compareTo(new Version(1,0)) == 0) {
            // This means the previous version is 1.0
            
        }
        if(context.isUpgrade()) {
            // This means the package is getting upgraded
            // Perform required activities for package upgrades
            
            
        }
        if(context.isPush()) {
            //This means the package is getting pushed
            //Perform required activities for push upgrades
           
        }
    }
}