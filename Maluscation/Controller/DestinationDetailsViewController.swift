//
//  DestinationDetailsViewController.swift
//  signInWithApple2
//
//  Created by Nico Christian on 03/07/21.
//

import UIKit

let cornerRadiusRatio: CGFloat = 0.06

let red = #colorLiteral(red: 0.9647058824, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
let yellow = #colorLiteral(red: 1, green: 0.7803921569, blue: 0.3568627451, alpha: 1)
let green = #colorLiteral(red: 0.4705882353, green: 0.831372549, blue: 0.768627451, alpha: 1)
let blue = #colorLiteral(red: 0.5450980392, green: 0.6470588235, blue: 0.9529411765, alpha: 1)
let secondaryRed = #colorLiteral(red: 0.9803921569, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
let secondaryYellow = #colorLiteral(red: 1, green: 0.8666666667, blue: 0.6156862745, alpha: 1)
let secondaryGreen = #colorLiteral(red: 0.6823529412, green: 0.8980392157, blue: 0.862745098, alpha: 1)
let secondaryBlue = #colorLiteral(red: 0.7254901961, green: 0.7882352941, blue: 0.9725490196, alpha: 1)

struct DestinationPlaceTest {
    let id: UUID
    let name: String
    let category: String
    let location: String
    let price: Int
    let upVote: Int
    let downVote: Int
    let status: Bool
    let discount: Float
    let sanitationScore: Int
}

class DestinationDetailsViewController: UIViewController {
    
    // MARK: Properties
    let destination = DestinationPlaceTest(id: UUID(), name: "Villa A", category: "Casual", location: "Depok, Sleman", price: 4000000, upVote: 9090, downVote: 1023, status: true, discount: 0.5, sanitationScore: 4)
    let colors: [String: UIColor] = [
        "Active": red,
        "Casual": yellow,
        "Nature": green,
        "Chill": blue
    ]
    let secondaryColors: [String: UIColor] = [
        "Active": secondaryRed,
        "Casual": secondaryYellow,
        "Nature": secondaryGreen,
        "Chill": secondaryBlue
    ]

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
    
    // Toolbar
    @IBOutlet weak var toolbarContainer: UIView!
    @IBOutlet weak var fullPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(destination.name)"
        setupCardView()
        setupToolbarView()
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookingSegue" {
            // Passing data disini
            if let nextVC = segue.destination as? BookingFormViewController {
                nextVC.id = destination.id
            }
        }
    }
    
    // MARK: Setup view functions
    private func setupCardView() {
        // Container setup
        cardContainer.backgroundColor = colors[destination.category] // Ganti sesuai kategori
        cardContainer.layer.cornerRadius = cornerRadiusRatio * min(cardContainer.frame.width, cardContainer.frame.height)
        cardContainer.layer.borderWidth = 3
        cardContainer.layer.borderColor = UIColor.black.cgColor
        
        // Destination Image
        destinationImageView.layer.cornerRadius = cornerRadiusRatio * min(destinationImageView.frame.width, destinationImageView.frame.height)
    
        // Destination Labels
        destinationLabel.text = destination.name
        destinationLabel.backgroundColor = secondaryColors[destination.category] // Ganti sesuai kategori
        destinationLabel.layer.cornerRadius = cornerRadiusRatio * min(destinationLabel.frame.width, destinationLabel.frame.height) * 2
        
        // Location Labels
        locationLabel.text = destination.location
        
        // Zone Label
        zoneLabel.backgroundColor = destination.status ? green : red // Ganti sesuai kategori
        zoneLabel.text = destination.status ? "Green Zone" : "Red Zone"
        zoneLabel.textColor = UIColor.white
        zoneLabel.layer.cornerRadius = cornerRadiusRatio * min(zoneLabel.frame.width, zoneLabel.frame.height) * 4
        zoneLabel.layer.shadowColor = UIColor.black.cgColor
        zoneLabel.layer.shadowOpacity = 1
        zoneLabel.layer.shadowRadius = 10
        zoneLabel.layer.shadowOffset = .zero
        
        // Upvote, downvote, and sanitary score
        upVoteLabel.text = "\(destination.upVote)"
        downVoteLabel.text = "\(destination.downVote)"
        sanitationScoreLabel.text = "\(destination.sanitationScore)/5 | Sanitation Score"
    }
    private func setupToolbarView() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        // Container
        toolbarContainer.layer.cornerRadius = cornerRadiusRatio * toolbarContainer.frame.width
        toolbarContainer.layer.borderWidth = 3
        toolbarContainer.layer.borderColor = UIColor.black.cgColor
        
        // Full price labels
        guard let fullPrice = formatter.string(from: NSNumber(value: destination.price)),
              let discountedPrice = formatter.string(from: NSNumber(value: Float(destination.price) * destination.discount))
        else { return }
        
        let strikeThroughText = NSMutableAttributedString(string: fullPrice, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        let formattedFullPrice = NSMutableAttributedString(string: "IDR ")
        formattedFullPrice.append(strikeThroughText)
        fullPriceLabel.attributedText = formattedFullPrice
        
        // Discount labels
        discountLabel.text = "\(String(format: "%.0f", destination.discount * 100))% OFF"
        
        // Discounted Price Labels
        discountedPriceLabel.text = "IDR \(discountedPrice)"
        
        // Book button
        bookButton.clipsToBounds = true
        bookButton.layer.cornerRadius = bookButton.frame.height * 0.5
    }
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
