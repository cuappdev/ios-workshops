//
//  SignInViewController.swift
//  CustomPopUpPlusAnimations
//
//  Created by Lucy Xu on 4/28/19.
//  Copyright © 2019 Lucy Xu. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    let appDevRed = UIColor.init(red: 183/255, green: 60/255, blue: 52/255, alpha: 1)

    var titleLabel: UILabel!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var signInButton: UIButton!
    var cardView: UIView!

    override func viewDidLoad() {
        view.backgroundColor = appDevRed

        titleLabel = UILabel()
        titleLabel.text = "Manual Sign In Screen"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        view.addSubview(titleLabel)

        cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        view.addSubview(cardView)

        signInButton = UIButton()
        signInButton.backgroundColor = appDevRed
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.layer.cornerRadius = 20
//        signInButton.layer.borderWidth = 1
//        signInButton.layer.borderColor = appDevRed.cgColor
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.setTitle("Sign In with Password", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        cardView.addSubview(signInButton)

        usernameTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.textColor = .black
        usernameTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        usernameTextField.borderStyle = .none
        usernameTextField.layer.masksToBounds = false
        usernameTextField.isSecureTextEntry = true
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = appDevRed.cgColor
        cardView.addSubview(usernameTextField)

        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        passwordTextField.borderStyle = .none
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = appDevRed.cgColor
//        passwordTextField.delegate = self
        cardView.addSubview(passwordTextField)

        setUpConstraints()

    }

    @objc func signIn() {
        self.dismiss(animated: true, completion: nil)
    }

    func setUpConstraints() {

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
            ])

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            usernameTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 25),
            usernameTextField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -25)
            ])

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 25),
            passwordTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 25),
            passwordTextField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -25)
            ])

        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signInButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 25),
            signInButton.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -25)
            ])

    }

}
