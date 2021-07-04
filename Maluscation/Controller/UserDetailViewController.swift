//
//  UserDetailViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 04/07/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTapGesture()
        
        fullNameTextField.text = "Gilbert Nicholas"
        emailTextField.text = "gilbert@gmail.com"
        phoneNumberTextField.text = "087887654123"
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
    
    func setUpTapGesture() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if fullNameTextField.text != "" && emailTextField.text != "" && phoneNumberTextField.text != "" {
            if fullNameTextField.text!.count >= 3 && validateEmail(enteredEmail: emailTextField.text!) && phoneNumberTextField.text!.count >= 10 {
                guard let bookingVC = segue.destination as? BookingFormViewController else { return }
                
                bookingVC.fullName = "\(fullNameTextField.text!)"
                bookingVC.email = "\(emailTextField.text!)"
                bookingVC.phoneNumber = "\(phoneNumberTextField.text!)"
                
                self.dismiss(animated: true)
            } else {
                popUpAlert()
            }
        } else {
            popUpAlert()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension UserDetailViewController: UITextFieldDelegate {
    
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
