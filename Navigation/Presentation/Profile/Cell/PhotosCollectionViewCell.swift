//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Юлия Самсонова on 12.04.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.photoImageView)

        NSLayoutConstraint.activate([
            self.photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.photoImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }

    func setup(with photo: UIImage) {
        self.photoImageView.image = photo
    }

}
