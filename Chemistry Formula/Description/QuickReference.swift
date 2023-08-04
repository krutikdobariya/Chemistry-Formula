//
//  QuickReference.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 20/03/23.
//

import UIKit

class QuickReference: UIViewController {

    @IBOutlet weak var QuickRefFavBtn: UIBarButtonItem!
    
    @IBOutlet weak var QRName: UILabel!
    
    
    @IBOutlet weak var QRDescription: UILabel!
    var f : Formula = Formula()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = f.FormulaTitle
        let font = UIFont.systemFont(ofSize: 17)
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
            
        QRName.attributedText = attrStr
        QRName.font = font
            
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
            
        QRDescription.attributedText = attrStr1
        QRDescription.font = font
        
        //        already favourited button of note check
        if f.IsFavourite == 1
        {
            QuickRefFavBtn.image = UIImage(named: "AddFav")
        }
        else
        {
            QuickRefFavBtn.image = UIImage(named: "DeleteFav")
        }
    }
    
    
    @IBAction func QRFav(_ sender: Any) {
        if QuickRefFavBtn.image == UIImage(named: "DeleteFav")
        {
            QuickRefFavBtn.image = UIImage(named: "AddFav")
            DescriptionDAL.addFavourite(f:f)
        }
        else
        {
            QuickRefFavBtn.image = UIImage(named: "DeleteFav")
            DescriptionDAL.deleteFavourite(f:f)
        }
    }
}
