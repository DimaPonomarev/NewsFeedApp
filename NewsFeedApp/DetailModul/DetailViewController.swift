//
//  DetailViewController.swift
//  NewsFeedApp
//
//  Created by Дмитрий Пономарев on 13.07.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //  MARK: - UI properties
    
    var presenter: DetailViewPresenterProtocol?
    
    private let scrollView = UIScrollView()
    private let mainView = UIView()
    private let mainTitle = UILabel()
    private let newsImage = UIImageView()
    private let newsDescription = UILabel()
    private let dayOfPublication = UILabel()
    private let sourceOFNews = UILabel()
    private let URLAdressLabel = UILabel()
    
    //  MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        setupLayouts()
        setupViews()
        addGesture()
    }
}

//  MARK: - Extension DetailViewController

extension DetailViewController {
    
    //  MARK: - addViews
    
    func addViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(newsImage)
        mainView.addSubview(mainTitle)
        mainView.addSubview(newsDescription)
        mainView.addSubview(dayOfPublication)
        mainView.addSubview(sourceOFNews)
        mainView.addSubview(URLAdressLabel)
        presenter?.setComment()
    }
    
    //  MARK: - makeConstraints
    
    func setupLayouts() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -15).isActive = true
        mainTitle.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15).isActive = true
        mainTitle.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20).isActive = true
        
        dayOfPublication.translatesAutoresizingMaskIntoConstraints = false
        dayOfPublication.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -15).isActive = true
        dayOfPublication.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15).isActive = true
        dayOfPublication.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 30).isActive = true
        
        sourceOFNews.translatesAutoresizingMaskIntoConstraints = false
        sourceOFNews.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -15).isActive = true
        sourceOFNews.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15).isActive = true
        sourceOFNews.topAnchor.constraint(equalTo: dayOfPublication.bottomAnchor, constant: 3).isActive = true
        
        URLAdressLabel.translatesAutoresizingMaskIntoConstraints = false
        URLAdressLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -15).isActive = true
        URLAdressLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15).isActive = true
        URLAdressLabel.topAnchor.constraint(equalTo: sourceOFNews.bottomAnchor, constant: 15).isActive = true
        
        newsDescription.translatesAutoresizingMaskIntoConstraints = false
        newsDescription.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -15).isActive = true
        newsDescription.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15).isActive = true
        newsDescription.topAnchor.constraint(equalTo: URLAdressLabel.bottomAnchor, constant: 40).isActive = true
        newsDescription.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
    }
    
    //  MARK: - setupViews
    
    func setupViews() {
        
        newsImage.backgroundColor = .systemGray
        newsImage.contentMode = .scaleToFill
        mainTitle.font = .systemFont(ofSize: 20, weight: .black)
        mainTitle.numberOfLines = 0
        URLAdressLabel.numberOfLines = 0
        URLAdressLabel.textColor = .blue
        URLAdressLabel.font = .systemFont(ofSize: 12, weight: .medium)
        sourceOFNews.font = .systemFont(ofSize: 12, weight: .light)
        dayOfPublication.font = .systemFont(ofSize: 12, weight: .light)
        newsDescription.numberOfLines = 0
        newsDescription.font = .preferredFont(forTextStyle: .subheadline)
    }
    
    //  MARK: - addGesture
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnURLAdressLabel))
        URLAdressLabel.isUserInteractionEnabled = true
        URLAdressLabel.addGestureRecognizer(tap)
    }
    
    //  MARK: - addGesture
    
    @objc func tapOnURLAdressLabel() {
        guard let url = URL(string: URLAdressLabel.text ?? "") else { return }
        let vc = WebViewViewController(url: url, title: mainTitle.text ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
}

//  MARK: - setupNavBar

extension DetailViewController: DetailViewProtocol {
    func setCommentForView(comment: Article?) {
        mainTitle.text = comment?.title
        newsDescription.text = comment?.description
        if let source = comment?.source.name {
            sourceOFNews.text = "Источник: \(String(describing: source))"
        }
        URLAdressLabel.text = comment?.url
        dayOfPublication.text = comment?.publishedAt
        dayOfPublication.text = String.toDate(dateFormat: comment?.publishedAt ?? "")
        guard let url = Foundation.URL(string: (comment?.urlToImage ?? "nil")!) else { return }
        UIImage.loadFrom(url: url) { image in
            self.newsImage.image = image
            if image != nil {
                self.newsImage.translatesAutoresizingMaskIntoConstraints = false
                self.newsImage.widthAnchor.constraint(equalTo: self.mainView.widthAnchor).isActive = true
                self.newsImage.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 0).isActive = true
                self.newsImage.heightAnchor.constraint(equalToConstant: 280).isActive = true
            }
        }
    }
}
