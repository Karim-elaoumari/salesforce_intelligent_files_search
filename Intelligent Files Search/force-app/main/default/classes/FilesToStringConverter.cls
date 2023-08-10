public class FilesToStringConverter{
    public static Map<Id,String> startConvert(Map<Id,String> content_versions_urls){
        
        Map<Id,String> content_versions_text = new Map<Id,String>();
        List<Id> content_version_ids = new List<Id>();
        for (Id content_version_id : content_versions_urls.keySet()) {
            content_version_ids.add(content_version_id);
        }
        List<ContentVersion> content_versions = [SELECT PathOnClient,Id,VersionData FROM ContentVersion WHERE  Id IN :content_version_ids];
        for (ContentVersion content_version :content_versions){
            String result_string = '';
            String file_extension = content_version.PathOnClient.substring(content_version.PathOnClient.lastIndexOf('.') + 1);
            String url = content_versions_urls.get(content_version.Id);
            if(url!=null){
                result_string = FilesToStringConverter.fileConverter(url,file_extension);
                if(result_string!=null){
                content_versions_text.put(content_version.Id, result_string);
                }
            }else if(file_extension=='txt'){
               result_string = FilesToStringConverter.parseTXT(content_version.VersionData);
                if(result_string!=null){
                content_versions_text.put(content_version.Id, result_string);
                }
                
            }
            else if(file_extension=='csv'){
                result_string = String.valueOf(FilesToStringConverter.parseCSV(content_version.VersionData));
                if(result_string!=null){
                content_versions_text.put(content_version.Id, result_string);
                }
                
            }
        }
        return content_versions_text;
    }
    public static String fileConverter(String content_version_url,String extension){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String boundary = '----WebKitFormBoundary7MA4YWxkTrZu0gW';
        String api_extension = '';
        if(extension=='jpg' ||extension=='png' || extension=='jpeg'){ api_extension='image';}
        else if(extension=='pdf'){ api_extension = extension;}
        else if(extension=='doc' ||extension=='docx'){api_extension='doc';}
        else if(extension=='xlsx' || extension=='xls'){ api_extension='xlsx';}
        request.setEndpoint('https://file-to-text-api.vercel.app/upload/'+api_extension);
        request.setMethod('POST');
        System.debug('here in the apiii extention'+ api_extension);
        String requestBody = '--' + boundary + '\r\n'+
                            'Content-Disposition: form-data; name="pdfBase64"\r\n\r\n'+
                            content_version_url + '\r\n' +
                            '--' + boundary + '--';
        request.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
        request.setBodyAsBlob(Blob.valueOf(requestBody));
        HttpResponse response = http.send(request);
        System.debug('here in the apiii 3');
        if(response.getStatusCode() == 200){
            return response.getBody();
        }
        else{
            return null;
        }
    }
    
    public static List<List<String>> parseCSV(Blob docBlob) {
        List<List<String>> csvData = new List<List<String>>();

        String plainText = docBlob.toString();
        List<String> lines = plainText.split('\n');
        for (String line : lines){
            csvData.add(line.split(','));
        }
        return csvData;
    }
    public static String parseTXT(Blob docBlob){
        String content = '';
        content = docBlob.toString();
        return content;
    }
    

}