//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Юлия Самсонова on 03.04.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    struct ViewModel: ViewModelProtocol {
        let author, description, image: String
        let likes, views: Int
    }

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likesAndViewsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    weak var postTableViewCellDelegate: PostTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.authorLabel.text = nil
        self.postImageView.image = nil
        self.descriptionLabel.text = nil
        self.viewsLabel.text = nil
        self.likesLabel.text = nil
    }

    private func setupGesture() {
        let likesLabelTap = UITapGestureRecognizer(target: self, action: #selector(tapLikesLabel))
        self.likesLabel.addGestureRecognizer(likesLabelTap)
        self.likesLabel.isUserInteractionEnabled = true

        let postImageViewTap = UITapGestureRecognizer(target: self, action: #selector(tapPostImageView))
        self.postImageView.addGestureRecognizer(postImageViewTap)
        self.postImageView.isUserInteractionEnabled = true
    }

    @objc private func tapLikesLabel() {
        postTableViewCellDelegate?.increaseLikes(cell: self)
    }
    
    @objc private func tapPostImageView() {
        postTableViewCellDelegate?.showPostDetail(cell: self)
    }

    private func setupView() {
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.authorLabel)
        self.contentView.addSubview(self.postImageView)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.likesAndViewsStackView)
        self.likesAndViewsStackView.addArrangedSubview(self.likesLabel)
        self.likesAndViewsStackView.addArrangedSubview(self.viewsLabel)

        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            self.postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.postImageView.heightAnchor.constraint(lessThanOrEqualTo: self.postImageView.widthAnchor, multiplier: 1.0)
        ])

        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            self.likesAndViewsStackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.likesAndViewsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.likesAndViewsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.likesAndViewsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}

extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }

        self.authorLabel.text = viewModel.author
        self.postImageView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)
    }
}

protocol PostTableViewCellDelegate: AnyObject {
    func increaseLikes(cell: PostTableViewCell)
    func showPostDetail(cell: PostTableViewCell)
}
