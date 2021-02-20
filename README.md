# ContactCoreDataCloudKit
FirstApp with CoreData with CloudKit. It is a contact saving app using CoreData and CloudKit.

## Instructions for Unit 5 Challenge
This challenge is intended to assess your ability to build applications that sync data between devices using CloudKit. It covers the following concepts taught in Unit 4:

 - CloudKit setup (provisioning, CloudKit containers, etc.)
 - Conversion from application-specific model objects to CKRecord, and vice-versa
 - Use of CKQuery to fetch data from CloudKit
 - Proper separation of concerns. CloudKit restricted to the model/model controller layer.
 - Ability to add records to, delete records from, and update records on CloudKit.

## Requirements
The included screen recording demonstrates the application you are to create for this challenge. Note the following requirements:
1) Initial screen shows a list of contact names.
2) Tapping the plus button in the top right corner brings up a detail view with text fields to enter a name, phone number, and email address for a new contact. The user should required to enter a name. Phone number and email address fields may be left blank.
3) Tapping the save button saves the new contact and returns to the list of contacts.
4) Tapping on a contact in the list shows a detail view which allows editing the existing contact and saves the updated info.
5) Swiping on a contact in the list allows for deletion of that contact (this must persist via CloudKit)
6) If the app is killed and restarted, previously saved contacts must continue to be shown.
7) If the app is launched on another device signed into the same iCloud account, it must also show the users' contacts.

## Black Diamonds:
- Use CKSubscription to make it so that data is automatically updated on one device when it is edited on another.
- Add local persistence so that users without a network connection can see their existing contacts.
- Add a search bar to the contacts list view to allow the user to search for specific contacts.

![Screen Shot 2021-02-19 at 8 25 33 PM](https://user-images.githubusercontent.com/57606580/108581909-affbc980-72f5-11eb-944f-3b6c83574fa6.png)
![Screen Shot 2021-02-19 at 8 25 21 PM](https://user-images.githubusercontent.com/57606580/108581910-b0946000-72f5-11eb-981c-e6056f468de6.png)


#### Note: 
You may not use the CloudKit manager class from Timeline. Please use CloudKit methods directly in your model controller.

##### You will have 3 hours and 30 minutes to complete this challenge.

### @iOS App Development Bootcamp at Dev Mountain
Over 13 demanding weeks in our iOS development bootcamp you’ll find out what it means to be an app developer. Using tools like Github and Xcode to collaborate, and languages like Objective-C and Swift to create, you’ll prepare for a career in tech. At the end of the course, students work with Software QA and UX Design students to create an app for Apple products.
