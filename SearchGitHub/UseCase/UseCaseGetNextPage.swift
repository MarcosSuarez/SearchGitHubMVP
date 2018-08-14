//
//  GetReposUseCase.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 8/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

class UseCaseGetNextPage {
    
    private let service: SearchServiceProtocol
    
    init(withServiceSearch: SearchServiceProtocol) {
        self.service = withServiceSearch
    }
    
    func execute(completionHandler: @escaping ([DataClient]) -> Void ) {
        
        // Llama al servicio SearchService y la respuesta la propaga.
        
        service.nextPage { (transaction) in
            // Envía la información al presenter.
            switch transaction
            {
            case .success(let data):
                if let dataUnwrapped:[DataClient] = data {
                    completionHandler(dataUnwrapped) }
            case .fail:
                completionHandler([])
            }
        }
        
        /*
        var repos = [DataClient]()
        
        // Control page.
        if !APIGitHub.shared.isLoading, APIGitHub.shared.pagination.nextPage < APIGitHub.shared.pagination.lastPage {
            // add new page
            let searchTerm = APIGitHub.shared.getNextPage()
            
            APIGitHub.shared.search(byText: searchTerm, filter: .none) { (nextRepositories) in
                
                print("total nuevos repositorios Agregados: ", nextRepositories.count)
                
                nextRepositories.forEach({ (repository) in
                    let data = DataClient(with: repository)
                    repos.append(data)
                })
                
                completionHandler(repos)
            }
        }
        */
    }
}
