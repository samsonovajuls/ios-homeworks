//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 24.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    var images = [UIImage]()
    
    private lazy var photosCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collection.backgroundColor = .white
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        fixTabAndNavForIOS15 (color: view.backgroundColor)
        self.drawSelf()

        for i in 1...20 {
            if let image = UIImage(named: "mult\(i)") {
                images.append(image)
            }
        }
    }

    private func drawSelf(){
        view.addSubview(photosCollection)

        NSLayoutConstraint.activate([
            self.photosCollection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.photosCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.photosCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.photosCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.backButtonTitle = "Back"
        self.navigationItem.title = "Photo Gallery"
    }

    func fixTabAndNavForIOS15(color: UIColor?) {
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = color
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = color
            tabBarController?.tabBar.standardAppearance = tabBarAppearance
            tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    private var sideInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let image = images[indexPath.item]
        cell.setup(with: image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
     }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}
