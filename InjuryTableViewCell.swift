//
//  InjuryTableViewCell.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 11/26/24.
//

import UIKit

class InjuryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fixLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(with injury: (name: String, fix: String)) {
        nameLabel.text = injury.name
        fixLabel.text = injury.fix
        }

}
