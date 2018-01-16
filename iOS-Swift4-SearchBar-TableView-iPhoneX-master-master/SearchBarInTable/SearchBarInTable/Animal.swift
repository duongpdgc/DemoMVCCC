//
//  Animal.swift
//  SearchBarInTable
//
//  Created by PhamDucDuong on 1/13/18.
//  Copyright © 2018 PhamDucDuong. All rights reserved.
//

import UIKit
import os.log
class Animal {
    
    // MARK: Properties
    
    var name: String
    var image: String
    var category: AnimalType
    var ratings: Int
    
    // MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let image = "image"
        static let category = "category"
        static let rating = "rating"
    }
    
    // MARK : Initialization
    
    init(name: String, category: AnimalType, image: String, ratings: Int) {
        
        // Initialize
        self.name = name
        self.category = category
        self.image = image
        self.ratings = ratings
    }
    //MARK: NSCoding ( Ma hoa du lieu )
}

enum AnimalType: String {
    case cat = "Cat"
    case dog = "Dog"
}
