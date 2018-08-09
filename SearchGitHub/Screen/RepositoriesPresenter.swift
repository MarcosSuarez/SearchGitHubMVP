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
    func nextPage(repositories: [DataClient])
}

class RepositoriesPresenter {
    
    var delegate: RepositoriesDelegate?
    
    var hasFilterProyects: Bool = false
    
    init(withView: RepositoriesDelegate) {
        self.delegate = withView
    }
    
    func search(by text:String, filter: GHFilters) {
        
        delegate?.beginSearch()
        
        guard !text.isEmpty else {
            delegate?.finishSearch()
            return
        }
        
        GetNewRepoUseCase(withSearchTerm: text, withFilter: filter).execute { (arrayDataClient) in
            
            DispatchQueue.main.async {
                self.delegate?.resultFor(repositories: arrayDataClient)
                self.delegate?.finishSearch()
            }
        }
    }
    
    func updatePagination() {
        
        GetRepoNextPageUseCase().execute { (arrayClient) in
            
            DispatchQueue.main.async {
                self.delegate?.nextPage(repositories: arrayClient)
                self.delegate?.finishSearch()
            }
        }
    }
}
