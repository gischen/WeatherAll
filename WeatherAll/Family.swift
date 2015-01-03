//
//  Family.swift
//  WeatherAll
//
//  Created by Grapestree on 14/12/19.
//  Copyright (c) 2014年 Grapestree. All rights reserved.
//

import Foundation
import CoreData


@objc(Family)
class Family: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var address: String
    func ShowAll()->String{
        
        
        println("name : \(self.name) address :\(self.address)")
        return name + address
    }
}
