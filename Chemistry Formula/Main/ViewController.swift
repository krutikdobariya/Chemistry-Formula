//
//  ViewController.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 28/02/23.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var f : Formula = Formula()
    var formula : [Formula] = []
    var topic : [Topic] = []
    
    var List : [String] = ["Check for Update" , "Feedback" , "Share App" , "About us" , "Other Apps"]
    
//    collectionview design
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topic = MainDAL.getProfile()
        self.title = "Chemistry Formula"
        popUpView.isHidden = true
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                let width = (UIScreen.main.bounds.size.width - 30) / 3
                //let width = (cvDashboard.layer.frame.width-60) / 3
                layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
                layout.itemSize = CGSize(width: width, height: width)
                layout.minimumInteritemSpacing = 10;
                layout.minimumLineSpacing = 10;
        collectionView!.collectionViewLayout = layout
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:
        "cell", for: indexPath) as! CollectionViewCell
        
        let t : Topic = topic[indexPath.row]
        
        cell.collimage.image = UIImage(named: t.mainImage)
        cell.collLable.text = t.mainTopic
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let list :  FormulaList = storyboard?.instantiateViewController(withIdentifier: "FormulaList") as! FormulaList
        let t : Topic = topic[indexPath.row]
        list.f1 = t
        self.navigationController?.pushViewController(list, animated: true)
    }
//    table view started
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : PopUpViewCell = tableView.dequeueReusableCell(withIdentifier:
        "cell", for: indexPath) as! PopUpViewCell
        
        cell.ListName.text = List[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            UIApplication.shared.openURL(URL(string:"http://tiny.cc/ispeed")!)
        }
        if indexPath.row == 1
        {
           
        }
        if indexPath.row == 2
        {
            let textToShare = "Download App to Chemistry Formula from App Store: "
            let objectsToShare = [textToShare]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        if indexPath.row == 3
        {
            let DEV :  DeveloperViewController = storyboard?.instantiateViewController(withIdentifier: "DeveloperViewController") as! DeveloperViewController
            self.navigationController?.pushViewController(DEV, animated: true)
        }
        if indexPath.row == 4
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.openURL(URL(string:"https://apps.apple.com/in/developer/g-sanghani/id772995906")!)
            }
            else
            {
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row

        if let collection = self.collectionView{
                let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                return CGSize(width: width, height: width)
            } else {
                return CGSize(width: 0, height: 0)
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return spacingBetweenCells
        }
    
//    collection view constraint start
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
//
//
//        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
//        return CGSize(width: width, height: width)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return spacingBetweenCells
//    }
    
//    collection view constraint end
    
//  favourite list
    @IBAction func FavouriteList(_ sender: Any) {
        let list :  FavouritList = storyboard?.instantiateViewController(withIdentifier: "FavouritList") as! FavouritList
        
        self.navigationController?.pushViewController(list, animated: true)
    }
    
    @IBAction func popUpbtn(_ sender: Any) {
        
        if popUpView.isHidden == false
        {
            popUpView.isHidden = true
        }
        else{
            popUpView.isHidden = false
        }
        
    }
    
    
    @IBAction func CancleBtn(_ sender: Any) {
        popUpView.isHidden = true
        
    }
}

