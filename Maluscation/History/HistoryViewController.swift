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
    var bookings: [Booking] = []
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
                  let senderIndex = sender as? Int,
                  let bookingId = bookings[senderIndex].bookingId
//                  let bookingId = destinations[senderIndex].placeToBooking?.value(forKey: "bookingId") as? UUID
                  else { return }
            receiptVC.bookingId = bookingId
        }
    }
    
    private func fetchData() {
        bookings = dataManager.getAllBookings()
        for booking in bookings {
            guard let place = booking.bookingToPlace else { return }
            destinations.append(place)
        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let booking = bookings[section]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell,
              let bookedPlace = booking.bookingToPlace,
              let image = UIImage(data: bookedPlace.image!)
        else { return UITableViewCell() }
        
        
        cell.setContentView(backgroundColor: backgroundColors[bookedPlace.category ?? ""] ?? UIColor.white)
        cell.setDestinationImage(image: image)
        cell.setDestinationName(name: bookedPlace.name ?? "", backgroundColor: secondaryBackgroundColors[bookedPlace.category ?? ""] ?? UIColor.white)
        cell.setLocationLabel(location: bookedPlace.location ?? "")
        cell.setZoneLabel(isGreen: bookedPlace.status)
        
        guard let facilitiy = bookedPlace.facility?.first,
              let checkIn = booking.checkIn,
              let checkOut = booking.checkOut,
              let paymentOpt = booking.paymentOpt
        else { return UITableViewCell () }
        
        cell.setDateLabel(date: dateFormatter(from: checkIn, to: checkOut))
        cell.setPaymentMethod(method: paymentOpt)
        cell.setExtraLabel(extra: facilitiy)
        
        cell.setPriceLabel(price: formatThousandSeparator(price: Int(bookedPlace.price), addIDR: true), backgroundColor: secondaryBackgroundColors[bookedPlace.category ?? ""] ?? UIColor.white)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }
    
    private func formatThousandSeparator(price: Int, addIDR: Bool) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        guard let fullPrice = formatter.string(from: NSNumber(value: price))
        else { return "" }
        
        return addIDR ? "IDR \(fullPrice)" : "\(fullPrice)"
    }
    
    private func dateFormatter(from: Date, to: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        return "\(formatter.string(from: from)) - \(formatter.string(from: to))"
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "historyToReceipt", sender: indexPath.section)
    }
}


