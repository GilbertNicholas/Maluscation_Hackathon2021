//
//  ReceiptViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 03/07/21.
//

import UIKit

class ReceiptViewController: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var paymentOptLabel: UILabel!
    @IBOutlet weak var accountOwnerLabel: UILabel!
    @IBOutlet weak var paymentDateLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var qrCodeButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var paymentStatusButton: UIButton!
    
    @IBOutlet weak var villaNameView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var paymentView: UIView!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    var bookingId: UUID?
    
    var DataManager: CoreDataManager?
    var bookings: [Booking]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager = CoreDataManager()
        
        // MARK: Uncomment this to get booking by bookingId
//        bookings = DataManager?.getBookingBasedOnId(id: bookingId!)
        
        setUpView()
    }
    
    func setUpView() {
        // MARK: Uncomment if bookingId has been generated
//        fullNameLabel.text = bookings[0].name
//        dateLabel.text = "\(bookings[0].checkIn!) - \(bookings[0].checkOut!)"
//        paymentOptLabel.text = bookings[0].paymentOpt
//        accountOwnerLabel.text = bookings[0].name
//        totalPriceLabel.text = "IDR \(bookings[0].totalPrice)"
        
        leftView.layer.cornerRadius = 4
        leftView.layer.backgroundColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        rightView.layer.cornerRadius = 4
        rightView.layer.backgroundColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        villaNameView.layer.opacity = 0.4
        
        dateView.layer.borderWidth = 4
        dateView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        paymentView.layer.borderWidth = 4
        paymentView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        qrCodeButton.layer.cornerRadius = 15
        qrCodeButton.layer.shadowOpacity = 0.5
        qrCodeButton.layer.shadowRadius = 6
        qrCodeButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        qrCodeButton.layer.borderWidth = 2
        qrCodeButton.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        reviewButton.layer.cornerRadius = 15
        reviewButton.layer.shadowOpacity = 0.5
        reviewButton.layer.shadowRadius = 6
        reviewButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        reviewButton.layer.borderWidth = 2
        reviewButton.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        paymentStatusButton.layer.cornerRadius = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReview" {
            guard let nextVC = segue.destination as? ReviewViewController else {
                return
            }
            
            nextVC.bookingId = self.bookingId
        }
    }
    
    @IBAction func qrCodeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toQRCode", sender: nil)
    }
    
    @IBAction func reviewButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toReview", sender: nil)
    }
    
}
