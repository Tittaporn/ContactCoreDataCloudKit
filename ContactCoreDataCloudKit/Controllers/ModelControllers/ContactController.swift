//
//  ContactController.swift
//  ContactCoreDataCloudKit
//
//  Created by Lee McCormick on 2/19/21.
//

import CoreData

class ContactController {
    static let shared = ContactController()
    var contacts: [Contact] = []
    private lazy var fetchRequest: NSFetchRequest<Contact> = {
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD Methods
    // CREATE
    func createContact(name:String, phoneNumber: String, email: String){
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        contacts.append(newContact)
        CoreDataStack.shared.saveContext()
    }
    
    // READ
    func fetchContacts() {
        let fetchContacts = (try? CoreDataStack.shared.managedContext.fetch(fetchRequest)) ?? []
        contacts = fetchContacts
    }
    
    // UPDATE
    func updateContact(contact: Contact, name: String, phoneNumber: String, email: String){
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.email = email
        CoreDataStack.shared.saveContext()
    }
    
    // DELETE
    func deleteContact(contact: Contact){
        CoreDataStack.shared.managedContext.delete(contact)
        CoreDataStack.shared.saveContext()
    }
    
    // MARK: - Subscribe For Romote Notifications
    func subscribeForRomoteNotifications(completion: @escaping (Bool) -> Void ) {
        
        let allContactsPredicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: "CD_Contact", predicate: allContactsPredicate, options: .firesOnRecordUpdate)
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.title = "CONTEXT!"
        notificationInfo.alertBody = "Context is using somewhere."
        notificationInfo.soundName = "default"
        notificationInfo.shouldBadge = true
        subscription.notificationInfo = notificationInfo
        
        CKContainer.default().privateCloudDatabase.save(subscription) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(false)
            }
            completion(true)
        }
    }
}
