//
//  CountryTableViewCell.swift
//  AddContact
//
//  Created by Coditas on 18/02/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var checkmarkImg: UIImageView!
    
    @IBOutlet weak var countryLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
