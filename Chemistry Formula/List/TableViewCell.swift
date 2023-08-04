//
//  TableViewCell.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 09/03/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ListImage: UIImageView!
    
    @IBOutlet weak var ListLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
