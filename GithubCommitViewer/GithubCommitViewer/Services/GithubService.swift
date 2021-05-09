//
//  GithubService.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-06.
//

import Foundation

enum GithubService {
    case commitMedOpsRepo
    case commitPrivateRepo
    case commitRepoNotFound
    
}

extension GithubService: Service {
    var baseURL: String {
        return "https://api.github.com"
    }
    
    var endpointPath: String {
        switch self {
        case .commitMedOpsRepo:
            return "/repos/jaimin23/MedOps_iOS/commits"
        case .commitPrivateRepo:
            return "/repos/jaimin23/Angular-Tutorials/commits"
        case .commitRepoNotFound:
            return "/repos/jaimin23/dawjdiwdaid/commits"
        }
    }
    
    var paramters: [String : Any]? {
        return nil
    }
    
    var requestMethodType: RequestMethodType {
        switch self {
        case .commitMedOpsRepo:
            return .get
        case .commitPrivateRepo:
            return .get
        case .commitRepoNotFound:
            return .get
        }
    }
    
    
}
