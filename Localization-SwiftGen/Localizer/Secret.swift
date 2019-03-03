//
//  Secret.swift
//  Localizer
//
//  Created by William Ma on 2/10/19.
//  Copyright © 2019 William Ma. All rights reserved.
//

import UIKit

class Secret: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        topImage.image = Asset.southernBrunchProduct.image
        bottomImage.image = Asset.untitled.image

        var index = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            switch index {
            case 0: self.view.backgroundColor = Asset.red.color
            case 1: self.view.backgroundColor = Asset.yellow.color
            case 2: self.view.backgroundColor = Asset.blue.color
            case 3: self.view.backgroundColor = Asset.green.color
            case 4: self.view.backgroundColor = Asset.purple.color
            case 5: self.view.backgroundColor = Asset.orange.color
            default: break
            }

            index += 1
            index %= 6
        }
    }

}
