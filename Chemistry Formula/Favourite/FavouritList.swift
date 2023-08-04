//
//  FavouritList.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 20/03/23.
//

import UIKit

class FavouritList: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var f1 : Topic = Topic()
    var f : Formula = Formula()
    var formula : [Formula] = []
    var t : Topic = Topic()

    @IBOutlet weak var FavTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourite List"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        formula =  FavouritDAL.getFav()
        FavTableView.reloadData()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formula.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : FavouritCell = tableView.dequeueReusableCell(withIdentifier:
        "cell", for: indexPath) as! FavouritCell
        
        let font = UIFont.systemFont(ofSize: 17)
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 242/255, green: 210/255, blue: 189/255, alpha: 1)
        }
        else{
            cell.backgroundColor = UIColor(red: 250/255, green: 200/255, blue: 152/255, alpha: 1)
//            cell.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        }
        
        let f : Formula = formula[indexPath.row]
//      html to text converter start
        let htmlString1  = f.FormulaName
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.alignment = .justified
        paragraphStyle1.firstLineHeadIndent = 0.001
        
        let attrStr1 = try!  NSAttributedString(data:  htmlString1.data(using: String.Encoding.utf8)!,
                                               options: [.documentType: NSAttributedString.DocumentType.html,
                                                         .characterEncoding: String.Encoding.utf8.rawValue],
                                               documentAttributes: nil)
//      html to text converter end
        cell.FavImage.image = UIImage(named: f.FormulaImage )
        cell.FavFormulaName.attributedText = attrStr1
        cell.FavTopicName.text = f.FormulaTopicName
        cell.FavFormulaName.font = font
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let DEC :  Description = storyboard?.instantiateViewController(withIdentifier: "Description") as! Description
        
        let MW :  MolecularWeight = storyboard?.instantiateViewController(withIdentifier: "MolecularWeight") as! MolecularWeight
        
        let QR :  QuickReference = storyboard?.instantiateViewController(withIdentifier: "QuickReference") as! QuickReference
        
        let GL :  GasLawDesc = storyboard?.instantiateViewController(withIdentifier: "GasLawDesc") as! GasLawDesc
        
        let CO :  ConceptDesc = storyboard?.instantiateViewController(withIdentifier: "ConceptDesc") as! ConceptDesc
        
        let  f:Formula = formula[indexPath.row]
        
        if f.FormulaID == 1
        {
            DEC.f = f
            self.navigationController?.pushViewController(DEC, animated: true)
        }
        else if f.FormulaID == 2
        {
            GL.f = f
            self.navigationController?.pushViewController(GL, animated: true)
        }
        else if f.FormulaID == 3
        {
            CO.f = f
            self.navigationController?.pushViewController(CO, animated: true)
        }
        else if f.FormulaID == 4
        {
            QR.f = f
            self.navigationController?.pushViewController(QR, animated: true)
        }
        else{
            MW.f = f
            self.navigationController?.pushViewController(MW, animated: true)
        }
    }
    

}
