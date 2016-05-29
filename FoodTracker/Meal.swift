//
//  Meal.swift
//  FoodTracker
//
//  Created by Antonia Blair on 5/24/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    // question mark shows it's optional
    var rating: Int
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    /**
     Using the NSCoding approach, the Meal class is in charge of storing and
     loading each of its properties. 
     It needs to save its data by assigning the value of each 
     property to a particular key, and load the data by looking up
     the information associated with that key. **/
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    
    // MARK: Initialization
    // prepare the class for use by setting an initial value for each property and performing any other setup or initialization.
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    // MARK: NSCoding
    
    // encode value of each property on the Meal class and store them with their corresponding key
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    // declaring this initializer as a convenience initializer because it only applies when there’s saved data to be loaded.
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
    
}



