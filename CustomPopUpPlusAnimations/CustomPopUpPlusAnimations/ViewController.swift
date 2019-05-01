//
//  ViewController.swift
//  CustomPopUpPlusAnimations
//
//  Created by Lucy Xu on 4/19/19.
//  Copyright © 2019 Lucy Xu. All rights reserved.
//

import UIKit

// import the LocalAuthentication framework
import LocalAuthentication

class ViewController: UIViewController {

    let appDevRed = UIColor.init(red: 183/255, green: 60/255, blue: 52/255, alpha: 1)
    
    var titleLabel: UILabel!
    var touchSignInButton: UIButton!
    var passwordSignInButton: UIButton!
    var appDevLogoImageView: UIImageView!
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var popUpView: VerificationPopUpView = {
        let view = VerificationPopUpView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        visualEffectView.alpha = 0

        appDevLogoImageView = UIImageView()
        appDevLogoImageView.image = UIImage(named: "appdev")
        appDevLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appDevLogoImageView)

        titleLabel = UILabel()
        titleLabel.text = "LocalAuthentication Demo"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = appDevRed
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.addSubview(titleLabel)

        passwordSignInButton = UIButton()
        passwordSignInButton.backgroundColor = .white
        passwordSignInButton.translatesAutoresizingMaskIntoConstraints = false
        passwordSignInButton.layer.cornerRadius = 20
        passwordSignInButton.layer.borderWidth = 1
        passwordSignInButton.layer.borderColor = appDevRed.cgColor
        passwordSignInButton.addTarget(self, action: #selector(passwordSignIn), for: .touchUpInside)
        passwordSignInButton.setTitle("Sign In with Password", for: .normal)
        passwordSignInButton.setTitleColor(appDevRed, for: .normal)
        view.addSubview(passwordSignInButton)

        touchSignInButton = UIButton()
        touchSignInButton.backgroundColor = appDevRed
        touchSignInButton.translatesAutoresizingMaskIntoConstraints = false
        touchSignInButton.layer.cornerRadius = 20
        touchSignInButton.addTarget(self, action: #selector(authenticateUser), for: .touchUpInside)
        touchSignInButton.setTitle("Sign In with Touch ID", for: .normal)
        touchSignInButton.setTitleColor(.white, for: .normal)
        view.addSubview(touchSignInButton)
        
        setUpConstraints()
        
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            appDevLogoImageView.widthAnchor.constraint(equalToConstant: 200),
            appDevLogoImageView.heightAnchor.constraint(equalToConstant: 200),
            appDevLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appDevLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100 )
            ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: appDevLogoImageView.bottomAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

        NSLayoutConstraint.activate([
            passwordSignInButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            passwordSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordSignInButton.heightAnchor.constraint(equalToConstant: 40),
            passwordSignInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            passwordSignInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
            ])

        NSLayoutConstraint.activate([
            touchSignInButton.topAnchor.constraint(equalTo: passwordSignInButton.bottomAnchor, constant: 25),
            touchSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            touchSignInButton.heightAnchor.constraint(equalToConstant: 40),
            touchSignInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            touchSignInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
            ])
    }

    func displayPopUp() {
        self.view.addSubview(self.popUpView)
        self.setUpPopUpConstraints()
    }
    
    func setUpPopUpConstraints() {
        NSLayoutConstraint.activate([
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: 200),
            popUpView.widthAnchor.constraint(equalToConstant: 300)
            ])
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        UIView.animate(withDuration: 0.30, animations: {
            self.visualEffectView.alpha = 1
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        })
    }

    @objc func passwordSignIn() {
        let passwordSignInViewController = SignInViewController()
        self.navigationController?.present(passwordSignInViewController, animated: true, completion: nil)
    }

    @objc func authenticateUserDummy() {
        let ac = UIAlertController(title: "Local Authentication Unimplemented", message: "Show Local Authentication Demo!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    @objc func authenticateUser() {

        // create a instance context of LAContext - provides the UI for evaluating authentication policies and access controls, managing credentials, and invalidating authentication contexts

        let context = LAContext()
        var error: NSError?

        //custom cancel button text
        context.localizedCancelTitle = "Enter Password Instead"

        if #available(iOS 8.0, macOS 10.12.1, *) {

            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {

                let reasonText = "Local Authentication Verification Demo!"
                // localizedReason: displayed message in prompt
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonText) {
                    [unowned self] success, authenticationError in
                    DispatchQueue.main.sync {
                        if success {
                            // perform action if id success
                            let secretViewController = SecretViewController()
                            self.navigationController?.pushViewController(secretViewController, animated: true)

                        } else {

                            if let authError = authenticationError {
                                let errorCode = authError._code
                                switch errorCode {
                                    case LAError.authenticationFailed.rawValue:
                                        // Authentication Failure
                                        self.displayPopUp()
                                    case LAError.biometryLockout.rawValue:
                                        // User got locked out after too many attempts
                                        print("Oops, seems like you were locked out!")
                                        self.displayPopUp()
                                    case LAError.userCancel.rawValue:
                                        // User chooses to use alternative log in instead
                                        self.passwordSignIn()
                                    default:
                                        self.displayPopUp()
                                }
                            }

//                            let ac = UIAlertController(title: "Authentication failed", message: "Try again!", preferredStyle: .alert)
//                            ac.addAction(UIAlertAction(title: "OK", style: .default))
//                            self.present(ac, animated: true)

//                                self.displayPopUp()
                        }
                    }
                }
            } else {
                if let evalError = error {
                    let evalErrorCode = evalError._code
                    switch evalErrorCode {
                    case LAError.biometryLockout.rawValue:
                        // User got locked out after too many attempts
                        let alertController = UIAlertController(title: "Oh no, you were locked out!", message: "Sign In with Password", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default))
                        present(alertController, animated: true)
                    default:
                        // if device is not touchID enabled, then present a fail alert
                        let alertController = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default))
                        present(alertController, animated: true)
                    }
                }
//                let alertController = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: .default))
//                present(alertController, animated: true)
            }
        }
    }

}

extension ViewController: PopUpDelegate {
    func handleDismissal() {
        UIView.animate(withDuration: 0.25, animations: {
            self.visualEffectView.alpha = 0
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpView.removeFromSuperview()
        }
    }
}
