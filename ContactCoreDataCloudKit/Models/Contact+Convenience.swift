//
//  Contact+Convenience.swift
//  ContactCoreDataCloudKit
//
//  Created by Lee McCormick on 2/19/21.
//

import CoreData
// MARK: - Protocol
protocol SearchableRecordDelegate {
    func matches(searchTerm: String) -> Bool
}

extension Contact {
    @discardableResult convenience init(name: String, phoneNumber: String, email: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.shared.managedContext) {
        self.init(context: context)
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.timestamp = timestamp
    }
}

extension Contact: SearchableRecordDelegate {
    func matches(searchTerm: String) -> Bool {
        if let name = self.name, name.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else if let phoneNumber = self.phoneNumber, phoneNumber.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else if let email = self.email, email.lowercased().contains(searchTerm.lowercased()){
            return true
        }
        return false
    }
}
