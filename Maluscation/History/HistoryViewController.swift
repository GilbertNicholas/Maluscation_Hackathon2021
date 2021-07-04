//
//  HistoryViewController.swift
//  signInWithApple2
//
//  Created by Nico Christian on 04/07/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // Diganti jadi hasil fetch dari core data
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
    
    var destinations: [DestinationPlace] = []
    let dataManager = CoreDataManager()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HistoryCell", bundle: .main), forCellReuseIdentifier: "HistoryCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "historyToReceipt" {
            guard let receiptVC = segue.destination as? ReceiptViewController,
                  let senderIndex = sender as? Int
                  else { return }
            receiptVC.id = destinations[senderIndex].id
        }
    }
    
    private func fetchData() {
        destinations = dataManager.getPlaceBasedOnCategory(categoty: "Casual")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell,
              let image = UIImage(data: destinations[section].image!)
        else { return UITableViewCell() }
        
        cell.setContentView(backgroundColor: backgroundColors[destinations[section].category ?? ""] ?? UIColor.white)
        cell.setDestinationImage(image: image)
        cell.setDestinationName(name: destinations[section].name ?? "", backgroundColor: secondaryBackgroundColors[destinations[section].category ?? ""] ?? UIColor.white)
        cell.setLocationLabel(location: destinations[section].location ?? "")
        cell.setZoneLabel(isGreen: destinations[section].status)
        
        guard let checkIn = destinations[section].placeToBooking?.value(forKey: "checkIn") as? Date,
              let checkOut = destinations[section].placeToBooking?.value(forKey: "checkOut") as? Date,
              let paymentOpt = destinations[section].placeToBooking?.value(forKey: "paymentOpt") as? String,
              let facilitiy = destinations[section].facility?.first
        else { return UITableViewCell () }
        
        cell.setDateLabel(date: "\(checkIn) - \(checkOut)")
        cell.setPaymentMethod(method: paymentOpt)
        cell.setExtraLabel(extra: facilitiy)
        
//        cell.setPriceLabel(price: formatThousanSeparator(price: destinations[section].price, addIDR: true), backgroundColor: secondaryBackgroundColors[destinations[section].category] ?? UIColor.white)
        
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
