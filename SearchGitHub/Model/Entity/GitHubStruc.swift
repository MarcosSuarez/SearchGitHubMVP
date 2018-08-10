//
//  GitHubModel.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 10/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

/// response struct of GitHub
struct GHSearchRepo: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [GHRepository]
}

/// repository structure
struct GHRepository: Codable {
    let name: String? // repository name
    let full_name: String? // "user login / repository name"
    let owner: GHOwner?
    let created_at: String? //"created_at": "2016-09-19T19:31:57Z",
    let updated_at: String? //"updated_at": "2016-09-19T19:35:15Z",
    let pushed_at: String?
    let language: String? //"language": "Swift"
    let html_url: String? // Repository Web
    let description: String?
    let has_projects: Bool?
}

struct GHOwner: Codable {
    let login: String? // User login
    let avatar_url: String? // URL user avatar
    let html_url: String? // User github Web
}
