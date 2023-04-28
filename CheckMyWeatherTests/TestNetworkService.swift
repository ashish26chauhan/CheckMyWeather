//
//  CheckMyWeatherTests.swift
//  CheckMyWeatherTests
//
//  Created by Ashish Chauhan  on 23/04/2023.
//

import XCTest
@testable import CheckMyWeather

final class TestNetworkService: XCTestCase {

    func test_initNetworkService() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_addSingleParam() {
        var sut = makeSUT()
        let queryParam = ["key": "902da679f139474db46152610232404"]
        
        sut.addParams(params: queryParam)
        
        XCTAssertEqual(sut.urlPath, "https://api.weatherapi.com/v1/current.json?key=902da679f139474db46152610232404")
    }
    
    func test_addMultipleParams() {
        var sut = makeSUT()
        let queryParam = ["key": "902da679f139474db46152610232404",
                          "q":"London",
                          "aqi":"no"]
        
        sut.addParams(params: queryParam)
        let url = sut.urlPath
        let urlQueryParams = url?.components(separatedBy: "?").last
        let paramCount = urlQueryParams?.components(separatedBy: "&")
        
        XCTAssertEqual(3, paramCount?.count)
    }
    
    func test_networkRequestIsValidURLRequest() {
        let sut = makeSUT()
        let req = sut.urlRequest
        
        XCTAssertNotNil(req)
    }
    
    func test_APICall() {
        guard let request = makeRequestWithParams() else {
            XCTFail("Invalid request")
            return
        }
        
        guard let urlReq = request.urlRequest else {
            XCTFail("Invalid url request")
            return
        }
        
        let expectation = expectation(description: "API call")
        
        request.executeRequest(request: urlReq) { response, error in
            expectation.fulfill()
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
        
        wait(for: [expectation], timeout: 2)
        
    }
    
    //MARK:- Helpers
    func makeSUT() -> NetworkService {
        return NetworkService(urlPath: "https://api.weatherapi.com/v1/current.json", type: "GET")
    }
    
    func makeRequestWithParams() -> NetworkService? {
        var req = makeSUT()
        let queryParam = ["key": "902da679f139474db46152610232404",
                          "q":"London",
                          "aqi":"no"]

        req.addParams(params: queryParam)

        return req
    }
}
