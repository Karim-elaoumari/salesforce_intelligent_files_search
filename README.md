

#  Intelligent Files Search  to Salesforce as a Lightning Web Component

##  Overview of the LWC Component "Intelligent Files Search":
The LWC "Intelligent Files Search" component is a powerful and flexible solution that allows users to search for files in Salesforce using advanced search criteria. It supports search by content and file title, search by file extension, and offers customizable filtering and results display features.

1- Purpose and features:
a-Objective:
The main objective of the "Intelligent Files Search" component is to provide users with a user-friendly interface to quickly and efficiently search for files in Salesforce, regardless of their content, extension or size. It offers advanced search and filter functionality to meet the most complex research needs.

b-Features:
Search by Content and Title: Users can search for files by specifying search terms in the file's content or in its title.
Search by Extension: Users can filter their search by file extension, for example: PDF, Excel, Word, etc.
Real Time Results: Search results are displayed in real time as the user types in their query and clicks on ‘search’.
User-Friendly Interface: The user interface is intuitive and user-friendly, allowing for a smooth search experience.
Customization: Users can customize search options and filters according to their needs.
File Preview: Users can preview found files and perform actions such as downloading and deleting.
Language Management: The component supports content language detection and provides options to customize supported languages.
Recommended Use
The Intelligent Files Search component is recommended for organizations that manage a large number of files in Salesforce and need an advanced search solution to quickly locate specific files. It is especially useful for multilingual companies and those who work with different file types.

## Requirements

* [Salesforce CLI](https://trailhead.salesforce.com/en/content/learn/modules/sfdx_app_dev/sfdx_app_dev_setup_dx#Tdxn4tBK-heading6)
* Salesforce Organisation
  
## Installing Intelligent Files Search  using Salesforce DX
1. Install Salesforce DX. Enable the Dev Hub in your org or sign up for a Dev Hub trial org and install the Salesforce DX CLI. Follow the instructions in the [Salesforce DX Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm?search_text=trial%20hub%20org) or in the [App Development with Salesforce DX](https://trailhead.salesforce.com/modules/sfdx_app_dev) Trailhead module. The steps include:
   * [Enable Dev Hub in you project](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_enable_devhub.htm)
   * [Install Salesforce CLI](https://trailhead.salesforce.com/en/content/learn/modules/sfdx_app_dev/sfdx_app_dev_setup_dx#Tdxn4tBK-heading6)
   * (Optional) [Install Salesforce Extensions for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode)

2. Clone the `salesforce_intelligent_files_search` from Github repo:
```
git clone https://github.com/Karim-elaoumari/salesforce_intelligent_files_search.git)https://github.com/Karim-elaoumari/salesforce_intelligent_files_search.git
cd salesforce_intelligent_files_search
cd '.\Intelligent Files Search\'
```
3. If you haven’t already done so, authenticate with your hub org and provide it with an alias (**DevHub** in the command below):
```
sfdx force:auth:web:login --setdefaultdevhubusername --setalias DevHub
```

4. Enter your Dev Hub org credentials in the browser that opens. After you log in successfully, you can close the browser. Create a scratch org using the `config/project-scratch-def.json` file, set the **username** as your default, and assign it an alias.
```
sfdx force:org:create --setdefaultusername -f config/project-scratch-def.json --setalias my-scratch-org
```

5. Push the app to your scratch org:
```
sfdx force:source:push -f
```

6. Open the scratch org:
```
sfdx force:org:open
```

7. Click the app launcher icon and search for 'Intelligent Files Search'

```
