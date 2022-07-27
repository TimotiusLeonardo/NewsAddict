//
//  CategoriesRouter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol ArticlesRouterDelegate: AnyObject {
    func dismiss(viewController: UIViewController?)
    func goToNextViewController(viewController: UIViewController?, nextViewController: UIViewController)
}

class ArticlesRouter: ArticlesRouterDelegate {
    static func createModule(source: String) -> ArticlesViewController {
        let view = ArticlesViewController()
        let presenter = ArticlesPresenter()
        let router = ArticlesRouter()
        let interactor = ArticlesInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.sourcesId = source
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func dismiss(viewController: UIViewController?) {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func goToNextViewController(viewController: UIViewController?, nextViewController: UIViewController) {
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
