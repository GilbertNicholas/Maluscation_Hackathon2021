//
//  DetailVC.swift
//  signInWithApple2
//
//  Created by Nico Christian on 04/07/21.
//

import UIKit

class DetailVC: UIViewController {
    
    private let backgroundColors: [String: UIColor] = [
        "Active": red,
        "Casual": yellow,
        "Nature": green,
        "Chill": blue
    ]
    
    private let secondaryBackgroundColors: [String: UIColor] = [
        "Active": secondaryRed,
        "Casual": secondaryYellow,
        "Nature": secondaryGreen,
        "Chill": secondaryBlue
    ]
    
    var id: UUID!
    private var dataManager = CoreDataManager()
//    var destination = DestinationPlacete(id: UUID(), name: "Villa A", category: "Casual", location: "Depok, Sleman", price: 4000000, upVote: 9090, downVote: 1023, status: true, discount: 0.5, sanitationScore: 4, description: "description description description description description description description description description description description ", additional: "additional description description description description", extras: ["netflix", "health kit", "dll"])
    var destination: DestinationPlaceTest?
    var destinations: [DestinationPlace] = []

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
        fetchData()
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
        guard let destination = destinations.first,
              let fullPrice = formatter.string(from: NSNumber(value: destination.price)),
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

    private func fetchData() {
        guard let dataID = id else { return }
        destinations = dataManager.getPlaceBasedOnId(id: dataID)
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBooking" {
            // Passing data booking
            guard let bookingVC = segue.destination as? BookingFormViewController else { return }
            bookingVC.id = id
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell,
              let destination = destinations.first,
              let image = UIImage(data: destination.image!)
        else { return UITableViewCell() }
        
        cell.setContainerView(color: backgroundColors[destination.category ?? ""] ?? UIColor.white)
        cell.destinationImageView.image = image
        cell.setNameLabel(name: destination.name ?? "")
        cell.destinationLabel.backgroundColor = secondaryBackgroundColors[destination.category ?? ""] ?? UIColor.white
        cell.setLocationLabel(location: destination.location ?? "")
        cell.setZoneLabel(isGreen: destination.status)
        cell.setUpVote(upvote: Int(destination.totalUpvote))
        cell.setDownVote(downvote: Int(destination.totalDownvote))
        cell.setSanitatyLabel(score: Int(destination.totalHygiene))
        cell.setDescriptionLabel(description: "")
        cell.setAdditionalDescriptionLabel(description: "")
        cell.descriptionLabel.isHidden = true
        cell.additionalDescriptionLabel.isHidden = true
        cell.setExtraLabels(numberOfExtras: destination.facility?.count ?? 7, extras: destination.facility ?? [""])
        
        return cell
    }
}

