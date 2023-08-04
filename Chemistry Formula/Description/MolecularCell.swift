//
//  MolecularCell.swift
//  Chemistry Formula
//
//  Created by Krutik Dobaiya on 07/04/23.
//

import UIKit

class MolecularCell: UITableViewCell {

    @IBOutlet weak var atomName: UILabel!
    @IBOutlet weak var atomNo: UILabel!
    @IBOutlet weak var molarMass: UILabel!
    @IBOutlet weak var subTotalMass: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
