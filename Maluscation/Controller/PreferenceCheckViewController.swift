//
//  PreferenceCheckViewController.swift
//  Maluscation
//
//  Created by Gilbert Nicholas on 03/07/21.
//

import UIKit

class PreferenceCheckViewController: UIViewController {

    @IBOutlet private weak var casualBtn: UIButton!
    @IBOutlet private weak var activeBtn: UIButton!
    @IBOutlet private weak var natureBtn: UIButton!
    @IBOutlet private weak var chillBtn: UIButton!
    
    @IBOutlet private weak var nextBtn: UIButton!
    
    private var selectedPref: String!
    private var DataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        initData()

        setupButton()
    }
    
    private func initData() {
        DataManager.insertPlace(name: "Vila Batik", price: 400000, discount: 0.2, category: "Active", location: "Batam", status: false, facility: ["Netflix", "Breakfast", "Covid Protocol", "Dinner"], image: UIImage(imageLiteralResourceName: "vilaBatik").pngData()!, totalUp: 1140, totalDown: 242, totalHygiene: 4)
        
        DataManager.insertPlace(name: "Vila Senayan", price: 700000, discount: 0, category: "Chill", location: "Yogyakarta", status: false, facility: ["Near Mall", "Full Meal", "Covid Protocol", "Free Ride"], image: UIImage(imageLiteralResourceName: "vilaSenayan").pngData()!, totalUp: 1272, totalDown: 10, totalHygiene: 5)
        
        DataManager.insertPlace(name: "Vila Malus", price: 250000, discount: 0.4, category: "Nature", location: "Bandung", status: false, facility: ["Fresh", "Breakfast", "Dinner ", "Near Beach"], image: UIImage(imageLiteralResourceName: "vilaMalus").pngData()!, totalUp: 1678, totalDown: 647, totalHygiene: 3)
        
        DataManager.insertPlace(name: "Vila Danur", price: 800000, discount: 0.5, category: "Casual", location: "Batam", status: false, facility: ["Full Meal", "Covid Protocol", "Free Ride", "Dinner"], image: UIImage(imageLiteralResourceName: "vilaDanur").pngData()!, totalUp: 457, totalDown: 21, totalHygiene: 4)
        
        DataManager.insertPlace(name: "Vila Kurinci", price: 150000, discount: 0, category: "Active", location: "Bandung", status: true, facility: ["Full Meal", "Covid Protocol", "Free Ride", "Dinner"], image: UIImage(imageLiteralResourceName: "vilaKurinci").pngData()!, totalUp: 2892, totalDown: 845, totalHygiene: 4)
        
        DataManager.insertPlace(name: "Vila Melawai", price: 600000, discount: 0.5, category: "Active", location: "Yogyakarta", status: true, facility: ["Full Meal", "Covid Protocol", "Free Ride", "Dinner"], image: UIImage(imageLiteralResourceName: "vilaMelawai").pngData()!, totalUp: 769, totalDown: 590, totalHygiene: 3)
        
        DataManager.insertUser(name: "Adi", email: "adi@icloud.com")
        DataManager.insertUser(name: "Sarah", email: "sarah@icloud.com")
        
        
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
                presentVC.DataManager = self.DataManager
            }
        }
    }
}
