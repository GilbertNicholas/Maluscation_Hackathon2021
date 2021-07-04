//
//  HistoryViewController.swift
//  signInWithApple2
//
//  Created by Nico Christian on 04/07/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // Diganti jadi hasil fetch dari core data
//    let destinations: [DestinationPlace] = [
//        DestinationPlace(id: UUID(), name: "Vila 1", category: "Nature", location: "Bali", price: 1000000, upVote: 1200, downVote: 42, status: true, discount: 0.2, sanitationScore: 1, description: "description", additional: "additional", extras: ["netflix", "health kit", "dll"]),
//        DestinationPlace(id: UUID(), name: "Vila 2", category: "Chill", location: "Yogyakarta", price: 2000000, upVote: 1400, downVote: 102, status: false, discount: 0.5, sanitationScore: 2, description: "description", additional: "additional", extras: ["netflix", "health kit", "dll"]),
//        DestinationPlace(id: UUID(), name: "Vila 3", category: "Active", location: "Batam", price: 3500000, upVote: 100, downVote: 23, status: true, discount: 0.1, sanitationScore: 3, description: "description", additional: "additional", extras: ["netflix", "health kit", "dll"]),
//        DestinationPlace(id: UUID(), name: "Vila 4", category: "Casual", location: "Jakarta", price: 6000000, upVote: 1023, downVote: 43, status: false, discount: 0.15, sanitationScore: 5, description: "description", additional: "additional", extras: ["netflix", "health kit", "dll"]),
//    ]
    let destinations: [DestinationPlaceTest] = [DestinationPlaceTest(id: UUID(), name: "Villa A", category: "Active", location: "Jakarta, Indonesia", price: 10500000, upVote: 1203, downVote: 31, status: true, discount: 0.2, sanitationScore: 5)]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HistoryCell", bundle: .main), forCellReuseIdentifier: "HistoryCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "historyToDetail" {
            guard let detailVC = segue.destination as? DetailVC,
                  let senderIndex = sender as? Int
                  else { return }
            detailVC.id = destinations[senderIndex].id
            detailVC.destination = destinations[senderIndex]
        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return destinations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell
        else { return UITableViewCell() }
        
//        cell.setContentView(backgroundColor: colors[destinations[section].category] ?? UIColor.white)
        cell.setDestinationImage(image: (UIImage(named: "villa") ?? UIImage()))
//        cell.setDestinationName(name: destinations[section].name, backgroundColor: secondaryColors[destinations[section].category] ?? UIColor.white)
        cell.setLocationLabel(location: destinations[section].location)
        cell.setZoneLabel(isGreen: destinations[section].status)
        cell.setDateLabel(date: "01-01-2021 - 02-02-2021")
        cell.setPaymentMethod(method: "BCA Virtual Account")
        cell.setExtraLabel(extra: "Extra something")
        
//        cell.setPriceLabel(price: formatThousanSeparator(price: destinations[section].price, addIDR: true), backgroundColor: secondaryColors[destinations[section].category] ?? UIColor.white)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "historyToDetail", sender: indexPath.section)
    }
}
