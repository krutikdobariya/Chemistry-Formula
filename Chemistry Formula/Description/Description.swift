//
//  Description.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 19/03/23.
//

import UIKit

class Description: UIViewController {
    
    @IBOutlet weak var fullView: UIView!
    
//    var desc : [Formula] = []
    var f : Formula = Formula()
    
    @IBOutlet weak var Favouritebtn: UIBarButtonItem!
    @IBOutlet weak var DecFormulaName: UILabel!
    @IBOutlet weak var DecFormulaDecripton: UILabel!
    @IBOutlet weak var DecFormulaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = f.FormulaTitle
        
        let font = UIFont.systemFont(ofSize: 17)
        
//      html to text converter start
        let htmlString  = f.Formula
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.firstLineHeadIndent = 0.001
        
        
        let attrStr = try!  NSAttributedString(data:  htmlString.data(using: String.Encoding.utf8)!,
                                               options: [.documentType: NSAttributedString.DocumentType.html,
                                                         .characterEncoding: String.Encoding.utf8.rawValue],
                                               documentAttributes: nil)
//      html to text converter end
        
        DecFormulaName.attributedText = attrStr
        DecFormulaName.font = font
        
//      html to text converter start
        let htmlString1  = f.FormulaDescription
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.alignment = .justified
        paragraphStyle1.firstLineHeadIndent = 0.001
        
        
        let attrStr1 = try!  NSAttributedString(data:  htmlString1.data(using: String.Encoding.utf8)!,
                                               options: [.documentType: NSAttributedString.DocumentType.html,
                                                         .characterEncoding: String.Encoding.utf8.rawValue],
                                               documentAttributes: nil)
//      html to text converter end
        
//      DecFormulaDecripton.attributedText = attrStr1
        
        DecFormulaDecripton.attributedText = attrStr1
        DecFormulaDecripton.font = font
        
        
//        already favourited button of note check
        if f.IsFavourite == 1
        {
            Favouritebtn.image = UIImage(named: "AddFav")
        }
        else
        {
            Favouritebtn.image = UIImage(named: "DeleteFav")
        }
    }
    
//    button of add or delete favourite formula
    @IBAction func AddFavourite(_ sender: Any) {
        if Favouritebtn.image == UIImage(named: "DeleteFav")
        {
            Favouritebtn.image = UIImage(named: "AddFav")
            DescriptionDAL.addFavourite(f:f)
        }
        else
        {
            Favouritebtn.image = UIImage(named: "DeleteFav")
            DescriptionDAL.deleteFavourite(f:f)
        }
    }
}
