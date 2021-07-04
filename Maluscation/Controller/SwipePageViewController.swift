//
//  SwipePageViewController.swift
//  Maluscation
//
//  Created by Gilbert Nicholas on 03/07/21.
//

import UIKit

class SwipePageViewController: UIViewController {
    
    @IBOutlet private weak var buttonContainer: UIView!
    @IBOutlet private weak var cardContainer: UIView!
    
    @IBOutlet private weak var activeBtn: UIButton!
    @IBOutlet private weak var casualBtn: UIButton!
    @IBOutlet private weak var natureBtn: UIButton!
    @IBOutlet private weak var chillBtn: UIButton!
    @IBOutlet private weak var prevBtn: UIButton!
    
    @IBOutlet private weak var cardImage: UIImageView!
    var chosenPref: String!
    
    private var divisor: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        divisor = (view.frame.width / 2) / 0.3

        setupPrefButton()
        setupSwipeCard()
    }
    
    private func setupPrefButton() {
        buttonContainer.layer.cornerRadius = 30
        activeBtn.layer.cornerRadius = 17
        casualBtn.layer.cornerRadius = 17
        natureBtn.layer.cornerRadius = 17
        chillBtn.layer.cornerRadius = 17
        
        resetBorderButton()
    }
    
    private func resetBorderButton() {
        casualBtn.layer.borderWidth = 0
        activeBtn.layer.borderWidth = 0
        natureBtn.layer.borderWidth = 0
        chillBtn.layer.borderWidth = 0
    }
    
    private func setupSwipeCard() {
        cardContainer.layer.shadowColor = UIColor.black.cgColor
        cardContainer.layer.shadowOpacity = 1
        cardContainer.layer.shadowOffset = .zero
        cardContainer.layer.shadowRadius = 5
        cardContainer.layer.cornerRadius = 22
        cardImage.layer.cornerRadius = 22
    }
    
    @IBAction private func prefButtonTapped(_ sender: UIButton) {
        resetBorderButton()
        sender.layer.borderWidth = 3
        self.chosenPref = sender.currentTitle
    }
    
    @IBAction private func prevButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func panCardSwiped(_ sender: UIPanGestureRecognizer) {
        let card = sender.view
        
    }
    
}
