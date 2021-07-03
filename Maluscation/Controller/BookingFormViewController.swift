//
//  BookingFormViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 03/07/21.
//

import UIKit
import CoreData

class BookingFormViewController: UIViewController {
    
    @IBOutlet weak var checkInTextField: UITextField!
    @IBOutlet weak var checkOutTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var paymentButton: UIButton!
    
    let date = Calendar.current.date(byAdding: .day, value: 1, to: Date())
    let formatter = DateFormatter()
    let datePicker = UIDatePicker()
    let datePicker2 = UIDatePicker()
    
    let toolbar = UIToolbar()
    
    var books = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentButton.layer.cornerRadius = 20
        
        setUpDate()
        setUpDate2()
        setUpCheckInTextField()
        setUpCheckOutTextField()
        
        setUpDoneButton()
        
        checkInTextField.inputAccessoryView = toolbar
        checkOutTextField.inputAccessoryView = toolbar
        
        setUpTapGesture()
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
    
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func popUpAlert() {
        let alert = UIAlertController(title: "Please fill the form correctly", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if checkInTextField.text != "" && checkOutTextField.text != "" && fullNameTextField.text != "" && emailTextField.text != "" && phoneNumberTextField.text != "" {
            if fullNameTextField.text!.count >= 3 && validateEmail(enteredEmail: emailTextField.text!) && phoneNumberTextField.text!.count >= 10 {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }

                let managedContext = appDelegate.persistentContainer.viewContext

                let entity = NSEntityDescription.entity(forEntityName: "Booking", in: managedContext)!

                let bookingDetails = NSManagedObject(entity: entity, insertInto: managedContext)
                bookingDetails.setValue(fullNameTextField.text, forKey: "name")
                bookingDetails.setValue(emailTextField.text, forKey: "email")
                bookingDetails.setValue(phoneNumberTextField.text, forKey: "phone")
                bookingDetails.setValue(formatter.date(from: checkInTextField.text!), forKey: "checkIn")
                bookingDetails.setValue(formatter.date(from: checkOutTextField.text!), forKey: "checkOut")

                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            } else {
               popUpAlert()
            }
        } else {
            popUpAlert()
        }
    }
    
}

extension BookingFormViewController {
    
    func setUpTapGesture() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func setUpDoneButton() {
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed(_:)))
        toolbar.setItems([doneBtn], animated: true)
        toolbar.sizeToFit()
    }
    
    func setUpDate() {
        formatter.dateFormat = "dd/MM/yyyy"
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePicker.addTarget(self, action: #selector(checkInValueChanged(sender:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
    }
    
    func setUpDate2() {
        formatter.dateFormat = "dd/MM/yyyy"

        datePicker2.datePickerMode = .dateAndTime
        datePicker2.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePicker2.addTarget(self, action: #selector(checkOutValueChanged(sender:)), for: .valueChanged)
        datePicker2.frame.size = CGSize(width: 0, height: 250)
    }
    
    func setUpCheckInTextField() {
        checkInTextField.textColor = .black
        checkInTextField.inputView = datePicker
    }
    
    func setUpCheckOutTextField() {
        checkOutTextField.textColor = .black
        checkOutTextField.inputView = datePicker2
    }
    
    @objc func checkInValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        checkInTextField.text = formatter.string(from: sender.date)
    }
    
    @objc func checkOutValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        checkOutTextField.text = formatter.string(from: sender.date)
    }
    
}

extension BookingFormViewController {
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    @objc func donePressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
}

extension BookingFormViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
    
}
