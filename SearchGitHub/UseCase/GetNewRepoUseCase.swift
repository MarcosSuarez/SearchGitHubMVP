//
//  GetNewRepoUsedCase.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 8/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

class GetNewRepoUseCase {
    
    private let searchTerm:String
    private let filter:GHFilters
    
    init(withSearchTerm searchTerm:String, withFilter: GHFilters) {
        self.searchTerm = searchTerm
        self.filter = withFilter
    }
    
    func execute(completionHandler: @escaping ( ([DataClient]) -> Void ) ) {
        
        var repos = [DataClient]()
        
        APIGitHub.shared.resetPagination()
        
        APIGitHub.shared.search(byText: searchTerm, filter: filter) { (nextRepositories) in

            print("total nuevos repositorios Agregados: ", nextRepositories.count)
            
            nextRepositories.forEach({ (repository) in
                let data = DataClient(with: repository)
                repos.append(data)
            })
            
            print("TOTAL repositorios en móvil: ",repos.count)
            
            completionHandler(repos)
        }
    }
}
