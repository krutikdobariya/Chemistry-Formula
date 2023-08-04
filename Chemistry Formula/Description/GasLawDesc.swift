//
//  GasLawDesc.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 20/03/23.
//

import UIKit

class GasLawDesc: UIViewController {

    @IBOutlet weak var GasLawFavBtn: UIBarButtonItem!
    
    @IBOutlet weak var GLName: UILabel!
    
    @IBOutlet weak var GLDescription: UILabel!
    
    var f : Formula = Formula()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = f.FormulaTitle
        let font = UIFont.systemFont(ofSize: 18)
        
        //      html to text converter start
            
        let htmlString  = f.FormulaName
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.firstLineHeadIndent = 0.001
            
            
        let attrStr = try!  NSAttributedString(data:  htmlString.data(using: String.Encoding.utf8)!,
                                                   options: [.documentType: NSAttributedString.DocumentType.html,
                                                             .characterEncoding: String.Encoding.utf8.rawValue],
                                                   documentAttributes: nil)
        //      html to text converter end
            
        GLName.attributedText = attrStr
        GLName.font = font
            
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
        GLDescription.attributedText = attrStr1
        GLDescription.font = font
        
        //        already favourited button of note check
        if f.IsFavourite == 1
        {
            GasLawFavBtn.image = UIImage(named: "AddFav")
        }
        else
        {
            GasLawFavBtn.image = UIImage(named: "DeleteFav")
        }
    }

    @IBAction func GasLawFav(_ sender: Any) {
        
        if GasLawFavBtn.image == UIImage(named: "DeleteFav")
        {
            GasLawFavBtn.image = UIImage(named: "AddFav")
            DescriptionDAL.addFavourite(f:f)
        }
        else
        {
            GasLawFavBtn.image = UIImage(named: "DeleteFav")
            DescriptionDAL.deleteFavourite(f:f)
        }
    }
}
