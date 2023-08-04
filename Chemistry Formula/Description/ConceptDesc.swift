//
//  ConceptDesc.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 21/03/23.
//

import UIKit

class ConceptDesc: UIViewController {
    
    @IBOutlet weak var ConceptFavBtn: UIBarButtonItem!
    
    @IBOutlet weak var ConceptName: UILabel!
    
    @IBOutlet weak var ConceptDescription: UILabel!
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
            
        ConceptName.attributedText = attrStr
        ConceptName.font = font
            
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
            
        ConceptDescription.attributedText = attrStr1
        ConceptDescription.font = font
        
        //        already favourited button of note check
        if f.IsFavourite == 1
        {
            ConceptFavBtn.image = UIImage(named: "AddFav")
        }
        else
        {
            ConceptFavBtn.image = UIImage(named: "DeleteFav")
        }
    }
    
    
    @IBAction func ConFav(_ sender: Any) {
        if ConceptFavBtn.image == UIImage(named: "DeleteFav")
        {
            ConceptFavBtn.image = UIImage(named: "AddFav")
            DescriptionDAL.addFavourite(f:f)
        }
        else
        {
            ConceptFavBtn.image = UIImage(named: "DeleteFav")
            DescriptionDAL.deleteFavourite(f:f)
        }
    }
}
