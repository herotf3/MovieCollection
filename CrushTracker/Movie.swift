//
//  File.swift
//  CrushTracker
//
//  Created by MacBook on 8/14/18.
//  Copyright © 2018 MacBook. All rights reserved.
//
import UIKit
import Foundation
import os.log

class Movie :NSObject, NSCoding
{
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("movies")
    
    //MARK: Properties
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    var name: String
    var rating: Int
    var image: UIImage?
    //MARK: Initialization
    init?(name:String,rating:Int,image: UIImage?) {
        //A guard statement
        guard !name.isEmpty else{
            return nil
        }
        guard rating>=0 && rating<6 else{
            return nil
        }
        self.name=name
        self.rating=rating
        self.image=image
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let image = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        // Must call designated initializer.
        self.init(name: name, rating: rating, image: image)
    }
    
    
    //MARK: NSCoder
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(image, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
}
