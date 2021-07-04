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
    @IBOutlet weak var nameLblContainer: UIView!
    @IBOutlet weak var statusLblContainer: UIView!
    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var facility1Lbl: UILabel!
    @IBOutlet weak var facility2Lbl: UILabel!
    @IBOutlet weak var facility3Lbl: UILabel!
    @IBOutlet weak var facility4Lbl: UILabel!
    
    @IBOutlet weak var upvoteLbl: UILabel!
    @IBOutlet weak var downvoteLbl: UILabel!
    @IBOutlet weak var hygieneLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet private weak var cardImage: UIImageView!
    @IBOutlet weak var cardSaveIcon: UIImageView!
    
    var chosenPref: String!
    var DataManager: CoreDataManager!
    var id: UUID!
    
    private var usedIdx: Int!
    private var divisor: CGFloat!
    private var placeDataBasedOnCategory: [DestinationPlace]!
    
    private let colors: [String: UIColor] = [
        "Active": red,
        "Casual": yellow,
        "Nature": green,
        "Chill": blue
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        divisor = (view.frame.width / 2) / 0.3
        usedIdx = 0
        
        if chosenPref == nil {
            chosenPref = "Active"
        }

        setupPrefButton()
        setupSwipeCard()
        initUsedData()
        checkPrefButton()
        setupCardContent()
    }
    
    private func checkPrefButton() {
        if self.chosenPref == "Active" {
            activeBtn.layer.borderWidth = 3
        } else if self.chosenPref == "Casual" {
            casualBtn.layer.borderWidth = 3
        } else if self.chosenPref == "Nature" {
            natureBtn.layer.borderWidth = 3
        } else if self.chosenPref == "Chill" {
            chillBtn.layer.borderWidth = 3
        }
    }
    
    private func initUsedData() {
        placeDataBasedOnCategory = DataManager.getPlaceBasedOnCategory(categoty: chosenPref)
//        placeNameLbl.text = placeDataBasedOnCategory[0].name
//        cardImage.image = UIImage(data: placeDataBasedOnCategory[0].image!)
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
        
        nameLblContainer.layer.cornerRadius = 8
        nameLblContainer.alpha = 0.8
        
        statusLblContainer.layer.cornerRadius = 8
        statusLblContainer.layer.shadowColor = UIColor.black.cgColor
        statusLblContainer.layer.shadowOpacity = 1
        statusLblContainer.layer.shadowOffset = .zero
        statusLblContainer.layer.shadowRadius = 2

        setupCardContent()
    }
    
    private func setupCardContent() {
        if placeDataBasedOnCategory != nil {
            id = placeDataBasedOnCategory[usedIdx].id
            cardImage.image = UIImage(data: placeDataBasedOnCategory[usedIdx].image!)
            placeNameLbl.text = placeDataBasedOnCategory[usedIdx].name
            locationLbl.text = placeDataBasedOnCategory[usedIdx].location
            
            if placeDataBasedOnCategory[usedIdx].status {
                statusLbl.text = "Red Zone"
                statusLblContainer.backgroundColor = red
            } else {
                statusLbl.text = "Green Zone"
                statusLblContainer.backgroundColor = green
            }
            
            facility1Lbl.text = placeDataBasedOnCategory[usedIdx].facility![0]
            facility2Lbl.text = placeDataBasedOnCategory[usedIdx].facility![1]
            facility3Lbl.text = placeDataBasedOnCategory[usedIdx].facility![2]
            facility4Lbl.text = placeDataBasedOnCategory[usedIdx].facility![3]
            
            upvoteLbl.text = String(placeDataBasedOnCategory[usedIdx].totalUpvote)
            downvoteLbl.text = String(placeDataBasedOnCategory[usedIdx].totalDownvote)
            hygieneLbl.text = "\(String(placeDataBasedOnCategory[usedIdx].totalHygiene))/5"
            priceLbl.text = "IDR \(String(placeDataBasedOnCategory[usedIdx].price))"
            
            cardContainer.backgroundColor = colors[chosenPref]
        }
    }
    
    @IBAction private func prefButtonTapped(_ sender: UIButton) {
        resetBorderButton()
        sender.layer.borderWidth = 3
        self.chosenPref = sender.currentTitle
        usedIdx = 0
        initUsedData()
        setupCardContent()
    }
    
    @IBAction private func prevButtonTapped(_ sender: UIButton) {
        usedIdx -= 1
        setupCardContent()
    }
    
    @IBAction func panCardTapped(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    @IBAction func panCardSwiped(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: 430 + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor)
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 30 {
//                Geser kiri
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: 430 + 75)
                    card.alpha = 0
                })
                
                usedIdx -= 1
                if usedIdx >= 0 {
                    setupCardContent()
                } else {
                    self.usedIdx = 0
                    setupCardContent()
                }

            } else if card.center.x > (view.frame.width - 30) {
//                Geser kanan
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: 430 + 75)
                    card.alpha = 0
                })
                
                usedIdx += 1
                if usedIdx < placeDataBasedOnCategory.count {
                    setupCardContent()
                } else {
                    self.usedIdx = 0
                    setupCardContent()
                }
            }
            resetCard()
        }
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.2, animations: {
            self.cardContainer.center = CGPoint(x: self.view.center.x, y: 430)
//            self.lblOption.alpha = 0
            self.cardContainer.alpha = 1
            self.cardContainer.transform = .identity
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let navController = segue.destination as? UINavigationController,
                  let destVC = navController.viewControllers.first as? DetailVC
            else { return }
            
            destVC.id = self.id
        }
    }
    
}
