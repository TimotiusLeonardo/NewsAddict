//
//  CategoriesRouter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol SourcesRouterDelegate: AnyObject {
    func dismiss(viewController: UIViewController?)
    func goToNextViewController(viewController: UIViewController?, nextViewController: UIViewController)
}

class SourcesRouter: SourcesRouterDelegate {
    static func createModule(category: String) -> SourcesViewController {
        let view = SourcesViewController()
        let presenter = SourcesPresenter()
        let router = SourcesRouter()
        let interactor = SourcesInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.category = category
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
