//
//  ProfileViewController.swift
//  Maluscation
//
//  Created by Nico Christian on 03/07/21.
//

import UIKit
import AuthenticationServices

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var signOutButton: UIButton!
    
    private let signInButton = ASAuthorizationAppleIDButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        signInCheck()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
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
            signOutButton.isHidden = false
            signInButton.isHidden = true
        } else {
            signOutButton.isHidden = true
            signInButton.isHidden = false
        }
        guard let firstName = UserDefaults.standard.value(forKey: "firstName") as? String,
              let lastName = UserDefaults.standard.value(forKey: "lastName") as? String
        else { return }
        
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
            signInCheck()
            guard let firstName = credentials.fullName?.givenName,
                  let lastName = credentials.fullName?.familyName,
                  let email = credentials.email
            else { return }
            UserDefaults.standard.register(defaults: ["firstName": "\(firstName)", "lastName": "\(lastName)", "email": email])
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

