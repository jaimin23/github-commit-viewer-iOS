//
//  GithubCommitViewModelTests.swift
//  GithubCommitViewerTests
//
//  Created by Jaimin Patel on 2021-05-08.
//

import XCTest
@testable import GithubCommitViewer

class GithubCommitViewModelTests: XCTestCase {
    
    enum ResultType {
        case success
        case error
        case empty
    }
    
    var githubCommitsViewModel: GithubCommitsViewModelType!

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        githubCommitsViewModel = nil
    }
    
    func configureViewModel(resultType: ResultType =  .success) {
        switch resultType {
        case .success:
            githubCommitsViewModel = MockSuccessGithubCommitViewModel() as? GithubCommitsViewModelType
        case .error:
            githubCommitsViewModel = MockErrorGithubCommitsViewModel() as? GithubCommitsViewModelType
        case .empty:
            githubCommitsViewModel = MockEmptyGithubCommitViewModel() as? GithubCommitsViewModelType
        }
    }

    func testViewModelViewReady() throws {
        configureViewModel()
        githubCommitsViewModel.viewReady { commitList in
            XCTAssertNotNil(commitList)
        }
    }
    
    func testViewModelViewReadyEmpty() throws {
        configureViewModel(resultType: .empty)
        githubCommitsViewModel.viewReady { commitList in
            guard let commitList = commitList else {
                XCTFail("No commits found")
                return
            }
            XCTAssertEqual(commitList.count, 0)
        }
    }
    
    func testViewModelCount() throws {
        configureViewModel()
        githubCommitsViewModel.viewReady { commitList in
            guard let commitList = commitList else {
                XCTFail("No commits found")
                return
            }
            let commitCount = commitList.count
            XCTAssertEqual(commitCount, 4)
        }
    }
    
    func testViewModelReadyError() throws {
        configureViewModel(resultType: .error)
        githubCommitsViewModel.viewReady { commitList in
            XCTAssertNil(commitList)
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
        configureViewModel()
        githubCommitsViewModel.viewReady { commitList in
            guard let commitList = commitList else {
                XCTFail("No commits found")
                return
            }
            guard let firstCommit = commitList.first else {
                XCTFail("No commit found")
                return
            }
            XCTAssertNotNil(firstCommit)
            XCTAssertEqual(firstCommit.commitHash, "5e063de94d3bda3a4e6fc6d574294a0afa6cfb94")
            XCTAssertEqual(firstCommit.commitInfo?.author?.name, "Jaimin Patel")
            XCTAssertEqual(firstCommit.commitInfo?.message, "Create README.md")
            
        }
    }
}
