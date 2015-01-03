//
//  Member.swift
//  WeatherAll
//
//  Created by Grapestree on 14/12/19.
//  Copyright (c) 2014年 Grapestree. All rights reserved.
//

import Foundation
import CoreData


@objc(Member)
class Member: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var birthday: NSTimeInterval
    @NSManaged var sex: String

}
