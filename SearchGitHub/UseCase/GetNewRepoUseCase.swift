//
//  GetNewRepoUsedCase.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 8/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

class GetNewRepoUseCase {
    
    let urlGitHub:String
    
    init(gitURL: String) {
        self.urlGitHub = gitURL
    }
    
    func execute(completionHandler: @escaping ( ([DataClient]) -> Void ) ) {
        
        var repos = [DataClient]()
        
        APIGitHub.shared.search(byText: urlGitHub, filter: .none) { (nextRepositories) in

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
