//
//  ModeloGH.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 10/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation


protocol SearchGitHubModelProtocol {
    
    func search(termSearch: String, filter: GHFilters, completionHandler: @escaping (Transaction<DataClient?>) -> () )
}

class SearchGitHubModel: Model {
    
    
    typealias NET = RepositoryNetwork
    typealias T = [DataClient] // la estructura que utiliza el presentador
    typealias R = Bool
    
    var network: RepositoryNetwork
    
    init(network: RepositoryNetwork) {
        self.network = network
    }

    func get(termSearch: String, filter: GHFilters, completionHandler: @escaping (Transaction<[DataClient]?>) -> ()) {
        self.network.textSearch = termSearch
        self.network.filter = filter
        self.network.get(completionHandler: completionHandler)
    }
    
    func set(element: [DataClient], completionHandler: @escaping (Transaction<Bool?>) -> ()) {
        completionHandler(Transaction.fail(.Unknown))
    }
    
    func clear() {
        print("Clean")
    }
    
}

extension SearchGitHubModel: SearchGitHubModelProtocol {
    
    func search(termSearch: String, filter: GHFilters, completionHandler: @escaping (Transaction<DataClient?>) -> ()) {
        network.filter = filter
        network.textSearch = termSearch
        completionHandler(Transaction.fail(.Unknown))
    }
}
