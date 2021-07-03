//
//  ReceiptViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 03/07/21.
//

import UIKit

class ReceiptViewController: UIViewController {
    
    @IBOutlet weak var villaDetailView: UIView!
    @IBOutlet weak var bookingDetailView: UIView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var checkInLbl: UILabel!
    @IBOutlet weak var checkOutLbl: UILabel!
    
    var fullName: String?
    var email: String?
    var phoneNumber: String?
    var checkInDate: String?
    var checkOutDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        villaDetailView.layer.cornerRadius = 8
        villaDetailView.layer.opacity = 0.4
        
        bookingDetailView.layer.cornerRadius = 8
        bookingDetailView.layer.opacity = 0.4
        
        fullNameLbl.text = fullName
        emailLbl.text = "Email: \(email!)"
        phoneNumberLbl.text = "Phone number: \(phoneNumber!)"
        checkInLbl.text = "Check in: \(checkInDate!)"
        checkOutLbl.text = "Check out: \(checkOutDate!)"
    }
    
}
