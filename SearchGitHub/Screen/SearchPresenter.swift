//
//  RepositoriesPresenter.swift
//  SearchGitHub
//
//  Created by Marcos Suarez on 7/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol {
    func beginSearch()
    func finishSearch()
    func resultFor(repositories: [DataClient])
    func nextPage(repositories: [DataClient])
}

class SearchPresenter {
    
    var delegate: SearchPresenterProtocol?
    
    var hasFilterProyects: Bool = false
    
    init(withView: SearchPresenterProtocol) {
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
        
        UseCaseGetNextPage().execute { (arrayClient) in
            
            DispatchQueue.main.async {
                self.delegate?.nextPage(repositories: arrayClient)
                self.delegate?.finishSearch()
            }
        }
    }
}
