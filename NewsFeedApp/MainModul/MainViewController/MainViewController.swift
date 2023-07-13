//
//  MainViewController.swift
//  NewsFeedApp
//
//  Created by Дмитрий Пономарев on 13.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //    MARK: - UI Properties
    
    var presenter: MainViewPresenterProtocol?
    
    let tableView = UITableView()
    private var refreshControl = UIRefreshControl()
    
    //    MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Today's News"
        addViews()
        makeConstraints()
        setupViews()
    }
    
    //  MARK: - addViews
    
    func addViews() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    //    MARK: - Make Constraints
    
    func makeConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    //  MARK: - setupViews
    
    func setupViews() {
        presenter?.getCommentsFromCashe()
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    //  MARK: - @objc func refresh
    
    @objc func refresh() {
        presenter?.getCommentsFromCashe()
    }
}

//  MARK: - Extension MainViewController

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        let comment = presenter?.comments?[indexPath.row]
        cell?.configureView(textForCell: comment!)
        return cell!
    }
}

//  MARK: - Extension MainViewController

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.tapOnComment(indexPath: indexPath.row)
        self.tableView.reloadData()
    }
}

//  MARK: - Extension MainViewController

extension MainViewController: MainViewProtocol {
    
    func sendModelToViewController() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func sendFailureToViewController(error: Error) {
        print (error.localizedDescription)
    }
}
