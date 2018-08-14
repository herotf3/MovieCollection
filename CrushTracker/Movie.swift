//
//  File.swift
//  CrushTracker
//
//  Created by MacBook on 8/14/18.
//  Copyright © 2018 MacBook. All rights reserved.
//
import UIKit
import Foundation

class Movie
{
    var name: String
    var rating: Int
    var image: UIImage?

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
}
