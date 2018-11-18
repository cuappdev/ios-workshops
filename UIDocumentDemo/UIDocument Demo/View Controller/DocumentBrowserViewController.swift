//
//  DocumentBrowserViewController.swift
//  UIDocument Demo
//
//  Created by Jaewon Sim on 11/17/18.
//  Copyright © 2018 Jaewon Sim. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController {

    var template: URL?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = false
        
        template = try? FileManager.default.url(
            for: .applicationSupportDirectory, //applicationSupportDirectory
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("Untitled.json")
        if template != nil {
            allowsDocumentCreation = FileManager.default.createFile(atPath: template!.path, contents: Data()) // doc creation is only allowed when the app can get the template
        }
        
        allowsPickingMultipleItems = false
        
        browserUserInterfaceStyle = .dark
        view.tintColor = .white
    
        // Specify the allowed content types of your application via the Info.plist.
    }
}

// MARK: - UIDBVC Delegate
extension DocumentBrowserViewController: UIDocumentBrowserViewControllerDelegate {
    
    // get the URL for the blank document
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        
        guard let temp = template else { return }
        // 1
        let newdoc = WritingDocument(fileURL: temp)
        
        // 2
        newdoc.save(to: temp, for: .forCreating) { saveSuccess in
            guard saveSuccess else {
                importHandler(nil, .none)
                return
            }
            
            newdoc.close { closeSuccess in
                guard closeSuccess else {
                    importHandler(nil, .none)
                    return
                }
                
                importHandler(temp, .move)
            }
        }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        let documentVC = DocumentDetailViewController()
        print("docURL \(documentURL)")
        let doc = WritingDocument(fileURL: documentURL)
        
        doc.open { success in
            if success {
                documentVC.document = doc
                self.present(documentVC, animated: true)
            }
        }
        
    
    }
}
