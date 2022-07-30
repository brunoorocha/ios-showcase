//
//  NetworkingTests.swift
//  ios-showcaseTests
//
//  Created by Bruno Rocha da Silva on 29/07/22.
//

import XCTest
@testable import ios_showcase

struct FakeDataTask: DataTask {
    func resume() {}
    func cancel() {}
}

final class MockURLSession: URLSessionable {
    private(set) var receivedRequest: URLRequest?
    var urlResponse: HTTPURLResponse?
    var responseData: Data?

    @discardableResult
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask {
        receivedRequest = request
        completionHandler(responseData, urlResponse, nil)
        return FakeDataTask()
    }
}

final class NetworkingTests: XCTestCase {
    var sut: URLSessionNetworking!
    var mockSession: MockURLSession!

    override func setUpWithError() throws {
        mockSession = MockURLSession()
        sut = URLSessionNetworking(session: mockSession)
    }
    
    func testNetworking_WhenSessionCompletesWithStatusCode400_shouldCompleteWithBadRequestError() {
        let expectation = XCTestExpectation(description: "expect to complete with bad request error")
        mockSession.urlResponse = .with(statusCode: 400)
        sut.request(.mock()) { result in
            guard case .failure(let error) = result, case .badRequest = error else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testNetworking_WhenSessionCompletesWithStatusCode401_shouldCompleteWithUnauthorizedError() {
        let expectation = XCTestExpectation(description: "expect to complete with unauthorized error")
        mockSession.urlResponse = .with(statusCode: 401)
        sut.request(.mock()) { result in
            guard case .failure(let error) = result, case .unauthorized = error else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testNetworking_WhenSessionCompletesWithStatusCode404_shouldCompleteWithNotFoundError() {
        let expectation = XCTestExpectation(description: "expect to complete with not found error")
        mockSession.urlResponse = .with(statusCode: 404)
        sut.request(.mock()) { result in
            guard case .failure(let error) = result, case .notFound = error else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testNetworking_WhenSessionCompletesWithStatusCode500_shouldCompleteWithServerError() {
        let expectation = XCTestExpectation(description: "expect to complete with server error")
        mockSession.urlResponse = .with(statusCode: 500)
        sut.request(.mock()) { result in
            guard case .failure(let error) = result, case .server = error else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testNetworking_WhenSessionCompletesWithStatusCode429_shouldCompleteWithUnknownError() {
        let expectation = XCTestExpectation(description: "expect to complete with unknown error")
        let expectedStatusCode = 429
        mockSession.urlResponse = .with(statusCode: expectedStatusCode)
        sut.request(.mock()) { result in
            guard case .failure(let error) = result, case .unknown(let statusCode) = error, case statusCode = expectedStatusCode else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testNetworking_WhenSessionCompletesWithData_shouldCompleteWithSuccess() {
        let expectation = XCTestExpectation(description: "expect to complete with success")
        let expectedData = Data()
        mockSession.responseData = expectedData
        sut.request(.mock()) { result in
            guard case .success(let data) = result, case data = expectedData else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}

extension HTTPURLResponse {
    static func with(url: URL = .anyValidUrl, statusCode: Int = 200) -> HTTPURLResponse {
        return .init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: [:])!
    }
}

extension URLRequest {
    static func mock() -> URLRequest {
        return .init(url: .anyValidUrl)
    }
}

extension URL {
    static var anyValidUrl: URL {
        return URL(string: "https://google.com")!
    }
}
