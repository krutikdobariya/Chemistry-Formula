//
//  FormulaDAL.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 10/03/23.
//

import UIKit

class FormulaDAL: NSObject {
    
//    formula list data
    class func getFormula(formulaId : Int32)->[Formula]
    {
        var formula : [Formula] = []
        let dbcon = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbcon.open()
        {
            let query = "select * from MST_SubTopic inner join MST_Formula on MST_SubTopic.SubTopicID = MST_Formula.SubTopicID where TopicID = '\(formulaId)'"
            
            do{
                let resultSet = try dbcon.executeQuery(query, values: [])
                while resultSet.next()
                {
                    let f : Formula = Formula()
                    
                    f.TopicID = resultSet.int(forColumn: "TopicID")
                    f.FormulaID = resultSet.int(forColumn: "TopicID")
                    f.SubTopicID = resultSet.int(forColumn: "SubTopicID")
                    f.FormulaTitle = resultSet.string(forColumn: "SubTopicDisplayName")!
                    f.FormulaName = resultSet.string(forColumn: "SubTopicName")!
                    f.Formula = resultSet.string(forColumn: "Formula")!
                    if f.FormulaID == 5
                    {
                        
                    }
                    else{
                        f.FormulaDescription = resultSet.string(forColumn: "TopicDescription")!
                    }
                    f.FormulaRemark = resultSet.bool(forColumn: "Remarks")
                    f.IsFavourite = resultSet.int(forColumn: "IsFavourite")
                    if f.FormulaID == 1
                    {
                        f.FormulaImage = "Chemical Formula.png"
                    }
                    else if f.FormulaID == 2
                    {
                        f.FormulaImage = "Gas Laws.png"
                    }
                    else if f.FormulaID == 3
                    {
                        f.FormulaImage = "Concepts.png"
                    }
                    else if f.FormulaID == 4
                    {
                        f.FormulaImage = "Quick Reference.png"
                    }
                    else if f.FormulaID == 5
                    {
                        f.FormulaImage = "Molecular Weight.png"
                    }
                    
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
    
//  favourite added data list 
    
    
    
    
    
}
