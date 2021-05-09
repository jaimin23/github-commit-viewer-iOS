//
//  GithubCommitServiceTests.swift
//  GithubCommitViewerTests
//
//  Created by Jaimin Patel on 2021-05-08.
//

import XCTest
@testable import GithubCommitViewer

class GithubCommitServiceTests: XCTestCase {
    
    var serviceProvider: ServiceProvider<GithubService>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceProvider = ServiceProvider<GithubService>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        serviceProvider = nil
    }
    
    func testSuccessAPICall() throws {
        serviceProvider.load(service: .commitMedOpsRepo, decodeType: [GitCommit].self) { result in
            switch result {
                case .success(let commits):
                    XCTAssertNotNil(commits)
                default: break
            }
        }
    }
    
    func testInvalidRepoAPICall() throws {
        serviceProvider.load(service: .commitMedOpsRepo, decodeType: [GitCommit].self) { result in
            switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .repoNotFound)
                default: break
            }
        }
    }
    
    func testPrivateRepoAIPCall() throws {
        serviceProvider.load(service: .commitMedOpsRepo, decodeType: [GitCommit].self) { result in
            switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .repoNotFound)
                default: break
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
