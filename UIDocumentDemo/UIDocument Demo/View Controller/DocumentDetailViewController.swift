//
//  DocumentViewController.swift
//  UIDocument Demo
//
//  Created by Jaewon Sim on 11/17/18.
//  Copyright © 2018 Jaewon Sim. All rights reserved.
//

import UIKit
import SnapKit

class DocumentDetailViewController: UIViewController {
    
    var document: WritingDocument?
    var writing: Writing?
    
    var documentTitleTextField: UITextField!
    var documentTextView: UITextView!
    var documentTextColorSegmentedControl: UISegmentedControl!
    var saveButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Open document with completion handler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.writing = self.document?.writing
        
        documentTitleTextField = UITextField()
        documentTitleTextField.borderStyle = .roundedRect
        documentTitleTextField.tintColor = .white
        documentTitleTextField.placeholder = "Document Title"
        view.addSubview(documentTitleTextField)
        
        documentTextView = UITextView()
        documentTextView.isEditable = true
        
        view.addSubview(documentTextView)
        
        documentTextColorSegmentedControl = UISegmentedControl()
        documentTextColorSegmentedControl.insertSegment(withTitle: "Black", at: 0, animated: true)
        documentTextColorSegmentedControl.insertSegment(withTitle: "Blue", at: 1, animated: true)
        documentTextColorSegmentedControl.insertSegment(withTitle: "Red", at: 1, animated: true)
        documentTextColorSegmentedControl.addTarget(self, action: #selector(changeTextColor), for: .valueChanged)
        documentTextColorSegmentedControl.tintColor = .white
        
        view.addSubview(documentTextColorSegmentedControl)
        
        saveButton = UIButton()
        saveButton.setTitle("Save Document and Exit", for: .normal)
//        saveButton.tintColor = .white
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        view.addSubview(saveButton)
        
        // Fill in UI elements with data from document
        self.documentTitleTextField.text = self.writing?.title
        self.documentTextView.text = self.writing?.text
        switch self.writing?.textColor {
        case "Black":
            self.documentTextColorSegmentedControl.selectedSegmentIndex = 0
        case "Blue":
            self.documentTextColorSegmentedControl.selectedSegmentIndex = 1
        case "Red":
            self.documentTextColorSegmentedControl.selectedSegmentIndex = 2
        case .none, .some(_):
            self.documentTextColorSegmentedControl.selectedSegmentIndex = 0
        }
        
        setUpConstraints()
        
    }
    
    @objc func save() {
        writing?.title = documentTitleTextField.text ?? ""
        writing?.text = documentTextView.text
        writing?.textColor = ["Black", "Blue", "Red"][documentTextColorSegmentedControl.selectedSegmentIndex]
        
        document?.writing = writing
        document?.updateChangeCount(.done) // let document know that it has changed
        document?.close() // close document before dismissing view
        dismiss(animated: true)
    }
    
    @objc func changeTextColor() {
        let colors = ["Black", "Blue", "Red"]
        let selectedColor = colors [documentTextColorSegmentedControl.selectedSegmentIndex]
        
        writing?.textColor = selectedColor
    }
    
    func setUpConstraints() {
        documentTitleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.right.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        
        documentTextColorSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(documentTitleTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(15)
        }
        
        documentTextView.snp.makeConstraints { make in
            make.top.equalTo(documentTextColorSegmentedControl.snp.bottom).offset(20)
            make.left.right.equalTo(documentTextColorSegmentedControl)
            make.height.equalTo(500)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(documentTextView.snp.bottom).offset(20)
            make.left.right.equalTo(documentTextColorSegmentedControl)
        }
        
        
    }
    
}
