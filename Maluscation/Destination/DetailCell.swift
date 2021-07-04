//
//  DetailCell.swift
//  signInWithApple2
//
//  Created by Nico Christian on 04/07/21.
//

import UIKit

class DetailCell: UITableViewCell {
    
    // MARK: Outlets
    // Card View outlets
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var zoneLabel: UILabel!
    
    // Upvote, downvote, and sanitation score
    @IBOutlet weak var upVoteLabel: UILabel!
    @IBOutlet weak var downVoteLabel: UILabel!
    @IBOutlet weak var sanitationScoreLabel: UILabel!
    
    // Description Outlets
    @IBOutlet weak var descriptionLabel: PaddingLabel!
    @IBOutlet weak var additionalDescriptionLabel: PaddingLabel!
    @IBOutlet var extraLabels: [UILabel]!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupViews() {

        cardContainer.layer.cornerRadius = cornerRadiusRatio * min(cardContainer.frame.width, cardContainer.frame.height)
        cardContainer.layer.borderWidth = 3
        cardContainer.layer.borderColor = UIColor.black.cgColor
        
        // Destination Image
        destinationImageView.layer.cornerRadius = cornerRadiusRatio * min(destinationImageView.frame.width, destinationImageView.frame.height)
    
        // Destination Labels
        destinationLabel.layer.cornerRadius = cornerRadiusRatio * min(destinationLabel.frame.width, destinationLabel.frame.height) * 2
        
        // Zone Label
        zoneLabel.textColor = UIColor.white
        zoneLabel.layer.cornerRadius = cornerRadiusRatio * min(zoneLabel.frame.width, zoneLabel.frame.height) * 4
        zoneLabel.layer.shadowColor = UIColor.black.cgColor
        zoneLabel.layer.shadowOpacity = 1
        zoneLabel.layer.shadowRadius = 10
        zoneLabel.layer.shadowOffset = .zero
        
        // Description
        descriptionLabel.setCornerRadius(ratio: cornerRadiusRatio * 2)
        additionalDescriptionLabel.setCornerRadius(ratio: cornerRadiusRatio * 3)
    }
    
    func setContainerView(color: UIColor) {
        cardContainer.backgroundColor = color
    }
    
    func setNameLabel(name: String) {
        destinationLabel.text = name
    }
    
    func setLocationLabel(location: String) {
        locationLabel.text = location
    }
    
    func setZoneLabel(isGreen: Bool) {
        zoneLabel.backgroundColor = isGreen ? secondaryGreen : secondaryRed
        zoneLabel.text = isGreen ? "Green Zone" : "Red Zone"
    }
    
    func setUpVote(upvote: Int) {
        upVoteLabel.text = "\(upvote)"
    }
    
    func setDownVote(downvote: Int) {
        downVoteLabel.text = "\(downvote)"
    }
    
    func setSanitatyLabel(score: Int) {
        sanitationScoreLabel.text = "\(score)/5 | Sanitary Score"
    }
    
    func setDescriptionLabel(description: String) {
        descriptionLabel.text = description
    }
    
    func setAdditionalDescriptionLabel(description: String) {
        additionalDescriptionLabel.text = description
    }
    
    func setExtraLabels(numberOfExtras: Int, extras: [String]) {
        if numberOfExtras > 6 { return }
        else {
            var i = 0
            for extra in extras {
                extraLabels[i].isHidden = false
                extraLabels[i].text = "• \(extra)"
                i += 1
            }
        }
    }
}
