//
//  FootballerManager.swift
//  SoccerPractice
//
//  Created by Duncan Davidson on 4/23/15.
//  Copyright (c) 2015 Mmyrmidons. All rights reserved.
//

import CoreData
import UIKit;

//private let _ofFootballers = Manager()
private var _error:NSError? = nil

class Manager {
//    class var ofFootballers: Manager {
//        return _ofFootballers;
//    }
    
    static let ofFootballers = Manager()
 
    func updateFootballer(_ player: Player) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Footballer")
        
        fetchRequest.predicate = NSPredicate(format: "benchTag == %d", player.view.tag)

        do {
            let footballers: [AnyObject] = try self.managedObjectContext!.fetch(fetchRequest)
            if footballers.count > 0
                {saveFootballer(footballers[0] as! Footballer, player: player)}
            else if let footballer = NSEntityDescription.insertNewObject(forEntityName: "Footballer", into: self.managedObjectContext!) as? Footballer
                {saveFootballer(footballer, player: player)}
        } catch let error as NSError {
            _error = error
        }
    }
    
    func saveFootballer(_ footballer: Footballer, player: Player) {
        footballer.benchTag = NSNumber(value: player.view.tag)
        footballer.fieldPositionX = NSNumber(value: Float(player.view.frame.origin.x))
        footballer.fieldPositionY = NSNumber(value: Float(player.view.frame.origin.y))
        footballer.side = NSStringFromClass(type(of: player))
        
        _error = nil
        
        do {
            try self.managedObjectContext!.save()
        } catch let error as NSError {
            _error = error
            NSLog("Unresolved error \(_error), \(_error!.userInfo)")
            abort()
        }
        
        print("Hi Miss Tikkie: \(footballer)")
    }
    
    func takeTheField() -> [Player] {
        var players = [Player]()
        let fetchRequest = NSFetchRequest<Footballer>(entityName: "Footballer")

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "benchTag", ascending: true)]
        _error = nil
        
        let fetchedFootballers = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedFootballers.performFetch()
            
            for fetchedFootballer:Footballer in fetchedFootballers.fetchedObjects! {
                print("Hi Miss Callie: \(fetchedFootballer) :: \(fetchedFootballer.side)")
                
                if let playerClass = NSClassFromString(fetchedFootballer.side) as? Player.Type {
                    let starter = playerClass.init()
                        
                    starter.positionPlayer(CGFloat(fetchedFootballer.fieldPositionX), y: CGFloat(fetchedFootballer.fieldPositionY));
                    starter.view.tag = fetchedFootballer.benchTag.intValue;
                        
                    players.append(starter);
                }
            }
        } catch let error as NSError {
            _error = error
        }
        
        if let error = _error {
            print("Fetch error: \(error)")
        }
        
        return players;
    }
    
    func sendOff(_ player: Player) {
        _error = nil;
        let fetchRequest = NSFetchRequest<Footballer>(entityName: "Footballer")
        
        fetchRequest.predicate = NSPredicate(format: "benchTag == %d", player.view.tag)

        do {
            let footballers = try self.managedObjectContext!.fetch(fetchRequest)

            if footballers.count > 0 {
                self.managedObjectContext?.delete(footballers[0])
                
                do {
                    try self.managedObjectContext?.save()
                } catch let error as NSError {
                    _error = error
                }
            }
        } catch let error as NSError {
            _error = error
        }
        
        if let error = _error {
            print("Error = \(error)")
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "mmyrmidons.EarlesSoccerField" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] 
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "SoccerPractice", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SoccerPractice.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            
            let dict: [AnyHashable: Any] = [
                NSLocalizedDescriptionKey : "Failed to initialize the application's saved data",
                NSLocalizedFailureReasonErrorKey : failureReason,
                NSUnderlyingErrorKey : error!
            ]
            
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
}
