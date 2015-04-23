//
//  Footballer.swift
//  SoccerPractice
//
//  Created by Duncan Davidson on 4/23/15.
//  Copyright (c) 2015 Mmyrmidons. All rights reserved.
//

import Foundation
import CoreData

class Footballer: NSManagedObject {

    @NSManaged var fieldPositionX: NSNumber
    @NSManaged var side: NSNumber
    @NSManaged var fieldPositionY: NSNumber
    @NSManaged var benchTag: NSNumber

}
