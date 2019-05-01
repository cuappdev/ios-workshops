//
//  SecretViewController.swift
//  CustomPopUpPlusAnimations
//
//  Created by Lucy Xu on 4/28/19.
//  Copyright © 2019 Lucy Xu. All rights reserved.
//

import UIKit
import Lottie

class SecretViewController: UIViewController {

    var animationView: LOTAnimationView!

    let appDevRed = UIColor.init(red: 183/255, green: 60/255, blue: 52/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = appDevRed
        animationView = LOTAnimationView(name: "plane")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        view.addSubview(animationView)

        setUpConstraints()
        animationView.play()

    }

    func setUpConstraints() {

        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
