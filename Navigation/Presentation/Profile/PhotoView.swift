//
//  PhotoView.swift
//  Navigation
//
//  Created by Юлия Самсонова on 12.05.2022.
//

import UIKit

class PhotoView: UIView {

    weak var photoViewDelegate: PhotoViewDelegate?

    lazy var photoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var closePhotoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "cross.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closePhoto), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(){
        self.addSubview(photoImageView)
        self.addSubview(closePhotoButton)

        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ].compactMap( {$0} ))

        NSLayoutConstraint.activate([
            closePhotoButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            closePhotoButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            closePhotoButton.widthAnchor.constraint(equalToConstant: 40),
            closePhotoButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            photoImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        } else {
            photoImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }

    @objc private func closePhoto(){
        photoViewDelegate?.closePhotoView(view: self)
    }
}

protocol PhotoViewDelegate: AnyObject {
    func closePhotoView(view: PhotoView)
}
