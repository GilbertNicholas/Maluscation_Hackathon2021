//
//  ProfileViewController.swift
//  Maluscation
//
//  Created by Nico Christian on 03/07/21.
//

import UIKit
import AuthenticationServices

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameContainer: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: PaddingLabel!
    
    @IBOutlet weak var emailContainer: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneContainer: UIView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    private let signInButton = ASAuthorizationAppleIDButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        signInCheck()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 0, y: 0, width: view.frame.width - 24, height: 40)
        signInButton.center = signOutButton.center
    }

    @objc func didTapSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @objc func didTapSignOut() {
        UserDefaults.standard.setValue(false, forKey: "isSignedIn")
        signInCheck()
    }
    
    func signInCheck() {
        guard let isSignedIn = UserDefaults.standard.value(forKey: "isSignedIn") as? Bool else { return }
        if isSignedIn {
            
            guard let firstName = UserDefaults.standard.value(forKey: "firstName") as? String,
                  let lastName = UserDefaults.standard.value(forKey: "lastName") as? String,
                  let email = UserDefaults.standard.value(forKey: "email") as? String
            else { return }
            
            signOutButton.isHidden = false
            signInButton.isHidden = true
            emailContainer.isHidden = false
            phoneContainer.isHidden = false
            
            nameLabel.text = "\(firstName) \(lastName)"
            emailLabel.text = "\(email)"
        } else {
            signOutButton.isHidden = true
            signInButton.isHidden = false
            emailContainer.isHidden = true
            phoneContainer.isHidden = true
            nameLabel.text = "Sign In"
        }
    }
    
    private func setupViews() {
        profileImage.setCornerRadius(ratio: cornerRadiusRatio * 3)
        
        nameContainer.setBorderWidth(point: 3)
        nameContainer.setBorderColor(color: UIColor.black)
        nameContainer.setCornerRadius(ratio: cornerRadiusRatio * 3)
        nameLabel.setCornerRadius(ratio: cornerRadiusRatio * 3)
        
        emailContainer.setBorderWidth(point: 3)
        emailContainer.setBorderColor(color: UIColor.black)
        emailContainer.setCornerRadius(ratio: cornerRadiusRatio * 3)
        
        phoneContainer.setBorderWidth(point: 3)
        phoneContainer.setBorderColor(color: UIColor.black)
        phoneContainer.setCornerRadius(ratio: cornerRadiusRatio * 3)
        
        signOutButton.setCornerRadius(ratio: cornerRadiusRatio * 3)
    }
}
    
extension UIView {
    func setBorderWidth(point: CGFloat) {
        layer.borderWidth = point
    }
    
    func setBorderColor(color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    func setCornerRadius(ratio: CGFloat) {
        layer.cornerRadius = ratio * min(frame.width, frame.height)
    }
}

extension ProfileViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            UserDefaults.standard.setValue(true, forKey: "isSignedIn")
            
            
            guard let firstName = credentials.fullName?.givenName,
                  let lastName = credentials.fullName?.familyName,
                  let email = credentials.email
            else {
                signInCheck()
                return
            }
            
            UserDefaults.standard.setValue(firstName, forKey: "firstName")
            UserDefaults.standard.setValue(lastName, forKey: "lastName")
            UserDefaults.standard.setValue(email, forKey: "email")

            signInCheck()
            break
        default:
            break
        }
    }
}

extension ProfileViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

