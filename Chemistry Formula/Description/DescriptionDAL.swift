//
//  DescriptionDAL.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 20/03/23.
//

import UIKit

class DescriptionDAL: NSObject {
    
//    Description data list
    class func getDescription()->[Formula]
    {
        var desc : [Formula] = []
        let dbcon = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbcon.open()
        {
            let query = "select * from MST_Formula"
            
            do{
                let resultSet = try dbcon.executeQuery(query, values: [])
                while resultSet.next()
                {
                    let d : Formula = Formula()
                    d.FormulaID = resultSet.int(forColumn: "FormulaID")
                    d.SubTopicID = resultSet.int(forColumn: "SubTopicID")
                    d.FormulaName = resultSet.string(forColumn: "Formula")!
//                    d.FormulaDescription = resultSet.string(forColumn: "TopicDescription")!
                    d.FormulaRemark = resultSet.bool(forColumn: "Remarks")
                    
                    desc.append(d)
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
        return desc
    }
    
    
//    add favourite formula
    class func addFavourite(f : Formula)-> Bool
    {
        var status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "update MST_SubTopic set IsFavourite = 1 where SubTopicID = '\(f.SubTopicID)'"
            do{
                let resultSet = try dbConn.executeUpdate(query, withArgumentsIn: [])
                
                if resultSet
                {
                    
                    status = true
                }
                else
                {
                    status = false
                }
            }
            catch
            {
                print("error")
            }
        }
        else
        {
            print("Not Connection with database")
        }
        
        dbConn.close()
        
        
        return status
    }
    
    
//    delete favourite formula
    class func deleteFavourite(f: Formula) -> Bool
    {
        var status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            
            
            let query = "update MST_SubTopic set IsFavourite = 0 where SubTopicID = '\(f.SubTopicID)'  "
            do{
                let resultSet = try dbConn.executeUpdate(query, withArgumentsIn: [])
                
                if resultSet
                {
                    
                    status = true
                }
                else
                {
                    status = false
                }
            }
            catch
            {
                print("error")
            }
            
        }
        else
        {
            print("Not Connection with database")
        }
        
        dbConn.close()
        
        
        return status
        
    }
    
    class func getatom()->[Atom]
    {
        var atom : [Atom] = []
        let dbcon = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbcon.open()
        {
            let query = "select * from MST_Molecular"
            
            do{
                let resultSet = try dbcon.executeQuery(query, values: [])
                while resultSet.next()
                {
                    let a : Atom = Atom()
                    a.atomname = resultSet.string(forColumn: "ElementSymbol")!
                    a.atommass = resultSet.double(forColumn: "AtomicMass")
                    atom.append(a)
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
        return atom
    }
    
}
