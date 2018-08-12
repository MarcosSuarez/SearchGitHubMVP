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
    
    init(withSearchTerm searchTerm:String, withFilter: GHFilters) {
        self.searchTerm = searchTerm
        self.filter = withFilter
    }
    
    func execute(completionHandler: @escaping ( ([DataClient]) -> Void ) ) {
        
        // Llama al servicio y espera su respuesta para propagarla
        let servicio = SearchService()
        
        servicio.search(searchTerm: searchTerm, filter: filter, completionHandler: { (transaction) in
            
            switch transaction {
                
            case .success(let data):
                if let dataUnwrapped:[DataClient] = data {
                    completionHandler(dataUnwrapped) }                
            case .fail:
                completionHandler([])
            }
        })
        
        /*
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
        */
    }
}
