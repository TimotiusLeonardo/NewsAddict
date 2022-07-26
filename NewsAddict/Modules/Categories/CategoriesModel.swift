//
//  CategoriesModel.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

struct CategoriesModel {
    enum Name: String {
        case business = "Business"
        case entertainment = "Entertainment"
        case general = "General"
        case health = "Health"
        case science = "Science"
        case sports = "Sports"
        case technology = "Technology"
    }
    
    let name: Name
    
    static func getCategoriesData() -> [CategoriesModel] {
        [
            .init(name: .business),
            .init(name: .entertainment),
            .init(name: .general),
            .init(name: .health),
            .init(name: .science),
            .init(name: .sports),
            .init(name: .technology)
        ]
    }
}
