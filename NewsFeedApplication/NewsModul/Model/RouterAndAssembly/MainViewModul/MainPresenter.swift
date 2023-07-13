//
//  MainPresenter.swift
//  MVPModel
//
//  Created by Дмитрий Пономарев on 28.01.2023.
//


import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, network: NetworkerviceProtocol, router: RouterProtocol)
    func getCommments()
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
        getcommentsOfline()
        getCommments()
    }
    
    func tapOnComment(indexPath: Int) {
        self.comments?[indexPath].number? += 1
        let model = self.comments?[indexPath]
        router?.showDetail(comment: model)
        someValue = model?.number
    }
    
    func setupModelTest(model: [Article]) {
        var modeltest = model
        for (index,_) in modeltest.enumerated() {
            modeltest[index].number = 0
        }
        self.comments = modeltest
        self.view?.succes()
        UserDefaults.standard.set(try? PropertyListEncoder().encode(modeltest), forKey:"songS")
    }
    
    func getCommments() {
        network?.getcomments(completion: { [weak self] result  in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case.success(let comments):
                    self.setupModelTest(model: comments!)
                case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
        )
    }
    
    func getcommentsOfline(){
        network?.getCommentsofline(completion: { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case.success(let comments):
                self.setupModelTest(model: comments!)
            case.failure(let error):
                self.view?.failure(error: error)
            }
        }
        )
    }
}


//????????????
