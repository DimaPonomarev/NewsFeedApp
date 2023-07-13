//
//  CustomTableViewCell.swift
//  NewsFeedApp
//
//  Created by Дмитрий Пономарев on 13.07.2023.
//

import UIKit
import Kingfisher

final class CustomTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    //  MARK: - UI properties
    
    private let newsTitleLabel = UILabel()
    private var newsImage = UIImageView()
    private let countOfShows = UILabel()
    
    //  MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.image = nil
    }
    
    //   MARK: - Public Methods
    
    func configureView(textForCell: Article) {
        newsTitleLabel.text = textForCell.title
        countOfShows.text = "Просмотрено раз: \(textForCell.number ?? 0)"
        guard let imageURL = textForCell.urlToImage else { return }
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "no"))
    }
}

//  MARK: - Private methods

extension CustomTableViewCell {
    
    //  MARK: - Setup
    
    private func setup() {
        addViews()
        setupViews()
        constraints()
    }
    //  MARK: - addViews
    
    private func addViews() {
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsImage)
        contentView.addSubview(countOfShows)
    }
    
    //  MARK: - makeConstraints
    
    func constraints() {
        self.newsImage.translatesAutoresizingMaskIntoConstraints = false
        self.newsImage.topAnchor.constraint(equalTo: self.newsTitleLabel.bottomAnchor, constant: 3).isActive = true
        self.newsImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.newsImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true
        self.newsImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15).isActive = true
        self.newsImage.bottomAnchor.constraint(equalTo: self.countOfShows.topAnchor, constant: -5).isActive = true
        
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        newsTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        newsTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        countOfShows.translatesAutoresizingMaskIntoConstraints = false
        countOfShows.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        countOfShows.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        countOfShows.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    //  MARK: - setupViews
    
    private func setupViews() {
        
        newsTitleLabel.font = .systemFont(ofSize: 16, weight: .black)
        newsTitleLabel.numberOfLines = 0
        newsImage.contentMode = .scaleToFill
        newsImage.layer.cornerRadius = 10
        newsImage.clipsToBounds = true
        countOfShows.font = .systemFont(ofSize: 15, weight: .light)
    }
}
