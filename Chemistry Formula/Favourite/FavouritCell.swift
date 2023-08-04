//
//  FavouritCell.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 20/03/23.
//

import UIKit

class FavouritCell: UITableViewCell {
    
    @IBOutlet weak var FavImage: UIImageView!
    
    @IBOutlet weak var FavTopicName: UILabel!
    
    @IBOutlet weak var FavFormulaName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
