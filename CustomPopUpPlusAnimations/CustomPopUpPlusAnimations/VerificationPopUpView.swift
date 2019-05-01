//
//  VerificationPopUpView.swift
//  CustomPopUpPlusAnimations
//
//  Created by Lucy Xu on 4/20/19.
//  Copyright © 2019 Lucy Xu. All rights reserved.
//

import UIKit
import Lottie

protocol PopUpDelegate {
    func handleDismissal()
}

class VerificationPopUpView: UIView {

    var delegate: PopUpDelegate?

    var failureLabel: UILabel!
    var cancelSignInButton: UIButton!
    
    let appDevRed = UIColor.init(red: 183/255, green: 60/255, blue: 52/255, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 13/255, green: 20/255, blue: 34/255, alpha: 0.8)
        layer.borderColor = appDevRed.cgColor
        layer.borderWidth = 0.5

        failureLabel = UILabel()
        failureLabel.translatesAutoresizingMaskIntoConstraints = false
        failureLabel.text = "Oh no, something seemed to have went wrong!"
        failureLabel.numberOfLines = 2
        failureLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        failureLabel.textColor = .white
        addSubview(failureLabel)
    
        cancelSignInButton = UIButton()
        cancelSignInButton.translatesAutoresizingMaskIntoConstraints = false
        cancelSignInButton.setTitle("Dismiss", for: .normal)
        cancelSignInButton.layer.cornerRadius = 20
        cancelSignInButton.backgroundColor = appDevRed
        cancelSignInButton.setTitleColor(.white, for: .normal)
        cancelSignInButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        cancelSignInButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        
        addSubview(cancelSignInButton)

        setUpConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {

        NSLayoutConstraint.activate([
            failureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            failureLabel.heightAnchor.constraint(equalToConstant: 45),
            failureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            failureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
            ])

        NSLayoutConstraint.activate([
            cancelSignInButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            cancelSignInButton.heightAnchor.constraint(equalToConstant: 45),
            cancelSignInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            cancelSignInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
            ])
    }
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }

}
