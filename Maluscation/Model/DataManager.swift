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
    
    func insertBooking(bookingId: UUID, name: String, email: String, phone: String, checkIn: Date, checkOut: Date, paymentOpt: String, bookingToPlace: DestinationPlace?, bookingToUser: User?) {
        var newBooking = Booking(context: self.context)
        newBooking.bookingId = bookingId
        newBooking.name = name
        newBooking.email = email
        newBooking.phone = phone
        newBooking.checkIn = checkIn
        newBooking.checkOut = checkOut
        newBooking.paymentOpt = paymentOpt
        newBooking.bookingToPlace = bookingToPlace
        newBooking.bookingToUser = bookingToUser
        
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
    
    func getAllBookings() -> [Booking] {
        
        var tempPlaces: [Booking] = []
        
        do {
            let request = Booking.fetchRequest() as NSFetchRequest<Booking>
            
            tempPlaces = try context.fetch(request)
            
        } catch {
            print("Error Fetch Place")
        }
        
        return tempPlaces
    }
    
    func getAllSaved() -> [DestinationPlace] {
        var tempPlaces: [DestinationPlace] = []
        
        do {
            let request = DestinationPlace.fetchRequest() as NSFetchRequest<DestinationPlace>
            
            let pred = NSPredicate(format: "isSaved == %@", true)
            request.predicate = pred
            
            tempPlaces = try context.fetch(request)
            
        } catch {
            print("Error Fetch Place")
        }
        
        return tempPlaces
    }

    func updatePlaceRating(id: UUID, upvote:Bool, downvote:Bool, hygieneRating:Int64) {
        let chosenPlace = getBookingBasedOnId(id: id)
        
        if upvote {
            chosenPlace[0].bookingToPlace!.totalUpvote += 1
        } else if downvote {
            chosenPlace[0].bookingToPlace!.totalDownvote += 1
        }
        
        let totalBooked = chosenPlace[0].bookingToPlace!.totalUpvote + chosenPlace[0].bookingToPlace!.totalDownvote
        
        chosenPlace[0].bookingToPlace!.totalHygiene = ((chosenPlace[0].bookingToPlace!.totalHygiene * totalBooked) + hygieneRating) / totalBooked + 1
        save()
    }
    
    func getBookingBasedOnId(id: UUID) -> [Booking] {
        var tempBookings: [Booking] = []
        
        do {
            let request = Booking.fetchRequest() as NSFetchRequest<Booking>
            
            let pred = NSPredicate(format: "id == %@", id as CVarArg)
            request.predicate = pred
            
            tempBookings = try context.fetch(request)
        } catch {
            print("Error Fetch Place")
        }
        
        return tempBookings
    }
    
    private func save() {
        do {
            try self.context.save()
        } catch {
            print("Save Error!")
        }
    }
}
