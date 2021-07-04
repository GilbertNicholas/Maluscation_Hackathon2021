//
//  ReviewViewController.swift
//  Maluscation
//
//  Created by Stefan Adisurya on 04/07/21.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var downvoteButton: UIButton!
    @IBOutlet weak var sanitationScoreImage: UIImageView!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var feedbackTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var upvote: Int?
    var downvote: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upvote = 0
        downvote = 0
        
        setUpView()
    }
    
    func setUpView() {
        upvoteButton.layer.cornerRadius = 15
        upvoteButton.layer.shadowOpacity = 0.5
        upvoteButton.layer.shadowRadius = 6
        upvoteButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        upvoteButton.layer.borderWidth = 2
        upvoteButton.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        downvoteButton.layer.cornerRadius = 15
        downvoteButton.layer.shadowOpacity = 0.5
        downvoteButton.layer.shadowRadius = 6
        downvoteButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        downvoteButton.layer.borderWidth = 2
        downvoteButton.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        submitButton.layer.cornerRadius = 15
        submitButton.layer.shadowOpacity = 0.5
        submitButton.layer.shadowRadius = 6
        submitButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        
        feedbackView.layer.borderWidth = 4
        feedbackView.layer.borderColor = CGColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func upvoteButtonTapped(_ sender: Any) {
        upvoteButton.backgroundColor = UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        upvoteButton.setTitleColor(.white, for: .normal)
        upvoteButton.tintColor = .white
        
        downvoteButton.backgroundColor = .white
        downvoteButton.setTitleColor(UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1), for: .normal)
        downvoteButton.tintColor = UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        if upvote == 0 {
            upvote! += 1
        } else {
            upvote! += 0
        }
    }
    
    @IBAction func downvoteButtonTapped(_ sender: Any) {
        upvoteButton.backgroundColor = .white
        upvoteButton.setTitleColor(UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1), for: .normal)
        upvoteButton.tintColor = UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        
        downvoteButton.backgroundColor = UIColor(red: 9/255, green: 28/255, blue: 87/255, alpha: 1)
        downvoteButton.setTitleColor(.white, for: .normal)
        downvoteButton.tintColor = .white
        
        if upvote == 0 {
            upvote! += 1
        } else {
            upvote! += 0
        }
    }
    
    func saveFeedback() {
        
    }
    
}
