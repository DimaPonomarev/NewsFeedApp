//
//  DetailPresenter.swift
//  MVPModel
//
//  Created by Дмитрий Пономарев on 30.01.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setCommentForView(comment:Article?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view:DetailViewProtocol, networkService: NetworkService, router: RouterProtocol, comment: Article?)
    func setComment()
}

class DetailPresenter:DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkerviceProtocol?
    var comment: Article?
    let router: RouterProtocol?
    
    required init(view: DetailViewProtocol, networkService: NetworkService, router: RouterProtocol, comment: Article?) {
        self.view = view
        self.networkService = networkService
        self.comment = comment
        self.router = router
    }
    
    public func setComment() {
        self.view?.setCommentForView(comment: comment)
    }
}

