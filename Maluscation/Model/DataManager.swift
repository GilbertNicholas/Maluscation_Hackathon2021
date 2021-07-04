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
    
    func getPlaceBasedOnId(id: UUID) -> [DestinationPlace] {
        var tempPlaces: [DestinationPlace] = []
        
        do {
            let request = DestinationPlace.fetchRequest() as NSFetchRequest<DestinationPlace>
            
            let pred = NSPredicate(format: "id == %@", id as CVarArg)
            request.predicate = pred
            
            tempPlaces = try context.fetch(request)
        } catch {
            print("Error Fetch Place")
        }
        
        return tempPlaces
    }
    
    func updatePlaceRating(id: UUID, upvote:Bool, downvote:Bool, hygieneRating:Int64) {
        let chosenPlace = getPlaceBasedOnId(id: id)
        
        if upvote {
            chosenPlace[0].totalUpvote += 1
        } else if downvote {
            chosenPlace[0].totalDownvote += 1
        }
        
        let totalBooked = chosenPlace[0].totalUpvote + chosenPlace[0].totalDownvote
        
        chosenPlace[0].totalHygiene = ((chosenPlace[0].totalHygiene * totalBooked) + hygieneRating) / totalBooked + 1
        save()
    }
    
    func createReview(user: User, place: DestinationPlace) {
        
        var newReview = Review(context: self.context)
        newReview.reviewToUser = user
        newReview.reviewToPlace = place

        save()
        print("Scene Created")
    }
    
    private func save() {
        do {
            try self.context.save()
        } catch {
            print("Save Error!")
        }
    }
}
