//
//  Assembly.swift
//  NewsFeedApp
//
//  Created by Дмитрий Пономарев on 13.07.2023.
//


import UIKit

protocol AssemblerBuilderProtocol {
    func creatMainModule(router:RouterProtocol) -> UIViewController
    func creatDetailModule(comment:Article?, router:RouterProtocol) -> UIViewController
}

final class MainAssembly:AssemblerBuilderProtocol {
    func creatMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, network: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func creatDetailModule(comment: Article?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
        view.presenter = presenter
        return view
    }
}
