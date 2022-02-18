//
//  AddPhoneTableViewCell.swift
//  AddContact
//
//  Created by Coditas on 14/02/22.
//

import UIKit

class AddPhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButtnLogo: UIButton!
    @IBOutlet weak var selectPhoneButtn: UIButton!
    @IBOutlet weak var phoneTxtF: UITextField!
    @IBAction func selectPhoneButtnTapped(_ sender: UIButton) {
        tapBlock!()
    }
    var tapBlock : (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //selectPhoneButtn.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        // Configure the view for the selected state
    }
    
}
