//
//  ViewController.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 11/19/24.
//

import UIKit
import CoreData
import FirebaseAuth


// 911 button --> set up alert when clicked -- already in button form DONE
// set up new page for first aid info --> do first
// in this page we need to have search bar to search smth so users don't have to scroll
// create table view for thisl with each cell being a diff category --> include title, description, picture



// set up new page for emergency contacts --> make sure everything is getting saved to core data and is unique for every user --> figure out how to change data based on user


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#ADD8E6")
    }
    

    
    @IBAction func callHelp(_ sender: UIButton) {
//        let alert = UIAlertController(title: "Called 911", message: "Help is on the way!", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)  // Shrinks the button
            }) { _ in
                let alert = UIAlertController(title: "Called 911", message: "Help is on the way!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true) {
                    sender.transform = CGAffineTransform.identity
                }
            }
    }
    
    
    @IBAction func econtact(_ sender: Any) {
        performSegue(withIdentifier: "goToContactsVC", sender: self)
    }
    
    
}




