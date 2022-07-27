//
//  CategoriesInteractor.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

protocol DetailArticleInteractorDelegate: AnyObject {
    func getArticleData() -> DetailArticleModel
}

class DetailArticleInteractor: DetailArticleInteractorDelegate {
    var presenter: DetailArticleInteractorToPresenterDelegate?
    var articleDetail: ArticlesDetail?
    
    func getArticleData() -> DetailArticleModel {
        DetailArticleModel(articleDetail: articleDetail)
    }
}
