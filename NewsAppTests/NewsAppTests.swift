//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Admin on 9/10/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNewsHeadlinesAvailable() {
        let promise = expectation(description: "Fetch top headlines")
        let url: String = "\(EndPoints.TopHeadline.path)\(EndPoints.Country.path)\(APIKey.ApiKey.rawValue)"
        Network.shared.fetchNewsHeadlines(urlByName: url,type: NewsModel.self) { (response,success,error) in
            XCTAssertNil(error)
            XCTAssertTrue(success == "True")
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testNoNewsHeadlinesAvailable() {
        let promise = expectation(description: "Failer to fetch top headlines")
        let url: String = "\(EndPoints.TopHeadline.path)\(EndPoints.Country.path)\(APIKey.ApiKey.rawValue)\("a")"
        Network.shared.fetchNewsHeadlines(urlByName: url,type: NewsModel.self) { (response,success,error) in
            XCTAssertTrue(success == "False")
            XCTAssertEqual("The operation couldn’t be completed. (No News error -101.)",
                           error?.localizedDescription)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
