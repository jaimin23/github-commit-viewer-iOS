//
//  GithubCommitViewModelTests.swift
//  GithubCommitViewerTests
//
//  Created by Jaimin Patel on 2021-05-08.
//

import XCTest
@testable import GithubCommitViewer

class GithubCommitViewModelTests: XCTestCase {
    
    var githubCommitsViewModel: GithubCommitsViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        githubCommitsViewModel = GithubCommitsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        githubCommitsViewModel = nil
    }

    func testViewModelViewReady() throws {
        githubCommitsViewModel?.viewReady { ready in
            XCTAssertEqual(ready, true)
        }
    }
    
    func testViewModelCount() throws {
        githubCommitsViewModel?.viewReady { ready in
            let commitCount = self.githubCommitsViewModel?.commitCount
            XCTAssertEqual(commitCount, 30)
        }
    }
    
    func testViewModelCommitAt() throws {
        githubCommitsViewModel?.viewReady { _ in
            guard let commitCount = self.githubCommitsViewModel?.commitCount else {
                return
            }
            for index in 0..<commitCount {
                let commit = self.githubCommitsViewModel?.commitAt(index: index)
                XCTAssertNotNil(commit)
            }
            
        }
    }
    
    func testCommitObjectData() throws {
        //First object in API should be the following:
        /**
         "sha": "5e063de94d3bda3a4e6fc6d574294a0afa6cfb94",
         "commit": {
         "author": {
         "name": "Jaimin Patel",
         }
         "message": "Create README.md",
         */
        githubCommitsViewModel?.viewReady { ready in
            let firstCommit = self.githubCommitsViewModel?.commitAt(index: 0)
            XCTAssertNotNil(firstCommit)
            XCTAssertEqual(firstCommit?.commitHash, "5e063de94d3bda3a4e6fc6d574294a0afa6cfb94")
            XCTAssertEqual(firstCommit?.commitInfo?.author?.name, "Jaimin Patel")
            XCTAssertEqual(firstCommit?.commitInfo?.message, "Create README.md")
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
