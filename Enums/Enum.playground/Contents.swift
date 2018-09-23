//: Playground - noun: a place where people can play

import UIKit

//class Payment {
//    var isFree: Bool
//    var price: Int?
//    var currency: String?
//
//    init(isFree: Bool, price: Int?, currency: String?) {
//        self.isFree = isFree
//        self.price = price
//        self.currency = currency
//    }
//
//    func sendPayment() {
//        if isFree {
//            print("Sending free payment")
//        } else {
//            if let price = price,
//            let currency = currency {
//                print("Price is \(price) and currency is \(currency)")
//            } else {
//                print("Error with price and currency")
//            }
//        }
//    }
//}
//
//let payment = Payment(isFree: false, price: 5, currency: nil)
//payment.sendPayment()


























class Payment {

    enum Cost {
        case free
        case paid(price: Int, currency: String)
    }

    var cost: Cost

    init(cost: Cost) {
        self.cost = cost
    }

    func sendPayment() {
        switch cost {
        case .free:
            print("Sending free payment")
        case .paid(let price, let currency):
            print("Price is \(price) and currency is \(currency)")
        }
    }
}
let payment = Payment(cost: .paid(price: 5, currency: "USD"))
payment.sendPayment()
