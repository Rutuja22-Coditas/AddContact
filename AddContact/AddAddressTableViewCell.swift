//
//  AddAddressTableViewCell.swift
//  AddContact
//
//  Created by Coditas on 17/02/22.
//

import UIKit

class AddAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressOfButtn: UIButton!
    @IBOutlet weak var street1TxtFld: UITextField!
    @IBOutlet weak var street2TxtFld: UITextField!
    @IBOutlet weak var cityTxtFld: UITextField!
    @IBOutlet weak var stateTxtFld: UITextField!
    @IBOutlet weak var zipTxtFld: UITextField!
    @IBOutlet weak var selectCountryBuutn: UIButton!
    
    @IBAction func selectCountryClicked(_ sender: UIButton) {
        countryTap!()
    }
    @IBAction func addressOfButtnClicked(_ sender: UIButton) {
        tapblock!()
    }
  
    var tapblock : (()->Void)?
    var countryTap : (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
