//
//  SavedViewController.swift
//  signInWithApple2
//
//  Created by Nico Christian on 05/07/21.
//

import UIKit

class SavedViewController: UIViewController {
    
    private let colors: [String: UIColor] = [
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

    let dataManager = CoreDataManager()
    let category = ["Active", "Casual", "Nature", "Chill"]
    var selectedCategory = 0
    var destinations: [DestinationPlace] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var buttonContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.register(UINib(nibName: "SavedCell", bundle: .main), forCellReuseIdentifier: "SavedCell")
        tableView.dataSource = self
        setupButtons()
        // Do any additional setup after loading the view.
    }
    
    private func setupButtons() {
        buttonContainer.layer.cornerRadius = 30
        buttons[selectedCategory].layer.borderWidth = 3
        for button in buttons {
            button.layer.cornerRadius = 17
        }
    }
    
    private func resetButton() {
        for button in buttons {
            button.layer.borderWidth = 0
        }
    }
    
    private func fetchData() {
        destinations = dataManager.getAllSaved()
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        resetButton()
        buttons[sender.tag].layer.borderWidth = 3
        selectedCategory = sender.tag
    }
    
    private func formatThousandSeparator(price: Int, addIDR: Bool) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        guard let fullPrice = formatter.string(from: NSNumber(value: price))
        else { return "" }
        
        return addIDR ? "IDR \(fullPrice)" : "\(fullPrice)"
    }
}

extension SavedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return destinations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        let destination = destinations[section]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell") as? SavedCell,
              let image = UIImage(data: destination.image!)
        else { return UITableViewCell() }
        
        cell.setContentView(backgroundColor: colors[destination.category ?? ""] ?? UIColor.white)
        cell.setDestinationImage(image: image)
        cell.setDestinationName(name: destination.name ?? "", backgroundColor: secondaryColors[destination.category ?? ""] ?? UIColor.white)
        cell.setLocationLabel(location: destination.location ?? "")
        cell.setZoneLabel(isGreen: destination.status)
        cell.setPriceLabel(price: formatThousandSeparator(price: Int(destination.price), addIDR: true), backgroundColor: secondaryColors[destination.category ?? ""] ?? UIColor.white)
        cell.setExtraLabel(extras: destination.facility ?? [""])
        cell.setUpVote(upvote: Int(destination.totalUpvote))
        cell.setDownVote(downvote: Int(destination.totalDownvote))
        cell.setSanitatyLabel(score: Int(destination.totalHygiene))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 258
    }
}
