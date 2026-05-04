//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Manona on 04/05/2026.
//


import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveLeague(id: Int, name: String, logo: String) {
        
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: context)!
        let league = NSManagedObject(entity: entity, insertInto: context)
        
        league.setValue(id, forKey: "id")
        league.setValue(name, forKey: "name")
        league.setValue(logo, forKey: "logo")
        
        do {
            try context.save()
        } catch {
            print("Save error")
        }
    }
    
    func fetchLeagues() -> [NSManagedObject] {
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch error")
            return []
        }
    }
    
    func deleteLeague(id: Int) {
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let result = try context.fetch(request)
            
            for obj in result {
                context.delete(obj)
            }
            
            try context.save()
            
        } catch {
            print("Delete error")
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            return false
        }
    }
}