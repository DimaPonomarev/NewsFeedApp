//
//  Router.swift
//  MVPModel
//
//  Created by Дмитрий Пономарев on 31.01.2023.
//

import UIKit

protocol MainRouter {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblerBuilderProtocol? {get set}
}

protocol RouterProtocol: MainRouter {
    func initialViewController ()
    func showDetail(comment:Article?)    
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblerBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.creatMainModule(router: self) else {return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(comment: Article?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.creatDetailModule(comment: comment, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
