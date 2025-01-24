//
//  WeatherAPIServiceTests.swift
//  WeatherAppTests
//
//  Created by Nazar Kozak on 22.01.2025.
//

import Foundation
import XCTest
@testable import WeatherApp

final class WeatherAPIServiceTests: XCTestCase {

    private var mockClient: NetworkClientMock!
    private var weatherService: WeatherAPIServiceImpl!

    override func setUp() {
        super.setUp()

        mockClient = NetworkClientMock(baseURL: "https://fakeurl.com")
        weatherService = WeatherAPIServiceImpl(networkClient: mockClient, apiKey: "test-api-key")
    }

    override func tearDown() {
        mockClient = nil
        weatherService = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testCurrentWeather_Success() async {
        mockClient.shouldSucceed = true
        mockClient.mockData = Weather.mock

        let result = await weatherService.current("New York")

        switch result {
        case .success(let weather):
            XCTAssertEqual(weather, Weather.mock)
        case .failure(let error):
            XCTFail("Expected success, but got failure: \(error)")
        }
    }

    func testCurrentWeather_Failure() async {
        mockClient.shouldSucceed = false

        let result = await weatherService.current("Paris")

        switch result {
        case .success(let weather):
            XCTFail("Expected failure, but got success with \(weather)")
        case .failure(let error):
            XCTAssertNotNil(error, "Expected a failing scenario")
        }
    }

    func testSearchWeather_Success() async {
        mockClient.shouldSucceed = true
        mockClient.mockData = [WeatherLocation.mock]

        let result = await weatherService.search("Kyiv")

        switch result {
        case .success(let locations):
            XCTAssertFalse(locations.isEmpty, "Expected at least one location")
            XCTAssertEqual(locations.count, 1)
            XCTAssertEqual(locations.first, WeatherLocation.mock)
        case .failure:
            XCTFail("Expected success, but got failure.")
        }
    }

    func testSearchWeather_Failure() async {
        mockClient.shouldSucceed = false

        let result = await weatherService.search("Oslo")

        switch result {
        case .success(let locations):
            XCTFail("Expected failure, but got success with: \(locations)")
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
}
