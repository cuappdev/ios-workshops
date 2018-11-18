//
//  Writing.swift
//  UIDocument Demo
//
//  Created by Jaewon Sim on 11/17/18.
//  Copyright © 2018 Jaewon Sim. All rights reserved.
//

import Foundation

struct Writing: Codable {
    
    var title: String
    var text: String
    var textColor: String
    
    var json: Data? { // a simple JSON representation of the Writing
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data) {
        if let writing = try? JSONDecoder().decode(Writing.self, from: json) {
            self = writing
        } else {
            print ("failed to initialize JSON")
            return nil
        }
    }
    
    init(title: String, text: String, textColor: String) {
        self.title = title
        self.text = text
        self.textColor = textColor
    }
}
