//
//  Footballer.swift
//  SoccerPractice
//
//  Created by Dunc on 8/16/15.
//  Copyright (c) 2015 Mmyrmidons. All rights reserved.
//

import Foundation
import CoreData

class Footballer: NSManagedObject {

    @NSManaged var benchTag: NSNumber
    @NSManaged var fieldPositionX: NSNumber
    @NSManaged var fieldPositionY: NSNumber
    @NSManaged var side: String

}
