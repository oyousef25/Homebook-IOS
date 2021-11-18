//
//  CoreDataStack.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-17.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    
    init(modelName: String){
        self.modelName = modelName
    }
    
    lazy var persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            
            if let error = error as NSError?{
                fatalError("Unresolved error loading persistent container - \(error.userInfo)")
            }
        })
        
        return container
        
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    func saveContext(){
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error saving the information - \(nserror.userInfo)")
        }
    }
}
