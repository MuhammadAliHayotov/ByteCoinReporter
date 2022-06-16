//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "F5F2ECAA-6D2C-4422-A36A-CC929C29E32A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //TODO:
        /*
         1. Create a URL
         2. Create a URLSession
         3. Give the session a task
         4. Start the Task
         */
        
        //Creating a URL
        if let url = URL(string: urlString){
            //Creatinga URL Session
            let session = URLSession(configuration: .default)
            //giving the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    //print(error!)
                    //if network issue or some other error, then process it in here according to our delegate
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //get the data in JSON format and pass it to parser
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoin(self, coin: coin)//use protocol
                    }
                }
            }
            
            //starting the task
            task.resume()
        }
        
    }
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do{
            //decode from JSON to Swift
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            let rate = decodedData.rate
            
            let coin = CoinModel(coinRate: rate)
            
            return coin

            
        } catch{
            //update error
            delegate?.didFailWithError(error: error)
            //in case of error return nil
            return nil
        }
    }
    
}
