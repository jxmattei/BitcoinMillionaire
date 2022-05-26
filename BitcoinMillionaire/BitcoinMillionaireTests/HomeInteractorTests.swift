//
//  HomeInteractorTests.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 26/05/22.
//

import XCTest
@testable import BitcoinMillionaire

class HomeInteractorTests: XCTestCase {

    var systemUnderTest: HomeInteractor!
    var homePresenter: HomePresenterProtocol!
    var homeRouter: HomeRouterProtocol!
    var bitcoinPriceService: BitcoinPriceServiceProtocol!
    var userBitcoinService: UserBitcoinServiceProtocol!

    override func setUpWithError() throws {
        let dataBaseService = DatabaseService()
        let bitcoinPriceService = MockBitcoinPriceService()
        systemUnderTest = HomeInteractor(with: bitcoinPriceService, userBitcoinService: UserBitcoinService(database: dataBaseService))
        homeRouter = MockHomeRouter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeInteractor_WhenIntialized_BitCoinPriceServiceIsPresent() throws {
        XCTAssertTrue(systemUnderTest.bitcoinPriceService != nil)
    }
    
    func testHomeInteractor_WhenIntialized_UserBitcoinServiceIsPresent() throws {
        XCTAssertTrue(systemUnderTest.userBitcoinService != nil)
    }
    
    func testHomeInteractor_WhenCheckLatestBitcoinPriceIsCalled_BitcoinPriceServiceIsCalledToCheckPriceOnline() {
        let _ = systemUnderTest.checkLatestBitcoinPrice()
        if let bitcoinPriceService = bitcoinPriceService as? MockBitcoinPriceService {
            XCTAssertTrue(bitcoinPriceService.latestPriceFromPriceServiceIsCalled)
        }
    }
    
    func testHomeInteractor_WhenCheckBitcoinPriceFromDatabaseIsCalled_BitcoinPriceServiceIsCalledToCheckPriceInDatabase() {
        let _ = systemUnderTest.checkLatestPriceFromDataBase()
        if let bitcoinPriceService = bitcoinPriceService as? MockBitcoinPriceService {
            XCTAssertTrue(bitcoinPriceService.latestPriceFromDatabaseIsCalled)
        }
    }
}
