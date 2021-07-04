//
//  DataManager.swift
//  Maluscation
//
//  Created by Gilbert Nicholas on 03/07/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func insertPlace(name: String, price: Int64, discount: Float, category: String, location: String, status: Bool, facility: [String], image: Data, totalUp: Int64, totalDown: Int64, totalHygiene: Int64) {
        
        var newPlace = DestinationPlace(context: self.context)
        newPlace.name = name
        newPlace.price = price
        newPlace.discount = discount
        newPlace.category = category
        newPlace.location = location
        newPlace.status = status
        newPlace.facility = facility
        newPlace.id = UUID()
        newPlace.isSaved = false
        newPlace.isBooked = false
        newPlace.image = image
        newPlace.totalUpvote = totalUp
        newPlace.totalDownvote = totalDown
        newPlace.totalHygiene = totalHygiene
        save()
    }
    
    func insertUser(name: String, email: String) {
        var newUser = User(context: self.context)
        newUser.name = name
        newUser.email = email
        
        save()
    }
    
    func getAllData<T:NSManagedObject>(entity: T.Type) -> [T] {
        
        var data : [T] = []
        let entityName = String(describing: entity)
        
        do{
            
            let request:NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
            
//            if (entityName == "Project") {
//                request.sortDescriptors = [NSSortDescriptor(key:"lastModified",ascending: false)]
//            }
            
            data = try context.fetch(request)
            
        }
        catch{
            print("Error fetching data")
        }
        return data
    }
    
    func getPlaceBasedOnCategory(categoty: String) -> [DestinationPlace]{
        
        var tempPlaces: [DestinationPlace] = []
        
        do {
            let request = DestinationPlace.fetchRequest() as NSFetchRequest<DestinationPlace>
            
            let pred = NSPredicate(format: "category == %@", categoty)
            request.predicate = pred
            
            tempPlaces = try context.fetch(request)
            
        } catch {
            print("Error Fetch Place")
        }
        
        return tempPlaces
    }
    
    private func save() {
        do {
            try self.context.save()
        } catch {
            print("Save Error!")
        }
    }
}
