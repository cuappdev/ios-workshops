//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        self.view = view

        imageView1 = UIImageView()
        imageView1.contentMode = .scaleAspectFill
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView1.backgroundColor = .blue
        imageView1.clipsToBounds = true
        view.addSubview(imageView1)

        imageView2 = UIImageView()
        imageView2.contentMode = .scaleAspectFill
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        imageView2.backgroundColor = .red
        imageView2.clipsToBounds = true
        view.addSubview(imageView2)

        imageView3 = UIImageView()
        imageView3.contentMode = .scaleAspectFill
        imageView3.clipsToBounds = true
        imageView3.translatesAutoresizingMaskIntoConstraints = false
        imageView3.backgroundColor = .green
        view.addSubview(imageView3)

        setupConstraints()
        loadImages()
    }

    func setupConstraints() {
        let imageWidthHeight: CGFloat = 170
        NSLayoutConstraint.activate([
            imageView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            imageView1.widthAnchor.constraint(equalToConstant: imageWidthHeight),
            imageView1.heightAnchor.constraint(equalToConstant: imageWidthHeight)
            ])

        NSLayoutConstraint.activate([
            imageView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView2.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 16),
            imageView2.widthAnchor.constraint(equalToConstant: imageWidthHeight),
            imageView2.heightAnchor.constraint(equalToConstant: imageWidthHeight)
            ])

        NSLayoutConstraint.activate([
            imageView3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView3.topAnchor.constraint(equalTo: imageView2.bottomAnchor, constant: 16),
            imageView3.widthAnchor.constraint(equalToConstant: imageWidthHeight),
            imageView3.heightAnchor.constraint(equalToConstant: imageWidthHeight)
            ])

    }

    func loadImages() {
        getRandomDog { dog in
            let image = self.getImageFromURLString(dog.url)
            DispatchQueue.main.async {
                self.imageView1.image = image
            }
        }

        getRandomDog { dog in
            let image = self.getImageFromURLString(dog.url)
            DispatchQueue.main.async {
                self.imageView2.image = image
            }
        }

        getRandomDog { dog in
            let image = self.getImageFromURLString(dog.url)
            DispatchQueue.main.async {
                self.imageView3.image = image
            }
        }
    }

    // MARK: - Networking
    struct Dog: Codable {
        var id: String
        var url: String
    }

    let apiURL = URL(string: "https://api.thedogapi.com/v1/images/search?")!

    func getRandomDog(completion: @escaping (Dog) -> Void) {
        let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
            let jsonDecoder = JSONDecoder()
            let dogResponse = try! jsonDecoder.decode([Dog].self, from: data)
            let firstDog = dogResponse.first!
            completion(firstDog)
        }
        task.resume()
    }

    func getImageFromURLString(_ urlString: String) -> UIImage? {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return nil
    }

}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()














//func getThreeDogsAtOnce(completion: @escaping (Dog, Dog, Dog) -> Void) {
//    var dogList = [Dog]()
//
//    let dispatchGroup = DispatchGroup()
//    for _ in 0...2 {
//        dispatchGroup.enter()
//        getRandomDog { dog in
//            dogList.append(dog)
//            dispatchGroup.leave()
//        }
//    }
//
//    dispatchGroup.notify(queue: .main) {
//        let dog1 = dogList[0]
//        let dog2 = dogList[1]
//        let dog3 = dogList[2]
//        completion(dog1, dog2, dog3)
//    }
//}

//getThreeDogsAtOnce { (dog1, dog2, dog3) in
//    let image1 = self.getImageFromURLString(dog1.url)
//    let image2 = self.getImageFromURLString(dog2.url)
//    let image3 = self.getImageFromURLString(dog3.url)
//    DispatchQueue.main.async {
//        self.imageView1.image = image1
//        self.imageView2.image = image2
//        self.imageView3.image = image3
//    }
//}
