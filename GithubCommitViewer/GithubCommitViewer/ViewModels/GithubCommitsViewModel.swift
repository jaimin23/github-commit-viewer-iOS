//
//  GithubCommitsViewModel.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-06.
//

import Foundation

protocol GithubCommitsViewModelType {
    func viewReady(completion: @escaping ([GitCommit]?) -> Void)
}

class GithubCommitsViewModel: GithubCommitsViewModelType {
    
    private var serviceProvider: ServiceProvider<GithubService>
    
    init(serviceProvider: ServiceProvider<GithubService>) {
        self.serviceProvider = serviceProvider
    }
    
    func viewReady(completion: @escaping ([GitCommit]?) -> Void) {
        serviceProvider.load(service: .commitMedOpsRepo, decodeType: [GitCommit].self) { result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error)
                completion(nil)
            case .empty:
                completion([])
            }
        }
    }
    
}
