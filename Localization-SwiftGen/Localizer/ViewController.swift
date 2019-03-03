//
//  ViewController.swift
//  Localizer
//
//  Created by William Ma on 2/10/19.
//  Copyright © 2019 William Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = L10n.Introduction.welcome
    }

    @IBAction func activateSecret(_ sender: Any) {
        perform(segue: StoryboardSegue.Main.showSecret)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = StoryboardSegue.Main(rawValue: segue.identifier!)!
        switch identifier {
        case .showSecret:
            let vc = segue.destination as! Secret
            vc.loadViewIfNeeded()
            vc.bottomImage.image = Asset.asdflkjasdflj.image
        }
    }

}
