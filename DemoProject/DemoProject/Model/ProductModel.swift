//
//  ProductModel.swift
//  DemoProject
//
//  Created by BeLocum-6 on 23/04/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import Foundation

struct ProductMain_Model : Codable {
    let products : [Products]?
    let total : Int?
    let skip : Int?
    let limit : Int?

    enum CodingKeys: String, CodingKey {

        case products = "products"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        skip = try values.decodeIfPresent(Int.self, forKey: .skip)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
    }

}

struct Products : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let price : Int?
    let discountPercentage : Double?
    let rating : Double?
    let stock : Int?
    let brand : String?
    let category : String?
    let thumbnail : String?
    let images : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case rating = "rating"
        case stock = "stock"
        case brand = "brand"
        case category = "category"
        case thumbnail = "thumbnail"
        case images = "images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        discountPercentage = try values.decodeIfPresent(Double.self, forKey: .discountPercentage)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        stock = try values.decodeIfPresent(Int.self, forKey: .stock)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        images = try values.decodeIfPresent([String].self, forKey: .images)
    }

}
