//
//  Injectors.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 17/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

class Injectors {
    
    static let share = Injectors()
    
    private let repo:RepositoryNetwork
    private let model:SearchGitHubModel
    let service:SearchService
    
    init() {
        self.repo = RepositoryNetwork()
        self.model = SearchGitHubModel(repository: repo)
        self.service = SearchService(modelo: model)
    }
}



