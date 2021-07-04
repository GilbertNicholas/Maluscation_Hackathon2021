//
//  DetailVC.swift
//  signInWithApple2
//
//  Created by Nico Christian on 04/07/21.
//

import UIKit

class DetailVC: UIViewController {
    
    var id: UUID? = nil
    
//    var destination = DestinationPlacete(id: UUID(), name: "Villa A", category: "Casual", location: "Depok, Sleman", price: 4000000, upVote: 9090, downVote: 1023, status: true, discount: 0.5, sanitationScore: 4, description: "description description description description description description description description description description description ", additional: "additional description description description description", extras: ["netflix", "health kit", "dll"])
    var destination = DestinationPlaceTest(id: UUID(), name: "Villa", category: "Casual", location: "Batam", price: 10000000, upVote: 231, downVote: 30, status: true, discount: 0.4, sanitationScore: 5)

    @IBOutlet weak var tableView: UITableView!
    
    // Toolbar
    @IBOutlet weak var toolbarContainer: UIView!
    @IBOutlet weak var fullPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        setupToolbarView()
        tableView.register(UINib(nibName: "DetailCell", bundle: .main), forCellReuseIdentifier: "DetailCell")
        tableView.dataSource = self
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
              let discountedPrice = formatter.string(from: NSNumber(value: Float(destination.price) * (1 - destination.discount)))
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBooking" {
            // Passing data booking
        }
    }
    
}

extension DetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell
        else { return UITableViewCell() }
        
//        cell.setContainerView(color: colors[destination.category] ?? UIColor.white)
        cell.setNameLabel(name: destination.name)
        cell.setLocationLabel(location: destination.location)
        cell.setZoneLabel(isGreen: destination.status)
        cell.setUpVote(upvote: destination.upVote)
        cell.setDownVote(downvote: destination.downVote)
        cell.setSanitatyLabel(score: destination.sanitationScore)
//        cell.setDescriptionLabel(description: destination.description)
//        cell.setAdditionalDescriptionLabel(description: destination.additional)
//        cell.setExtraLabels(numberOfExtras: destination.extras.count, extras: destination.extras)
        
        return cell
    }
}
