//
//  Commit.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-06.
//

import Foundation

struct GitCommit: Decodable {
    let commitHash: String?
    let commitInfo: CommitInfo?
    
    private enum CodingKeys: String, CodingKey {
        case commitHash = "sha"
        case commitInfo = "commit"
    }
}

struct CommitInfo: Decodable {
    let author: Author?
    let message: String?
}

struct Author: Decodable {
    let name: String?
}
