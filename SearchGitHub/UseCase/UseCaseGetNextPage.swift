//
//  GetReposUseCase.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 8/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

class UseCaseGetNextPage {
    
    init(){}
    
    func execute(completionHandler: @escaping ([DataClient]) -> Void ) {
    
        // Llama al servicio SearchService y la respuesta la propaga.
        
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
                
                print("TOTAL repositorios en móvil: ",repos.count)
                
                completionHandler(repos)
            }
        }
    }
}
