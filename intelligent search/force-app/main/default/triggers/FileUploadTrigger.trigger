trigger FileUploadTrigger on ContentVersion (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            System.debug(Trigger.new);
            List<Id> cont_ids = new  List<Id>();
            //List<Id> ids = Trigger.newMap.keySet();
            for(ContentVersion cont:Trigger.new){
                if(cont.parent_id__c==null){
                    cont_ids.add(cont.Id);
                } 
            }
            if(!cont_ids.isEmpty() && !test.isRunningTest()){
                FileUploadTriggerHandler.mainHandler(cont_ids);  
            }
           
        } 
    }
}