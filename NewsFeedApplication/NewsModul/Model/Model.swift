//
//  Model.swift
//  MVPModel
//
//  Created by Дмитрий Пономарев on 28.01.2023.
//

import UIKit

struct Comment: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String
    let url: String
    var urlToImage: String?
    var publishedAt: String
    let content: String
    var imageData: Data? = nil
    var number: Int?

}

struct Source: Codable {
    let name: String
}
