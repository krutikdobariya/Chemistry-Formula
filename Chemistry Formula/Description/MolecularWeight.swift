//
//  MolecularWeight.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 20/03/23.
//

import UIKit
import Foundation

class MolecularWeight: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var formulaName: UILabel!
    @IBOutlet weak var formulaEquation: UILabel!
    @IBOutlet weak var totalMass: UILabel!
    @IBOutlet weak var hight_cons: NSLayoutConstraint!
    
    @IBOutlet weak var MolecularWeightFavBtn: UIBarButtonItem!
    var f : Formula = Formula()
    var formula : [Formula] = []
    var name : String = ""
    var word : String = ""
    var Atom1 : [String : Int] = [:]
    var keyArray : [String] = []
    var valueArray : [Int] = []
    var atom : [Atom] = []
    var a : Atom = Atom()
    var totalmass : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = f.FormulaTitle
        atom = DescriptionDAL.getatom()
        hight_cons.constant -= 44
//        html to sring convert start
        
        let htmlString1  = f.FormulaName
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.alignment = .justified
        paragraphStyle1.firstLineHeadIndent = 0.001
        
        let attrStr1 = try!  NSAttributedString(data:  htmlString1.data(using: String.Encoding.utf8)!,
                                               options: [.documentType: NSAttributedString.DocumentType.html,
                                                         .characterEncoding: String.Encoding.utf8.rawValue],
                                               documentAttributes: nil)
//        html to sring convert end
        
//        string divide in to to part start
        
        let originalString = attrStr1.string
        let searchString = " Or "
        if let range = originalString.range(of: searchString) {
            // Create attributed string from original string
            let attributedString = NSMutableAttributedString(string: originalString)
            
            // Create first substring
            let firstSubstringRange = NSRange(location: 0, length: originalString.distance(from: originalString.startIndex, to: range.lowerBound))
            let firstSubstring = attributedString.attributedSubstring(from: firstSubstringRange)
            
            // Create second substring
            let secondSubstringRange = NSRange(location: originalString.distance(from: originalString.startIndex, to: range.upperBound), length: originalString.count - originalString.distance(from: originalString.startIndex, to: range.upperBound))
            let secondSubstring = attributedString.attributedSubstring(from: secondSubstringRange)
            name = secondSubstring.string
            word = firstSubstring.string
            
            print(firstSubstring.string) // prints "h20"
            print(secondSubstring.string) // prints " Water!"
        }
//        string divide in to to part end
        
        formulaName.text = name
        formulaEquation.text = word
        
        let chemicalFormula = word
        var elementCounts = [String: Int]()

        var currentElement = ""
        var currentCount = ""

        for character in chemicalFormula {
            if character.isUppercase {
                // Start of a new element
                if !currentElement.isEmpty {
                    // Add count of previous element to the dictionary
                    let count = Int(currentCount) ?? 1
                    elementCounts[currentElement, default: 0] += count
                    
                    currentCount = ""
                }
                currentElement = String(character)
            } else if character.isLowercase {
                // Append lowercase character to current element symbol
                currentElement.append(character)
            } else if character.isNumber {
                // Parse number of atoms of current element
                currentCount.append(character)
            }
        }
        // Add count of last element to the dictionary
        let count = Int(currentCount) ?? 1
        elementCounts[currentElement, default: 0] += count
        
        Atom1 = elementCounts
        
        print(elementCounts)
        
        for (key, value) in Atom1
        {
            keyArray.append(key)
            valueArray.append(value)
        }
        
        
        
        totalMass.text = String(totalmass)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Atom1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MolecularCell = tableView.dequeueReusableCell(withIdentifier:
        "cell", for: indexPath) as! MolecularCell
        print(indexPath.row)
        if(indexPath.row == (Atom1.count - 1))
        {
            hight_cons.constant -= 0
        }
       else
        {
           hight_cons.constant += 44
       }
        print(Atom1.count)
        var count1 = 0
        var total : Double = 0
        var atommas : Double = 0
        while(count1 != 111){
            let a : Atom = atom[count1]
            if(keyArray[indexPath.row] == a.atomname){
                atommas = Double(a.atommass)
                break
            }
            count1 = count1 + 1
        }
        var count2 = 0
        while(count2 != valueArray[indexPath.row]){
            total = total + atommas
            count2 = count2 + 1
        }
        totalmass = totalmass + total
        totalMass.text = String(round(totalmass*10000)/10000)
        cell.atomName.text = keyArray[indexPath.row]
        cell.atomNo.text = String(valueArray[indexPath.row])
        cell.molarMass.text = String(atommas)
        cell.subTotalMass.text = String(round(total * 10000)/10000)
        return cell
    }
    
    
    @IBAction func MWFav(_ sender: Any) {
        if MolecularWeightFavBtn.image == UIImage(named: "DeleteFav")
        {
            MolecularWeightFavBtn.image = UIImage(named: "AddFav")
            DescriptionDAL.addFavourite(f:f)
        }
        else
        {
            MolecularWeightFavBtn.image = UIImage(named: "DeleteFav")
            DescriptionDAL.deleteFavourite(f:f)
        }
    }
}
