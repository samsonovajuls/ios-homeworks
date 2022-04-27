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

    private enum Constant {
        static let itemCount: CGFloat = 4
    }

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        return layout
    }()

    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoForTableViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
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
        
        self.backgroundColor = .systemGray6
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.photosLabel)
        self.stackView.addArrangedSubview(self.arrowImage)
        self.backView.addSubview(photoCollectionView)

        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12),
            self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12),
        ])

        NSLayoutConstraint.activate([
            self.arrowImage.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor),
            self.arrowImage.widthAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            self.photoCollectionView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            self.photoCollectionView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            self.photoCollectionView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12),
            self.photoCollectionView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor),
            self.photoCollectionView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25)
        ])

        for i in 1...20 {
            if let image = UIImage(named: "mult\(i)") {
                self.images.append(image)
            }
        }
    }

    func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize { // размеры ячейки
        let needWidth = width - 4 * spacing
        let itemWidth = floor(needWidth / Constant.itemCount)
        return CGSize(width: itemWidth, height: itemWidth * 0.8)
    }
}


extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // это чтобы показать все картинки с горизонтальным скролом, а не только первые 4 (как по заданию)
        // return self.images.count
          return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoForTableViewCell
        let image = self.images[indexPath.item]
        cell.photoImageView.image = image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photosTableViewCellDelegate?.didSelectItem()
    }
}

protocol PhotosTableViewCellDelegate: AnyObject {
    func didSelectItem()
}
