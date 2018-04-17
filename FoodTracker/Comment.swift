//
//  Comment.swift
//  FoodTracker
//
//  Created by Yaroslav Skachkov on 17.04.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import Foundation

class Comment {
    
    
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
    
}
