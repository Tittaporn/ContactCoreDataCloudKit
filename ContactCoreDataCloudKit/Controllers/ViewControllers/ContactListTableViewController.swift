//
//  ContactListTableViewController.swift
//  ContactCoreDataCloudKit
//
//  Created by Lee McCormick on 2/19/21.
//

import UIKit

class ContactListTableViewController: UITableViewController{
    
    // MARK: - Outlets
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    // MARK: - Properties
    var resultsContactFromSearching: [SearchableRecordDelegate] = []
    var isSearching = false
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        contactSearchBar.delegate = self
        fetchContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContacts()
    }
    
    // MARK: - Helper Fuctions
    func fetchContacts() {
        ContactController.shared.fetchContacts()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsContactFromSearching.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        guard let contact = resultsContactFromSearching[indexPath.row] as? Contact else {return UITableViewCell()}
        
        cell.textLabel?.text = contact.name
        if contact.phoneNumber == "" {
            cell.detailTextLabel?.text = "No phone number saved."
        } else {
            cell.detailTextLabel?.text = contact.phoneNumber
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = ContactController.shared.contacts[indexPath.row]
            ContactController.shared.deleteContact(contact: contact)
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContactDetailVC" {
            guard let indextPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? ContactDetailViewController else {return}
            let contact = ContactController.shared.contacts[indextPath.row]
            destinationVC.contact = contact
        }
    }
}

extension ContactListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            resultsContactFromSearching = ContactController.shared.contacts.filter{$0.matches(searchTerm: searchText)}
            self.tableView.reloadData()
        } else {
            resultsContactFromSearching = ContactController.shared.contacts
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        isSearching = false
        resultsContactFromSearching = ContactController.shared.contacts
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
    }
}
