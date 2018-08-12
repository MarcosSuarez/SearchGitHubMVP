//
//  SearchService.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 10/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

protocol SearchServiceProtocol {
    
    func search(searchTerm: String, filter: GHFilters, completionHandler: @escaping ((Transaction<[DataClient]?>) -> Void) )
    
    func nextPage(page: String, filter: GHFilters, completionHandler: @escaping (([DataClient]) -> Void))
}

class SearchService {
    init() { }
}

extension SearchService: SearchServiceProtocol {
    
    func search(searchTerm: String, filter: GHFilters, completionHandler: @escaping ((Transaction<[DataClient]?>) -> Void)) {
       
        let repository = RepositoryNetwork()
        
        repository.textSearch = searchTerm
        repository.filter = filter
        
        repository.get { (transaccionResult) in
            completionHandler(transaccionResult)
        }
        
    }
    
    
    func nextPage(page: String, filter: GHFilters, completionHandler: @escaping (([DataClient]) -> Void)) {
        
    }
}
