//
//  Meal.swift
//  FoodTracker
//
//  Created by Yaroslav Skachkov on 16.03.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var comments: Array<Comment>
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let comments = "comments"
    }
   
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // Failable initializer
    init?(name: String, photo: UIImage?, rating: Int, comments: Array<Comment>) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
        self.comments = comments
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(comments, forKey: PropertyKey.comments)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        let comments = (aDecoder.decodeObject(forKey: PropertyKey.comments) as? Array<Comment>) ?? Array<Comment>()
        // Must call designated initializer
        self.init(name: name, photo: photo, rating: rating, comments: comments)
    }
    
}
