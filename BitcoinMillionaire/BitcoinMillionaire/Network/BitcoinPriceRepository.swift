//
//  BitcoinPriceRepository.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation
import Combine


class BitcoinPriceRepository : Repository {
    
    func readLatest() -> AnyPublisher<BitcoinPrice,Error> {
        let webService = WebService()
        return webService.get(endpoint: Endpoint.getLatestBitcoinPrice, responseType: APIResponse.self)
            .map({
                $0.bpi.bitcoinPrice
                
            })
            .eraseToAnyPublisher() 
    }
    
    func readLatestFromDataBase() -> AnyPublisher<Double,Error> {
        return BitcoinUserDefaults().defaults
            .publisher(for: \.keyBitcoinPrice)
            .handleEvents(receiveOutput: { bitcoinPrice in
                print("Price in Database: \(bitcoinPrice)")
            }).setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
