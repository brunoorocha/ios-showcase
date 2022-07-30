//
//  FeaturedTVShowsRepositoryTests.swift
//  ios-showcaseTests
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import XCTest
@testable import ios_showcase

final class MockNetworking: Networking {
    private(set) var receivedRequest: URLRequest?
    private(set) var receivedCompletion: ((Result<Data?, NetworkingError>) -> Void)?

    func request(_ request: URLRequest, completion: @escaping (Result<Data?, NetworkingError>) -> Void) -> DataTask {
        receivedRequest = request
        receivedCompletion = completion
        return FakeDataTask()
    }

    func succeeding(with data: Data?) {
        receivedCompletion?(.success(data))
    }
    
    func failing(with error: NetworkingError) {
        receivedCompletion?(.failure(error))
    }
}

final class ApiFeaturedTVShowsRepositoryTests: XCTestCase {
    var sut: ApiFeaturedTVShowsRepository!
    var mockNetworking: MockNetworking!

    override func setUpWithError() throws {
        mockNetworking = MockNetworking()
        sut = ApiFeaturedTVShowsRepository(networkingService: mockNetworking)
    }
    
    func testCompletion_WhenNetworkingCompletesWithSuccess_ShouldCompleteWithSuccess() {
        let expectation = XCTestExpectation(description: "expected to complete with success")
        
        sut.list { result in
            guard case .success = result else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }
        mockNetworking.succeeding(with: TVShow.fakeDataResponse)

        wait(for: [expectation], timeout: 1)
    }
    
    func testCompletion_WhenDataIsNil_ShouldCompleteWithAnEmptyArray() {
        let expectation = XCTestExpectation(description: "expected to complete with an empty array")
        var receivedShows: [TVShow]?

        sut.list { result in
            guard case .success(let shows) = result else {
                XCTFail()
                return
            }
            receivedShows = shows
            expectation.fulfill()
        }
        mockNetworking.succeeding(with: nil)

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(receivedShows?.count, 0)
    }
    
    func testCompletion_WhenDataIsNotInTheRightFormat_ShouldCompleteWithUnableToDecodeError() {
        let expectation = XCTestExpectation(description: "expected to complete with unable to decode error")

        sut.list { result in
            guard case .failure(let error) = result, case .unableToDecodeResponse = error else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }
        mockNetworking.succeeding(with: TVShow.fakeWrongDataResponse)

        wait(for: [expectation], timeout: 1)
    }
    
    
    func testCompletion_WhenNetworkCompleteWithError_ShouldCompleteWithUnknownError() {
        let expectation = XCTestExpectation(description: "expected to complete with unknown error")
        let expectedError = NetworkingError.notFound

        sut.list { result in
            guard case .failure(let error) = result, case .unknown = error else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }
        mockNetworking.failing(with: expectedError)

        wait(for: [expectation], timeout: 1)
    }
    
    func testCompletion_WhenMakeRequest_ShouldDoWithRightEndpoint() {
        sut.list { _ in }
        let urlRequest = mockNetworking.receivedRequest
        XCTAssertEqual(urlRequest?.url, URL(string: TVMazeEndpoint.allShows))
    }
}

extension TVShow {
    static var fakeDataResponse: Data {
        """
        [
            {
                "id": 250,
                "name": "Kirby Buckets",
                "genres": [
                    "Comedy"
                ],
                "image": {
                    "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg",
                    "original": "https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg"
                },
                "summary": "<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>",
            },
            {
                "id": 1,
                "name": "Under the Dome",
                "genres": [
                    "Drama",
                    "Science-Fiction",
                    "Thriller"
                ],
                "image": {
                    "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                    "original": "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
                },
                "summary": "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>",
            },
        ]
        """.data(using: .utf8)!
    }
    
    static var fakeWrongDataResponse: Data {
        """
        [
            {
                "id": 250,
                "name": "Kirby Buckets",
                "image": {
                    "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg",
                    "original": "https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg"
                },
                "summary": "<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>",
            }
        ]
        """.data(using: .utf8)!
    }
}
