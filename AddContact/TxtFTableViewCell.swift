//
//  TxtFTableViewCell.swift
//  AddContact
//
//  Created by Coditas on 13/02/22.
//

import UIKit

class TxtFTableViewCell: UITableViewCell {

    @IBOutlet weak var txtFieldView: UIView!
    @IBOutlet weak var txtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
