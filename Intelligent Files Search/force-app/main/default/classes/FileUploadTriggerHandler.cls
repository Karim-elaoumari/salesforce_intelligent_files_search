public class FileUploadTriggerHandler {
    public static void mainHandler(List<Id> contentVersions_ids){
        List<ContentVersion> contentVersions = [SELECT PathOnClient,Id FROM ContentVersion WHERE  Id IN :contentVersions_ids];
        
        Map<Id, String> files_urls = GeneratePublicUrls.getPublicUrls(contentVersions);
        System.debug(files_urls);
        if(!files_urls.isEmpty() && !test.isRunningTest()){
                    FileUploadTriggerHandler.conversionCallout(files_urls);    
        }   
    }
    
    @future(callout=true)
    public static void conversionCallout(Map<Id, String> files_urls){
     Map<Id,String>  files_text = FilesToStringConverter.startConvert(files_urls);
     Map<Id,String>  files_text_indexed  = indexingStrings(files_text);
     TextFilesCreator.create(files_text_indexed);
    }
    public static Map<Id, String> indexingStrings(Map<Id, String> files_strings) {
        Map<Id, String> updatedFilesStrings = new Map<Id, String>();
        
        for (Id content_version_id : files_strings.keySet()) {
            String originalString = files_strings.get(content_version_id);
            originalString = indexOneString(originalString);
            updatedFilesStrings.put(content_version_id, originalString);
        }
        return updatedFilesStrings;
    }
    public static String indexOneString(String original_str){
        original_str = original_str.replaceAll('[^\\p{L}\\p{N}\\s]', ' ');
        original_str = removeDuplicates(original_str);
        original_str = removeStopWords(original_str);
        return original_str;
        
    }
    
    public static String removeDuplicates(String str) {
        List<String> words = new List<String>();
        for (String word : str.split(' ')) {
            if (!words.contains(word)){
                words.add(word);
            }
        }
        return String.join(words, ' ');
    }
    public static String removeStopWords(String input) {
        String language = detectLanguage(input.substring(0, Math.min(input.length(), 40)));
       
            Set<String> stopWords = new Set<String>();
            for (language_stop_words__mdt stopWordRecord : [SELECT code__c,	stop_words__c FROM language_stop_words__mdt WHERE code__c=:language]) {
                stopWords.addAll(stopWordRecord.stop_words__c.split(', '));
            }
             System.debug(stopWords);
            if(stopWords.size()>0){
                List<String> words = input.split('\\s+');
                String result = '';
                for (String word : words) {
                    String lowerCaseWord = word.toLowerCase();
                    if (!stopWords.contains(lowerCaseWord)) {
                        result += word + ' ';
                    }
                }
                return result.trim(); 
            }else{
                 return input;
            }
            
        }
       
    public static String detectLanguage(String some_text){
        String boundary = '----WebKitFormBoundary7MA4YWxkTrZu0gW';
        String apiKey = '83bea1e3a5c09ab271ae808647efd431';
        String endpointUrl = 'https://ws.detectlanguage.com/0.2/detect';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + apiKey);
        String requestBody = '--' + boundary + '\r\n'+
                            'Content-Disposition: form-data; name="q"\r\n\r\n'+
                            some_text + '\r\n' +
                            '--' + boundary + '--';
        request.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
        request.setBodyAsBlob(Blob.valueOf(requestBody));
        Http http = new Http();
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200){ 
           FromJSON jsonResponse = (FromJSON) JSON.deserialize(response.getBody(), FromJSON.class);
            if (jsonResponse.data != null && jsonResponse.data.detections != null && !jsonResponse.data.detections.isEmpty()) {
                Detections languageInfo = jsonResponse.data.detections[0];
                String detectedLanguage = languageInfo.language;
                 return detectedLanguage;
                
            } else {
                System.debug('No language detection found in the response.');
            }
        } else {
            System.debug('Error: ' + response.getStatusCode() + ', ' + response.getStatus());
        }
       return  null;
    }  
    
    
    
     public class FromJSON {
    public Data data;  
      }
    class Data {
        public List<Detections> detections;
    }
    class Detections {
        public String language;
    }
}