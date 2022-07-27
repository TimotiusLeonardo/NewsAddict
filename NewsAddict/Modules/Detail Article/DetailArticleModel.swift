//
//  CategoriesModel.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

class DetailArticleModel {
    let url: URL?
    
    init(articleDetail: ArticlesDetail?) {
        guard let articleDetail = articleDetail else {
            print("Nil article detail")
            url = nil
            return
        }
        url = URL(string: articleDetail.url ?? "https://www.google.com")
    }
}
