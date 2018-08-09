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
    func resultFor(repositories: [DataClient])
}

class RepositoriesPresenter {
    
    var delegate: RepositoriesDelegate?
    
    var hasFilterProyects: Bool = false
    
    init(withView: RepositoriesDelegate) {
        self.delegate = withView
    }
    
    func search(by text:String, filter: APIGitHub.GHFilters) {
        
        delegate?.beginSearch()
        
        guard !text.isEmpty else {
            delegate?.finishSearch()
            return
        }
        
        APIGitHub.shared.resetPagination()
        
        let urlGit = hasFilterProyects ? text + APIGitHub.publicProyect : text
        loadData(from: urlGit)
    }
    
    func updatePagination() {
        // Control page.
        if !APIGitHub.shared.isLoading, APIGitHub.shared.pagination.nextPage < APIGitHub.shared.pagination.lastPage {
            // add new page
            loadData(from: APIGitHub.shared.pagination.nextURLpage)
        }
    }
    
    func loadData(from urlGitHub: String) {
        
        let getData = GetNewRepoUseCase(gitURL: urlGitHub)
        
        getData.execute { (dataGH) in
            
            DispatchQueue.main.async {
                self.delegate?.resultFor(repositories: dataGH)
                self.delegate?.finishSearch()
            }
        }
    }
    /*
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
 */
}
