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
}
