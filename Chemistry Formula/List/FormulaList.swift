
import UIKit
import WebKit
import StoreKit


class FormulaList: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating {
   
    @IBOutlet weak var TableView: UITableView!
    
    var f1 : Topic = Topic()
    var f : Formula = Formula()
    var formula : [Formula] = []
//    var t : Topic = Topic()
    
    var searching = false
    var filtered : [Formula] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = f1.mainTopic
        configureSearchController()
        
    }
    
    private func configureSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Formula by it's Name"
//        UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        formula =  FormulaDAL.getFormula(formulaId : f1.TopicId)
    }
    
    
//  searchbar start
    
    
//    tableview start
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching
        {
            return filtered.count
        }
        else{
            return formula.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier:
        "cell", for: indexPath) as! TableViewCell
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 242/255, green: 210/255, blue: 189/255, alpha: 1)
        }
        else{
            cell.backgroundColor = UIColor(red: 250/255, green: 200/255, blue: 152/255, alpha: 1)
//            cell.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        }
        
        let font = UIFont.systemFont(ofSize: 15)
        
        if searching
        {
            let s : Formula = filtered[indexPath.row]
            let htmlString  = s.FormulaName
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            paragraphStyle.firstLineHeadIndent = 0.001
            
            
            let attrStr = try!  NSAttributedString(data:  htmlString.data(using: String.Encoding.utf8)!,
                                                   options: [.documentType: NSAttributedString.DocumentType.html,
                                                             .characterEncoding: String.Encoding.utf8.rawValue],
                                                   documentAttributes: nil)
    //      html to text converter start
            
            cell.ListImage.image = UIImage(named: s.FormulaImage )
            cell.ListLable.attributedText = attrStr
            cell.ListLable.font = font
        }
        else{
            let f : Formula = formula[indexPath.row]
            
    //       html to text converter start
            let htmlString  = f.FormulaName
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            paragraphStyle.firstLineHeadIndent = 0.001
            
            
            let attrStr = try!  NSAttributedString(data:  htmlString.data(using: String.Encoding.utf8)!,
                                                   options: [.documentType: NSAttributedString.DocumentType.html,
                                                             .characterEncoding: String.Encoding.utf8.rawValue],
                                                   documentAttributes: nil)
    //      html to text converter start
            
            cell.ListImage.image = UIImage(named: f.FormulaImage )
            cell.ListLable.attributedText = attrStr
            cell.ListLable.font = font
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        let DEC :  Description = storyboard?.instantiateViewController(withIdentifier: "Description") as! Description
        
        let MW :  MolecularWeight = storyboard?.instantiateViewController(withIdentifier: "MolecularWeight") as! MolecularWeight
        
        let QR :  QuickReference = storyboard?.instantiateViewController(withIdentifier: "QuickReference") as! QuickReference
        
        let GL :  GasLawDesc = storyboard?.instantiateViewController(withIdentifier: "GasLawDesc") as! GasLawDesc
        
        let CO :  ConceptDesc = storyboard?.instantiateViewController(withIdentifier: "ConceptDesc") as! ConceptDesc
        
        SKStoreReviewController.requestReview()
        
        if searching{
            
            let  f:Formula = filtered[indexPath.row]
            if f1.TopicId == 1
            {
                
                DEC.f = f
                self.navigationController?.pushViewController(DEC, animated: true)
            }
            else if f1.TopicId == 2
            {
                GL.f = f
                self.navigationController?.pushViewController(GL, animated: true)
            }
            else if f1.TopicId == 3
            {
                CO.f = f
                self.navigationController?.pushViewController(CO, animated: true)
            }
            else if f1.TopicId == 4
            {
                QR.f = f
                self.navigationController?.pushViewController(QR, animated: true)
            }
            else if f1.TopicId == 5
            {
                MW.f = f
                self.navigationController?.pushViewController(MW, animated: true)
            }
        }
        else{            
            let  f:Formula = formula[indexPath.row]
            if f1.TopicId == 1
            {
                
                DEC.f = f
                self.navigationController?.pushViewController(DEC, animated: true)
            }
            else if f1.TopicId == 2
            {
                GL.f = f
                self.navigationController?.pushViewController(GL, animated: true)
            }
            else if f1.TopicId == 3
            {
                CO.f = f
                self.navigationController?.pushViewController(CO, animated: true)
            }
            else if f1.TopicId == 4
            {
                QR.f = f
                self.navigationController?.pushViewController(QR, animated: true)
            }
            else if f1.TopicId == 5
            {
                MW.f = f
                self.navigationController?.pushViewController(MW, animated: true)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty
        {
            searching = true
            filtered.removeAll()
            for list in formula
            {
                if list.FormulaName.lowercased().contains(searchText.lowercased())
                {
                    filtered.append(list)
                }
            }
        }
        else{
            searching = false
            filtered.removeAll()
            filtered = formula
        }
        TableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searching = false
        filtered.removeAll()
        TableView.reloadData()
    }
    
}
