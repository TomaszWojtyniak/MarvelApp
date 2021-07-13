//
//  MarvelModel.swift
//  MarvelApp
//
//  Created by Tomasz Wojtyniak on 13/07/2021.
//

import Foundation
import UIKit

struct APIResponse: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML:String
    let etag: String
    let data: Data
}

struct Data: Codable {
    let count: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let title: String
    let description: String?
    let images: [Image]?
    let creators: Creator
}

struct Creator: Codable {
    let items: [Item]?
    let available: Int
}

struct Item: Codable{
    let name: String
    let role: String
}

struct Image: Codable {
    let path: String
    let `extension`: String
}






public class ComicBook {
    public var title: String
    public var creators: String
    public var image: UIImage
    public var description: String
    public var authorName: String
    public var authorRole: String
    public var imagePath: String
    public var imageExtension: String
    
    public init(title: String,
                creators: String,
                image: UIImage,
                description: String,
                authorName: String,
                authorRole: String,
                imagePath: String,
                imageExtension: String) {
        self.title = title
        self.creators = creators
        self.image = image
        self.description = description
        self.authorName = authorName
        self.authorRole = authorRole
        self.imagePath = imagePath
        self.imageExtension = imageExtension
    }
    
}

