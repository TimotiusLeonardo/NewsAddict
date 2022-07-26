//
//  CategoriesRouter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol DetailArticleRouterDelegate: AnyObject {
    func dismiss(viewController: UIViewController?)
}

class DetailArticleRouter: DetailArticleRouterDelegate {
    static func createModule(article: ArticlesDetail?) -> DetailArticleViewController {
        let view = DetailArticleViewController()
        let presenter = DetailArticlePresenter()
        let router = DetailArticleRouter()
        let interactor = DetailArticleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.articleDetail = article
        
        return view
    }
    
    func dismiss(viewController: UIViewController?) {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
