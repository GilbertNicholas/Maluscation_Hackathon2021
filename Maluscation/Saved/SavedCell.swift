//
//  SavedCell.swift
//  signInWithApple2
//
//  Created by Nico Christian on 05/07/21.
//

import UIKit

class SavedCell: UITableViewCell {
    
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var destinationNameLabel: PaddingLabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var zoneLabel: UILabel!
    @IBOutlet var extraLabels: [UILabel]!
    @IBOutlet weak var upvoteLabel: UILabel!
    @IBOutlet weak var downvoteLabel: UILabel!
    @IBOutlet weak var sanitaryScoreLabel: UILabel!
    @IBOutlet weak var priceLabel: PaddingLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    private func setupView() {
        contentView.setBorderWidth(point: 3)
        contentView.setBorderColor(color: #colorLiteral(red: 0.02745098039, green: 0.0862745098, blue: 0.2745098039, alpha: 1))
        contentView.setCornerRadius(ratio: cornerRadiusRatio * 1.5)
        destinationImageView.setCornerRadius(ratio: cornerRadiusRatio * 3)
        destinationNameLabel.setCornerRadius(ratio: cornerRadiusRatio * 3)
        locationImageView.setCornerRadius(ratio: cornerRadiusRatio * 3)
        zoneLabel.setCornerRadius(ratio: cornerRadiusRatio * 6)
        priceLabel.setCornerRadius(ratio: cornerRadiusRatio * 4)
    }
    
    func setContentView(backgroundColor: UIColor) {
        contentView.backgroundColor = backgroundColor
    }
    
    func setDestinationImage(image: UIImage) {
        destinationImageView.image = image
    }
    
    func setDestinationName(name: String, backgroundColor: UIColor) {
        destinationNameLabel.text = name
        destinationNameLabel.backgroundColor = backgroundColor
    }
    
    func setLocationLabel(location: String) {
        locationLabel.text = location
    }
    
    func setZoneLabel(isGreen: Bool) {
        zoneLabel.backgroundColor = isGreen ? secondaryGreen: secondaryRed
        zoneLabel.text = isGreen ? "Green Zone" : "Red Zone"
    }
    
    func setExtraLabel(extras: [String]) {
        var i = 0
        for extra in extras {
            if i > 4 { return }
            extraLabels[i].isHidden = false
            extraLabels[i].text = "• \(extra)"
            i += 1
        }
    }
    
    func setPriceLabel(price: String, backgroundColor: UIColor) {
        priceLabel.text = price
        priceLabel.backgroundColor = backgroundColor
    }
    
    func setUpVote(upvote: Int) {
        upvoteLabel.text = "\(upvote)"
    }
    
    func setDownVote(downvote: Int) {
        downvoteLabel.text = "\(downvote)"
    }
    
    func setSanitatyLabel(score: Int) {
        sanitaryScoreLabel.text = "\(score)/5"
    }
}
