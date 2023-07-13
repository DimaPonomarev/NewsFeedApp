//
//  MainPresenter.swift
//  NewsFeedApp
//
//  Created by Дмитрий Пономарев on 13.07.2023.
//


import Foundation

protocol MainViewProtocol: AnyObject {
    func sendModelToViewController()
    func sendFailureToViewController(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, network: NetworkerviceProtocol, router: RouterProtocol)
    func getCommentsFromCashe()
    var comments: [Article]? { get set }
    func tapOnComment(indexPath: Int)
    var someValue: Int? { get set }
}

class MainPresenter:MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let network: NetworkerviceProtocol?
    var comments: [Article]?
    var router: RouterProtocol?
    var someValue: Int?
    
    
    required init(view: MainViewProtocol, network: NetworkerviceProtocol, router: RouterProtocol) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func tapOnComment(indexPath: Int) {
        self.comments?[indexPath].number? += 1
        let model = self.comments?[indexPath]
        router?.showDetail(comment: model)
        someValue = model?.number
    }
    
    func sendedModelForMainView(model: [Article]) {
        var modeltest = model
        for (index,_) in modeltest.enumerated() {
            modeltest[index].number = 0
        }
        self.comments = modeltest
        self.view?.sendModelToViewController()
        UserDefaults.standard.set(try? PropertyListEncoder().encode(modeltest), forKey:"news")
    }
    
    func getCommentsFromCashe(){
        network?.getCommentsFromCashe(completion: { [weak self] result  in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case.success(let comments):
                    self.sendedModelForMainView(model: comments!)
                case.failure(let error):
                    self.view?.sendFailureToViewController(error: error)
                }
            }
        })
    }
}

