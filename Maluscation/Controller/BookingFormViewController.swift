//
//  BookingFormViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 03/07/21.
//

import UIKit
import CoreData

class BookingFormViewController: UIViewController {
    
    @IBOutlet weak var villaDetailView: UIView!
    @IBOutlet weak var villaNameView: UIView!
    @IBOutlet weak var zoneView: UIView!
    @IBOutlet weak var userDetailView: UIView!
    
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var paymentOptionView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var checkInDate: UIDatePicker!
    @IBOutlet weak var checkOutDate: UIDatePicker!
    @IBOutlet weak var paymentOptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let date = Calendar.current.date(byAdding: .day, value: 1, to: Date())
    let formatter = DateFormatter()
    
    var fullName: String?
    var email: String?
    var phoneNumber: String?
    var paymentOpt: String?
    var totalPrice: Float?
    
    var DataManager: CoreDataManager!
    var destinationPlace: [DestinationPlace]!
    
    var id: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        destinationPlace = DataManager.getPlaceBasedOnId(id: id!)
        
//        for dest in destinationPlace {
//            print(dest)
//        }
        
        setUpView()
    }
    
    func setUpView() {
        checkInDate.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        checkOutDate.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDate.minimumDate!)
        
        // TODO: Replace with Apple ID's data
        userNameLabel.text = fullName ?? "Stefan Adisurya"
        
        paymentOptLabel.text = paymentOpt ?? "Choose"
        
        if paymentOptLabel.text == "Choose" {
            paymentOptLabel.textColor = .gray
        } else {
            paymentOptLabel.textColor = UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        }
        
        totalPrice = 2000000
        
        payButton.layer.cornerRadius = 20
        
        userDetailView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDetailTapped(_:))))
        
        villaDetailView.layer.borderWidth = 4
        villaDetailView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        villaNameView.layer.opacity = 0.4
        
        zoneView.layer.shadowOpacity = 0.5
        zoneView.layer.shadowRadius = 3
        zoneView.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        
        checkInView.layer.borderWidth = 4
        checkInView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        checkOutView.layer.borderWidth = 4
        checkOutView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        bottomView.layer.borderWidth = 4
        bottomView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        paymentOptionView.layer.borderWidth = 4
        paymentOptionView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        paymentOptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(paymentOptTapped(_:))))
    }
    
    @objc func userDetailTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toUserDetail", sender: nil)
    }
    
    @objc func paymentOptTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toPaymentOpt", sender: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        
        let deleteAll = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Booking"))
                
        do {
            try managedContext.execute(deleteAll)
        }
        catch {
            print(error)
        }
    }
    
    func popUpAlert() {
        let alert = UIAlertController(title: "Please fill the form correctly", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func performUnwindSegueOperation(_ sender: UIStoryboardSegue) {
        guard sender.source is PaymentOptViewController else {
            return
        }

        paymentOptLabel.text = paymentOpt
        paymentOptLabel.textColor = UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
    }
    
    @IBAction func performUnwindSegue2(_ sender: UIStoryboardSegue) {
        guard sender.source is UserDetailViewController else {
            return
        }

        userNameLabel.text = fullName
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if userNameLabel.text != "" && paymentOptLabel.text != "Choose" {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext = appDelegate.persistentContainer.viewContext

            let entity = NSEntityDescription.entity(forEntityName: "Booking", in: managedContext)!

            let bookingDetails = NSManagedObject(entity: entity, insertInto: managedContext)
            bookingDetails.setValue(userNameLabel.text, forKey: "name")
            bookingDetails.setValue(email, forKey: "email")
            bookingDetails.setValue(phoneNumber, forKey: "phone")
            bookingDetails.setValue(checkInDate.date, forKey: "checkIn")
            bookingDetails.setValue(checkOutDate.date, forKey: "checkOut")
            bookingDetails.setValue(totalPrice, forKey: "totalPrice")
        
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            performSegue(withIdentifier: "toPaymentStatus", sender: nil)
        } else {
            popUpAlert()
        }
    }
    
}
