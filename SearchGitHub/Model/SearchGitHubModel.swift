//
//  ModeloGH.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 10/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation


protocol SearchGitHubModelProtocol {

    var network: RepositoryNetwork {get set}
    
    func get(termSearch: String, filter: GHFilters, completionHandler: @escaping (Transaction<[DataClient]?>) -> () )
}

class SearchGitHubModel {
    
    var network: RepositoryNetwork
    
    init(repository: RepositoryNetwork) {
        self.network = repository
    }
}

extension SearchGitHubModel: SearchGitHubModelProtocol {

    func get(termSearch: String, filter: GHFilters, completionHandler: @escaping (Transaction<[DataClient]?>) -> ()) {
       
        self.network.filter = filter
        self.network.textSearch = termSearch
        
        self.network.get { (transaction) in
            completionHandler(transaction)
        }
    }
}
