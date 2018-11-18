//
//  Document.swift
//  UIDocument Demo
//
//  Created by Jaewon Sim on 11/17/18.
//  Copyright © 2018 Jaewon Sim. All rights reserved.
//

import UIKit

class WritingDocument: UIDocument {
    
    var writing: Writing?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return writing?.json ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        if let json = contents as? Data {
            writing = Writing(json: json)
        }
    }
}

