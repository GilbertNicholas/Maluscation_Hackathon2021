//
//  PaymentOptViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 04/07/21.
//

import UIKit

class PaymentOptViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var paymentOptPicker: UIPickerView!
    
    var chosenOpt: String?
    var pickerData: [String] = ["BCA Virtual Account", "BNI Virtual Account", "OVO", "Dana", "Go-Pay"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenOpt = pickerData[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenOpt = "\(pickerData[row])"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookingVC = segue.destination as? BookingFormViewController else { return }
        
        bookingVC.paymentOpt = "\(chosenOpt!)"
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
