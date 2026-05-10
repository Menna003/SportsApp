import XCTest
@testable import SportsApp

final class NetworkServiceTests: XCTestCase {

    var mockService: MockNetworkService!

    override func setUpWithError() throws {

        mockService = MockNetworkService()
    }

    override func tearDownWithError() throws {

        mockService = nil
    }

    // MARK: - Fetch Leagues Success

    func testFetchLeaguesSuccess() {

        let expectation = expectation(description: "Leagues Success")

        mockService.fetchLeagues(for: "football") { response in

            XCTAssertNotNil(response)
            XCTAssertEqual(response?.result.count, 1)
            XCTAssertEqual(
                response?.result.first?.leagueName,
                "Premier League"
            )

            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Fetch Leagues Failure

    func testFetchLeaguesFailure() {

        mockService.shouldReturnNil = true

        let expectation = expectation(description: "Leagues Failure")

        mockService.fetchLeagues(for: "football") { response in

            XCTAssertNil(response)

            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Upcoming Events

    func testFetchUpcomingEventsSuccess() {

        let expectation = expectation(description: "Upcoming Success")

        mockService.fetchUpcomingEvents(
            sport: "football",
            leagueId: 1
        ) { response in

            XCTAssertNotNil(response)

            XCTAssertEqual(
                response?.result.first?.homeTeam,
                "Liverpool"
            )

            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Latest Events

    func testFetchLatestEventsSuccess() {

        let expectation = expectation(description: "Latest Success")

        mockService.fetchLatestEvents(
            sport: "football",
            leagueId: 1
        ) { response in

            XCTAssertNotNil(response)

            XCTAssertEqual(
                response?.result.first?.homeTeam,
                "Barcelona"
            )

            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Teams

    func testFetchTeamsSuccess() {

        let expectation = expectation(description: "Teams Success")

        mockService.fetchTeams(
            sport: "football",
            leagueId: 1
        ) { response in

            XCTAssertNotNil(response)

            XCTAssertEqual(
                response?.result.first?.teamName,
                "Liverpool"
            )

            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Team Details

    func testFetchTeamDetailsSuccess() {

        let expectation = expectation(description: "Details Success")

        mockService.fetchTeamDetails(
            sport: "football",
            teamId: 1
        ) { response in

            XCTAssertNotNil(response)

            XCTAssertEqual(
                response?.result.first?.players?.count,
                1
            )

            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }
}