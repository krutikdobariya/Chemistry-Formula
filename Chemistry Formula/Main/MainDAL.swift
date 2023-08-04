//
//  MainDAL.swift
//  Chemistry Formula
//
//  Created by krutik dobariya on 09/03/23.
//

import UIKit

class MainDAL: NSObject {
    
    
//collection view cell data list
    class func getProfile()->[Topic]
    {
        var topic : [Topic] = []
        let dbcon = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbcon.open()
        {
            let query = "select * from MST_Topic "
            
            do{
                let resultSet = try dbcon.executeQuery(query, values: [])
                while resultSet.next()
                {
                    let m : Topic = Topic()
                    m.TopicId =  resultSet.int(forColumn: "TopicID")
                    m.mainTopic = resultSet.string(forColumn: "TopicDisplayName")!
                    m.mainImage = "\(m.mainTopic).png"
                    
                    topic.append(m)
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
        return topic
    }
}
