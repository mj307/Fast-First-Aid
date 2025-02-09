//
//  injuryVC.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 11/26/24.
//

import UIKit


class injuryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var injuries: [(name: String, fix: String)] = [
        ("Sprained Ankle", "Rest, ice, compression, and elevation (R.I.C.E)"),
        ("Broken Arm", "Set the bone and cast it, seek medical attention"),
        ("Knee Ligament Tear", "Rest, ice, physical therapy, or surgery"),
        ("Dislocated Shoulder", "Seek immediate medical attention, may require reduction"),
        ("Fractured Finger", "Splint and seek medical attention"),
        ("Concussion", "Rest, avoid screens, and seek medical evaluation")
    ]
    
    var filteredInjuries: [(name: String, fix: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#ADD8E6")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        filteredInjuries = injuries
    }
}

extension injuryVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInjuries.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "InjuryCell", for: indexPath) as! InjuryTableViewCell
        

        let injury = filteredInjuries[indexPath.row]
        

        cell.configure(with: injury)
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredInjuries = injuries
        } else {
            filteredInjuries = injuries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.fix.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

