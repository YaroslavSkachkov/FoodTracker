//
//  Comment.swift
//  FoodTracker
//
//  Created by Yaroslav Skachkov on 17.04.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import Foundation

class Comment: NSObject, NSCoding {
    
    var comment: String
    var date: Date
    
    init(comment: String, date: Date){
        self.comment = comment
        self.date = date
    }
    
    func localizedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    struct PropertyKey {
        static let comment = "comment"
        static let date = "date"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(comment, forKey: PropertyKey.comment)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let comment = aDecoder.decodeObject(forKey: PropertyKey.comment) as? String else {
            return nil
        }
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as! Date
        self.init(comment: comment, date: date)
    }
    
    
    
}
