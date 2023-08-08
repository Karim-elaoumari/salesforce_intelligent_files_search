import { LightningElement,wire,track } from 'lwc';
import intelligentSearch from '@salesforce/apex/FilesIntelligentSearchController.intelligentSearch';

export default class IntelligentFilesSearchMain extends LightningElement {
    files;
    @track table_visiblity = false;
    @track comp = 1;
    searchTerm='';
    extension = 'all'; 
    searchBy = 'title';
   
    get not_found(){
        return this.comp==3;
    }
    get starting(){
        return this.comp==1;
    }
    get loader(){
        return this.comp ==2;
    }

    get isSearchDisabled() {
        return this.searchTerm.length <= 2;
    }
    

    handleSearchTermChange(event) {
        this.searchTerm = event.detail.value;
    }

    handleExtensionChange(event) {
        this.extension = event.detail.value;
    }

    handleSearchByChange(event) {
        this.searchBy = event.detail.value;
    }

    search(){
        if (this.isSearchDisabled) {
            return; // Prevent the search if the button is disabled
        }
        // const searchByElement = this.template.querySelector('.search-by');
        // const extensionElement = this.template.querySelector('.extension');
        this.comp = 2;
        this.table_visiblity = false;
        // const searchBy = searchByElement.value;
        // const extension = extensionElement.value;
        console.log('searchBy: '+ this.searchBy);
        intelligentSearch({ searchString: this.searchTerm, searchBy: this.searchBy, extension: this.extension })
.then(result => {
    if(result.length>0){
        this.table_visiblity = true;
        this.comp = 0;
    }
    else{
        this.table_visiblity = false;
        this.comp = 3;
    }
    
  
    this.files = result.map(file => ({
            ...file,
            Url: `https://wise-panda-6024kr-dev-ed.trailblaze.lightning.force.com/lightning/r/ContentDocument/${file.ContentDocumentId}/view`,
            ContentSize : `${(parseFloat(file.ContentSize/1024)).toFixed(2)}KB`,
        }));
    console.log(result);
})
.catch(error => {
    console.log('Erreur ... ' + error);
});
    }

    columns = [
        {
            label: 'Name', fieldName: 'Url', type: 'url',
            typeAttributes: {
                label: { fieldName: 'Title' }, 
                target: '_blank',
                tooltip: 'Open Link',
                variant: 'base',
                }
        },
        
        { label: 'Extension', fieldName: 'FileExtension' },
        { label: 'Created at', fieldName: 'CreatedDate'},
        {label:'Last Modified Date',fieldName:'LastModifiedDate'},
        {label:'File Size',fieldName:'ContentSize'},
        {
            type: 'action',
            typeAttributes: { rowActions: this.getRowActions },
        },
    ];

    getRowActions(row, doneCallback) {
        const actions = [
            { label: 'View', name: 'option_1' },
            { label: 'Option 2', name: 'option_2' },
        ];
        doneCallback(actions);
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        
        switch (actionName) {
            case 'option_1':
                const filePreviewUrl = 'https://wise-panda-6024kr-dev-ed.trailblaze.lightning.force.com/lightning/r/ContentDocument/'+ row.ContentDocumentId +'/view';
                window.open(filePreviewUrl, '_blank');
                break;
            case 'option_2':
                
                break;
            default:
                break;
        }
    }
     get options() {
        return [
            { label: 'All', value: 'all' },
            { label: 'PDF', value: 'pdf' },
            { label: 'DOC', value: 'doc' },
            { label: 'DOCX', value: 'docx' },
            { label: 'XLSX', value: 'xlsx' },
            { label: 'XLS', value: 'xls' },
            { label: 'CSV', value: 'csv' },
            { label: 'TXT', value: 'txt' },
            { label: 'PNG', value: 'png' },
            { label: 'JPG', value: 'jpg' },
            { label: 'JPEG', value: 'jpeg' },
        ];
    }
    get options_search() {
        return [
            { label: 'Content', value: 'content' },
            { label: 'Title', value: 'title' },
           
        ];
    }

}