//
//  OnePhotoInTableViewCell.swift
//  Navigation
//
//  Created by Юлия Самсонова on 13.04.2022.
//

import UIKit

class PhotoForTableViewCell: UICollectionViewCell {

    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.photoImageView)

        NSLayoutConstraint.activate([
            self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }

    func setup(with photo: String) {
        self.photoImageView.image = UIImage()
    }

}
