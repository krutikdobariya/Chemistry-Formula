//
//  FavouritDAL.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 22/03/23.
//

import UIKit

class FavouritDAL: NSObject {
    class func getFav()->[Formula]
    {
        var formula : [Formula] = []
        let dbcon = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbcon.open()
        {
            let query = "select * from MST_SubTopic inner join MST_Topic on MST_SubTopic.TopicID =  MST_Topic.TopicID inner join MST_Formula on MST_SubTopic.SubTopicID =  MST_Formula.SubTopicID  where IsFavourite = 1"
            
            do{
                let resultSet = try dbcon.executeQuery(query, values: [])
                while resultSet.next()
                {
                    let f : Formula = Formula()
                    f.FormulaID = resultSet.int(forColumn: "TopicID")
                    f.SubTopicID = resultSet.int(forColumn: "SubTopicID")
                    f.FormulaTopicName = resultSet.string(forColumn: "TopicName")!
                    f.FormulaName = resultSet.string(forColumn: "SubTopicName")!
                    if f.FormulaID == 5
                    {
                        
                    }
                    else{
                        f.FormulaDescription = resultSet.string(forColumn: "TopicDescription")!
                    }
                    f.FormulaRemark = resultSet.bool(forColumn: "Remarks")
                    f.IsFavourite = resultSet.int(forColumn: "IsFavourite")
                    f.FormulaImage = "FavrouriteListImage.png"
                    
                    formula.append(f)
                }
                
            }
            catch{
                print(error)
            }
        }
        else{
            print("not connect database")
        }
        
        dbcon.close()
        return formula
    }
}
