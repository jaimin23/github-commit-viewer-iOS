//
//  GithubCommitsViewModel.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-06.
//

import Foundation

class GithubCommitsViewModel {
    
    private var commitsList: [GitCommit] = []
    private var serviceProvider = ServiceProvider<GithubService>()
    
    init() {}
    
    var commitCount: Int {
        return commitsList.count
    }
    
    func viewReady(completion: @escaping (Bool) -> Void) {
        serviceProvider.load(service: .commitMedOpsRepo, decodeType: [GitCommit].self) { result in
            switch result {
            case .success(let response):
                self.commitsList = response
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            case .empty:
                completion(false)
            }
        }
    }
    
    func commitAt(index: Int) -> GitCommit {
        return commitsList[index]
    }
}
