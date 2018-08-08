//
//  RepositoriesPresenter.swift
//  SearchGitHub
//
//  Created by Marcos Suarez on 7/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

protocol RepositoriesDelegate {
    func beginSearch()
    func finishSearch()
    func resultFor(repositories: [DataRepoCell])
}

class RepositoriesPresenter {
    
    var delegate: RepositoriesDelegate?
    
    var hasFilterProyects: Bool = false
    
    init(delegate: RepositoriesDelegate) {
        self.delegate = delegate
    }
    
    func search(by text:String) {
        
        delegate?.beginSearch()
        
        guard !text.isEmpty else {
            delegate?.finishSearch()
            return
        }
        
        APIGitHub.resetPagination()
        
        let urlGit = hasFilterProyects ? text + APIGitHub.publicProyect : text
        loadData(from: urlGit)
    }
    
    func updatePagination() {
        // Control page.
        if !APIGitHub.isLoading, APIGitHub.pagination.nextPage < APIGitHub.pagination.lastPage {
            // add new page
            loadData(from: APIGitHub.pagination.nextURLpage)
        }
    }
    
    func loadData(from urlGitHub: String) {
        
        var repositories = [DataRepoCell]()
        
        APIGitHub.repositories(by: urlGitHub) { (nextRepositories) in
            
            print("total nuevos repositorios Agregados: ", nextRepositories.count)
            
            nextRepositories.forEach({ (repository) in
                let data = DataRepoCell(with: repository)
                repositories.append(data)
            })
            
            print("TOTAL repositorios en móvil: ",repositories.count)
            
            DispatchQueue.main.async {
                self.delegate?.resultFor(repositories: repositories)
                self.delegate?.finishSearch()
            }
            
        }
    }
}
