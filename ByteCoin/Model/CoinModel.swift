//
//  CoinModel.swift
//  ByteCoin
//
//  Created by A253 on 16/06/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    
    let coinRate: Double
    
    var coinRateString: String {
        return String(format: "%.1f", coinRate)
    }
}
