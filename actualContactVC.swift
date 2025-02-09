//
//  actualContactVC.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 11/24/24.
//

import UIKit

protocol actualContactVCDelegate: AnyObject {
    func didSaveContact(name: String, phone: String)
}

class actualContactVC: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    weak var delegate: actualContactVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#ADD8E6")
    }

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Both fields are required.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        delegate?.didSaveContact(name: name, phone: phone)

        navigationController?.popViewController(animated: true)
    }
}


