//
//  CategoriesModel.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

struct ArticlesModel: Codable {
    let status: String
    let totalResults: Int
    var articles: [ArticlesDetail]
}

struct ArticlesDetail: Codable {
    let source: ArticleSourceDetail
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct ArticleSourceDetail: Codable {
    let id: String?
    let name: String?
}
