//
//  ContactDetailViewController.swift
//  ContactCoreDataCloudKit
//
//  Created by Lee McCormick on 2/19/21.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Properties
    var contact: Contact?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {return}
        let phoneNumber = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        if let contact = contact {
            ContactController.shared.updateContact(contact: contact, name: name, phoneNumber: phoneNumber, email: email)
        } else {
            ContactController.shared.createContact(name: name, phoneNumber: phoneNumber, email: email)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Fuctions
    func updateViews() {
        guard let contact = contact else {return}
        nameTextField.text = contact.name
        phoneNumberTextField.text = contact.phoneNumber
        emailTextField.text = contact.email
    }
}
