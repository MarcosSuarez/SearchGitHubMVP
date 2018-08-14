//
//  GetNewRepoUsedCase.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 8/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

class UseCaseGetNewRepo {
    
    private let searchTerm:String
    private let filter:GHFilters
    private let service: SearchServiceProtocol
    
    init(withServiceSearch: SearchServiceProtocol ,withSearchTerm searchTerm:String, withFilter: GHFilters) {
        self.service = withServiceSearch
        self.searchTerm = searchTerm
        self.filter = withFilter
    }
    
    func execute(completionHandler: @escaping ( ([DataClient]) -> Void ) ) {
        
        // Llama al servicio para pedir información.
        service.search(searchTerm: searchTerm, filter: filter, completionHandler: { (transaction) in
            
            // Envía la información al presenter.
            switch transaction
            {
            case .success(let data):
                if let dataUnwrapped:[DataClient] = data {
                    completionHandler(dataUnwrapped) }                
            case .fail:
                completionHandler([])
            }
        })
    }
}
