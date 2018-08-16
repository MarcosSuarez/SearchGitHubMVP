//
//  SearchService.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 10/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

protocol SearchServiceProtocol {
    
    var modelo: SearchModelProtocol {get set}
    
    func search(searchTerm: String, filter: GHFilters, completionHandler: @escaping ((Transaction<[DataClient]?>) -> Void) )
    
    func nextPage(completionHandler: @escaping ((Transaction<[DataClient]?>) -> Void))
}

// El servicio solicita la información al modelo.
class SearchService {
    
    var modelo: SearchModelProtocol
    
    init(modelo: SearchModelProtocol) {
        self.modelo = modelo
    }
}

extension SearchService: SearchServiceProtocol {
    
    // Busca la información en el Modelo
    func search(searchTerm: String, filter: GHFilters, completionHandler: @escaping ((Transaction<[DataClient]?>) -> Void)) {
        
        modelo.network.filter = filter
        modelo.network.textSearch = searchTerm
        
        modelo.get(termSearch: searchTerm, filter: filter) { (transaccionRecibida) in
            // Envío la transacción al UseCase
            completionHandler(transaccionRecibida)
        }
    }
    
    func nextPage(completionHandler: @escaping ((Transaction<[DataClient]?>) -> Void)) {
        
        modelo.getNextPage { (transaction ) in
            completionHandler(transaction)
        }
    }
}
