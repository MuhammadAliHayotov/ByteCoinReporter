//
//  CoinData.swift
//  ByteCoin
//
//  Created by A253 on 16/06/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coinData = try? newJSONDecoder().decode(CoinData.self, from: jsonData)

import Foundation

// MARK: - CoinData
struct CoinData: Codable {
    let time, assetIDBase, assetIDQuote: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}
