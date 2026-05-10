//
//  NetworkServiceTests.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import XCTest
@testable import SportsApp

final class NetworkServiceIntegrationTests: XCTestCase {

    var networkService: NetworkServiceProtocol!

    override func setUpWithError() throws {
        networkService = NetworkService.shared
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testFetchLeagues_ShouldReturnLeagues() {
        let expectation = expectation(description: "Leagues API Call")

        networkService.fetchLeagues(for: "football") { response in
            XCTAssertNotNil(response)
            XCTAssertFalse(response!.result.isEmpty)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeagues_Basketball_ShouldReturnLeagues() {
        let expectation = expectation(description: "Basketball Leagues")

        networkService.fetchLeagues(for: "basketball") { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeagues_Tennis_ShouldReturnLeagues() {
        let expectation = expectation(description: "Tennis Leagues")

        networkService.fetchLeagues(for: "tennis") { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeagues_Cricket_ShouldReturnLeagues() {
        let expectation = expectation(description: "Cricket Leagues")

        networkService.fetchLeagues(for: "cricket") { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchUpcomingEvents_ShouldReturnEvents() {
        let expectation = expectation(description: "Upcoming Events API Call")

        networkService.fetchUpcomingEvents(sport: "football", leagueId: 152) { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchUpcomingEvents_Basketball_ShouldReturnEvents() {
        let expectation = expectation(description: "Basketball Upcoming Events")

        networkService.fetchUpcomingEvents(sport: "basketball", leagueId: 1) { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }


    func testFetchLatestEvents_ShouldReturnEvents() {
        let expectation = expectation(description: "Latest Events API Call")

        networkService.fetchLatestEvents(sport: "football", leagueId: 152) { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLatestEvents_Tennis_ShouldReturnEvents() {
        let expectation = expectation(description: "Tennis Latest Events")

        networkService.fetchLatestEvents(sport: "tennis", leagueId: 1) { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchTeams_ShouldReturnTeams() {
        let expectation = expectation(description: "Teams API Call")

        networkService.fetchTeams(sport: "football", leagueId: 152) { response in
            XCTAssertNotNil(response)
            XCTAssertFalse(response!.result!.isEmpty)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchTeams_Basketball_ShouldReturnTeams() {
        let expectation = expectation(description: "Basketball Teams")

        networkService.fetchTeams(sport: "basketball", leagueId: 1) { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }


    func testFetchTeamDetails_ShouldReturnTeam() {
        let expectation = expectation(description: "Team Details API Call")

        networkService.fetchTeamDetails(sport: "football", teamId: 96) { response in
            XCTAssertNotNil(response)
            XCTAssertFalse(response!.result!.isEmpty)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchTeamDetails_ShouldContainPlayers() {
        let expectation = expectation(description: "Team Has Players")

        networkService.fetchTeamDetails(sport: "football", teamId: 96) { response in
            XCTAssertNotNil(response?.result?.first)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
}
