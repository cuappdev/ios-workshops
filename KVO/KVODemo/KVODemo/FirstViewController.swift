//
//  FirstViewController.swift
//  KVODemo
//
//  Created by Jack Thompson on 11/3/18.
//  Copyright © 2018 Jack Thompson. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class Student: NSObject {
    var name: String = ""
    @objc dynamic var gpa: String = ""
}

class FirstViewController: UIViewController {
    @objc let student = Student()

    var nameLabel: UILabel!
    var gpaLabel: UILabel!
    var enterGradesButton: UIButton!
    var gpaObservationToken: NSKeyValueObservation?

    override func viewDidLoad() {

        view.backgroundColor = .white
        title = "Grades"

        student.name = "Austin"
        student.gpa = "4.0"

        nameLabel = UILabel()
        nameLabel.text = "Student: \(student.name)"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview()
        }

        gpaLabel = UILabel()
        gpaLabel.text = "GPA: \(student.gpa)"
        gpaLabel.textColor = .black
        gpaLabel.textAlignment = .center
        view.addSubview(gpaLabel)

        gpaLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalToSuperview()
        }

        enterGradesButton = UIButton()
        enterGradesButton.setTitle("Change GPA", for: .normal)
        enterGradesButton.addTarget(self, action: #selector(didPressEnterGrades), for: .touchUpInside)
        enterGradesButton.backgroundColor = .red
        view.addSubview(enterGradesButton)

        enterGradesButton.snp.makeConstraints { make in
            make.top.equalTo(gpaLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
        }

        
        gpaObservationToken = observe(\.student.gpa, options: [.new, .old], changeHandler: { (strongSelf, change) in
            guard let oldValue = change.oldValue, let newValue = change.newValue else { return }
            strongSelf.gpaLabel.text = newValue
            if let oldGPA = Double(oldValue), let newGPA = Double(newValue) {
                strongSelf.gpaLabel.textColor = oldGPA <= newGPA ? .green : .red
            }
        })
    }

    @objc func didPressEnterGrades() {
        let alert = UIAlertController(title: "Enter GPA", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            if let gpa = alert.textFields?[0].text {
                self.student.gpa = gpa
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

class SecondViewController: UIViewController, UITextFieldDelegate {

    var gradeEntry: UITextField!
    var grade: Double!
    var student: Student!

    init(student: Student) {
        self.student = student
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        title = "Enter Grades"

        gradeEntry = UITextField()
        gradeEntry.placeholder = "Enter grade"
        gradeEntry.returnKeyType = .send
        gradeEntry.backgroundColor = .gray
        gradeEntry.delegate = self
        view.addSubview(gradeEntry)

        gradeEntry.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(100)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newGPA = textField.text {
            student.gpa = newGPA
            return true
        }
        return false
    }
}

