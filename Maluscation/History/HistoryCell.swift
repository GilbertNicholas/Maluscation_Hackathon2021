//
//  HistoryCell.swift
//  signInWithApple2
//
//  Created by Nico Christian on 04/07/21.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet var paidMarker: [UIView]!
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var destinationNameLabel: PaddingLabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var zoneLabel: UILabel!
    @IBOutlet weak var dateImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var priceLabel: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupViews() {
        for marker in paidMarker {
            marker.setCornerRadius(ratio: 0.5)
        }
        contentView.setBorderWidth(point: 3)
        contentView.setBorderColor(color: #colorLiteral(red: 0.02745098039, green: 0.0862745098, blue: 0.2745098039, alpha: 1))
        contentView.setCornerRadius(ratio: cornerRadiusRatio * 1.5)
        destinationImageView.setCornerRadius(ratio: cornerRadiusRatio * 3)
        destinationNameLabel.setCornerRadius(ratio: cornerRadiusRatio * 3)
        locationImageView.setCornerRadius(ratio: cornerRadiusRatio * 3)
        dateImageView.setCornerRadius(ratio: cornerRadiusRatio * 3)
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
    
    func setDateLabel(date: String) {
        dateLabel.text = date
    }
    
    func setPaymentMethod(method: String) {
        paymentMethodLabel.text = "• \(method)"
    }
    
    func setExtraLabel(extra: String) {
        extraLabel.text = "• \(extra)"
    }
    
    func setPriceLabel(price: String, backgroundColor: UIColor) {
        priceLabel.text = price
        priceLabel.backgroundColor = backgroundColor
    }
}
