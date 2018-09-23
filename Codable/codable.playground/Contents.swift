import UIKit

var str = "Hello, playground"



struct Food: Codable {
    var foodType: String
    var name: String
}

class Restaurant: Codable {
    var name: String
    var currentlyOpen: Bool //currently_open
    var description: String?
    var food: [Food]
}

//func downloadAndParseData() -> [Restaurant] {
//
//    //get file url
//    let fileUrl = Bundle.main.url(forResource: "restaurant-data", withExtension: "json")
//
//    //create data
//    let data = try! Data(contentsOf: fileUrl!, options: [])
//
//    //deserialize json
//    guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [Any] else {
//        print("error")
//        return []
//    }
//
//    var restaurants: [Restaurant] = []
//    for restaurant in json {
//        guard let dict = restaurant as? [String: Any] else {
//            continue
//        }
//
//        guard let currentlyOpen = dict["currentlyOpen"] as? Bool,
//            let name = dict["name"] as? String else {
//                continue
//        }
//
//        let description = dict["description"] as? String
//
//        let newRestaurant = Restaurant(name: name, currentlyOpen: currentlyOpen, description: description)
//        restaurants.append(newRestaurant)
//    }
//
//    return restaurants
//}
//
//let restaurants = downloadAndParseData()









func codableParsing() -> [Restaurant] {

    let fileUrl = Bundle.main.url(forResource: "restaurant-data", withExtension: "json")
    let data = try! Data(contentsOf: fileUrl!, options: [])

    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    let restaurants = try! jsonDecoder.decode([Restaurant].self, from: data)

    
    return restaurants
}

let restaurants = codableParsing()


