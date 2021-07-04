//
//  PaymentStatusViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 04/07/21.
//

import UIKit

class PaymentStatusViewController: UIViewController {
    
    @IBOutlet weak var seeHistoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seeHistoryButton.layer.cornerRadius = 15
        seeHistoryButton.layer.shadowOpacity = 0.5
        seeHistoryButton.layer.shadowRadius = 6
        seeHistoryButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        seeHistoryButton.layer.borderWidth = 2
        seeHistoryButton.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
    }
    
    @IBAction func seeHistoryButtonTapped(_ sender: Any) {
        
    }
    
}
