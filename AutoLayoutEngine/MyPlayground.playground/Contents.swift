import UIKit
import PlaygroundSupport

class SurpriseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews() //After this, all subviews have been laid out
        print("Bounds after super.layoutSubviews \(bounds)")
        //layer.cornerRadius = bounds.height * 0.5
    }
}


class ViewController: UIViewController {

    var surpriseButton: SurpriseButton!
    var animatedView: UIView!
    var animatedViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        view.backgroundColor = .white

        // 1 - init does not do anything with layout
        surpriseButton = SurpriseButton(frame: .zero)
        surpriseButton.setTitle("Press Me", for: .normal)
        surpriseButton.backgroundColor = .blue
        surpriseButton.translatesAutoresizingMaskIntoConstraints = false
        //surpriseButton.addTarget(self, action: #selector(didPressSurpriseButton(sender:)), for: .touchUpInside)
        print("add to subview")
        view.addSubview(surpriseButton) // 2 - adding to subview does layout, but the frame we set is .zero
        print("did add to subview")

        print("add constraints")
        NSLayoutConstraint.activate([
            surpriseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surpriseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            surpriseButton.heightAnchor.constraint(equalToConstant: 40),
            surpriseButton.widthAnchor.constraint(equalToConstant: surpriseButton.intrinsicContentSize.width + 40)
            ]) //after constraints, it automagically updated
        print("did add constraints")

        //View Setup
        animatedView = UIView()
        animatedView.backgroundColor = .green
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animatedView)
        animatedViewHeightConstraint = animatedView.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([
            animatedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            animatedViewHeightConstraint,
            animatedView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7)
            ])
    }

    @objc func didPressSurpriseButton(sender: UIButton) {
        view.layoutIfNeeded() //why? because Apple considers this a best practice to ensure any previous changes are completed

        if animatedViewHeightConstraint.constant == 40 {
            animatedViewHeightConstraint.constant = 150 //automatically calls setNeedsLayout()
        } else {
            self.animatedViewHeightConstraint.constant = 40 //automatically calls setNeedsLayout()
        }

        UIView.animate(withDuration: 2.0) {
            //self.animatedViewHeightConstraint.constant = 40
            //self.view.layoutIfNeeded() //this happens synchronously
            //self.view.setNeedsLayout()
        }
    }
}

PlaygroundPage.current.liveView = ViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
