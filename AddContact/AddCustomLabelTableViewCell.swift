//
//  AddCustomLabelTableViewCell.swift
//  AddContact
//
//  Created by Coditas on 21/02/22.
//

import UIKit

class AddCustomLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var addCustomLbl: UILabel!
    @IBOutlet weak var customLblWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtfieldWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
