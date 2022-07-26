//
//  CategoriesModel.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

struct SourcesModel: Codable {
    let status: String
    let sources: [SourcesDetail]
}

struct SourcesDetail: Codable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}
