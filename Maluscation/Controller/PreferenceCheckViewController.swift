//
//  PreferenceCheckViewController.swift
//  Maluscation
//
//  Created by Gilbert Nicholas on 03/07/21.
//

import UIKit

class PreferenceCheckViewController: UIViewController {

    @IBOutlet weak var casualBtn: UIButton!
    @IBOutlet weak var activeBtn: UIButton!
    @IBOutlet weak var natureBtn: UIButton!
    @IBOutlet weak var chillBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    private var selectedPref: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
    }
    
    private func setupButton() {
        casualBtn.layer.cornerRadius = 22
        activeBtn.layer.cornerRadius = 22
        natureBtn.layer.cornerRadius = 22
        chillBtn.layer.cornerRadius = 22
        
        borderButton()
    }
    
    private func borderButton() {
        casualBtn.layer.borderWidth = 0
        activeBtn.layer.borderWidth = 0
        natureBtn.layer.borderWidth = 0
        chillBtn.layer.borderWidth = 0
    }
    
    @IBAction private func prefButtonTapped(_ sender: UIButton) {
        
        borderButton()
        sender.layer.borderWidth = 5
        selectedPref = sender.currentTitle!
        
        if selectedPref != nil {
            nextBtn.isHidden = false
        }
    }
    
    @IBAction private func nextButtonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "swipeSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "swipeSegue") {
            let destVC = segue.destination as! UITabBarController
            
            if let presentVC = destVC.viewControllers?[0] as? SwipePageViewController {
                presentVC.chosenPref = self.selectedPref
            }
        }
    }
}
