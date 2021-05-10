//
//  MockGithubCommitsViewModel.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-09.
//

import Foundation


class MockErrorGithubCommitsViewModel: GithubCommitsViewModelType {
    
    func viewReady(completion: @escaping ([GitCommit]?) -> Void) {
        completion(nil)
    }
    
}


class MockSuccessGithubCommitViewModel: GithubCommitsViewModelType {
    
    func viewReady(completion: @escaping ([GitCommit]?) -> Void) {
        let commitList:[GitCommit] = [
            GitCommit(commitHash: "5e063de94d3bda3a4e6fc6d574294a0afa6cfb94", commitInfo: CommitInfo(author:Author(name: "Jaimin Patel"), message: "Create README.md")),
            GitCommit(commitHash: "simpleahdwhda", commitInfo: CommitInfo(author:Author(name: "Test User"), message: "Test test")),
            GitCommit(commitHash: "simpleahdwhda", commitInfo: CommitInfo(author:Author(name: "Test User"), message: "Test test")),
            GitCommit(commitHash: "simpleahdwhda", commitInfo: CommitInfo(author:Author(name: "Test User"), message: "Test test"))
        ]
        completion(commitList)
    }
}

class MockEmptyGithubCommitViewModel: GithubCommitsViewModelType {
    
    func viewReady(completion: @escaping ([GitCommit]?) -> Void) {
        let commitList:[GitCommit] = []
        completion(commitList)
    }
}
