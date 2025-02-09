//
//  cinfoVC.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 11/24/24.
//

import UIKit
import CoreData


protocol cinfoVCDelegate: AnyObject {
    func didSaveContact(name: String, phone: String)
}

class cinfoVC: UIViewController, UITableViewDataSource, UITableViewDelegate, cinfoVCDelegate, actualContactVCDelegate {

    @IBOutlet weak var tableView: UITableView!


    var contacts: [ContactEntity] = []

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("cinfo viewDidLoad called")
        view.backgroundColor = UIColor(hex: "#ADD8E6")

        tableView.dataSource = self
        tableView.delegate = self
        
        fetchContactsFromCoreData()
    }


    func fetchContactsFromCoreData() {
        let request: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        do {
            contacts = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Error fetching contacts from Core Data: \(error)")
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }

        let contact = contacts[indexPath.row]
        print("Displaying contact at index \(indexPath.row): \(contact.name ?? "No Name"), \(contact.phone ?? "No Phone")")

        cell.nameLabel.text = contact.name
        cell.phoneLabel.text = contact.phone

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addContactInfo" {
            if let actualContactVC = segue.destination as? actualContactVC {
                actualContactVC.delegate = self  // Set the delegate
            }
        }
    }

    
    func didSaveContact(name: String, phone: String) {
        let newContact = ContactEntity(context: context)
        newContact.name = name
        newContact.phone = phone
        
        do {
            try context.save()
            print("New contact saved: \(name), \(phone)")
        } catch {
            print("Failed to save contact: \(error)")
        }
        

        fetchContactsFromCoreData()
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let contactToDelete = self.contacts[indexPath.row]
            
            self.context.delete(contactToDelete)
            
            do {
                try self.context.save()
                print("Contact deleted: \(contactToDelete.name ?? "No Name")")
            } catch {
                print("Failed to delete contact: \(error)")
            }
            
            self.fetchContactsFromCoreData()
            
            completionHandler(true)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}


