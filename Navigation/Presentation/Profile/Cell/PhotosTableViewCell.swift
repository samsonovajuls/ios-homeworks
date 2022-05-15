//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Юлия Самсонова on 12.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    var images = [UIImage]()

    weak var photosTableViewCellDelegate: PhotosTableViewCellDelegate?

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.sizeToFit()
        return stackView
    }()

    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoForCollectionInTableViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.photosLabel)
        self.stackView.addArrangedSubview(self.arrowImage)
        self.contentView.addSubview(self.photoCollectionView)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
        ])

        NSLayoutConstraint.activate([
            self.arrowImage.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor),
            self.arrowImage.widthAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            self.photoCollectionView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            self.photoCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4),
            self.photoCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4),
            self.photoCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.photoCollectionView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25)
        ])

        for i in 1...4 {
            if let image = UIImage(named: "mult\(i)") {
                self.images.append(image)
            }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.photoCollectionView.collectionViewLayout.invalidateLayout()
    }
}


extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    private var sideInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.images.count // - это чтобы показать все картинки с горизонтальным скролом, а не только первые 4 (как по заданию). Только в этом случае еще надо добавить в images не 4, а все 20 картинок
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoForCollectionInTableViewCell
        let image = self.images[indexPath.item]
        cell.photoImageView.image = image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 5) / 4
        return CGSize(width: width, height: width * 0.8)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photosTableViewCellDelegate?.didSelectItem()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: sideInset, bottom: 12, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}

protocol PhotosTableViewCellDelegate: AnyObject {
    func didSelectItem()
}
