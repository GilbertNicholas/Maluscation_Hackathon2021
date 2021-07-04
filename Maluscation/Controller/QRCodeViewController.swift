//
//  QRCodeViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 04/07/21.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var qrCodeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qrCodeView.layer.cornerRadius = 28
        qrCodeView.layer.shadowOpacity = 0.5
        qrCodeView.layer.shadowRadius = 6
        qrCodeView.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
