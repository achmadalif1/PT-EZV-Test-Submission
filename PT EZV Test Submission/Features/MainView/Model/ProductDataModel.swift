//
//  ProductDataModel.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import Foundation

// MARK: - ProductDataModel
struct ProductDataModel: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
}


